const assert = require("node:assert/strict");
const http = require("node:http");
const { after, before, test } = require("node:test");
const { createServer } = require("../app/server");

const testConfig = {
  appName: "github-actions-self-hosted-runner-lab",
  appVersion: "0.1.0-test",
  ci: true,
  githubActions: false,
  host: "127.0.0.1",
  nodeEnv: "test",
  port: 0,
  runnerName: "wsl2-lab-runner"
};

let server;
let port;

function requestJson(pathname, method = "GET") {
  return new Promise((resolve, reject) => {
    const request = http.request(
      {
        host: "127.0.0.1",
        method,
        path: pathname,
        port
      },
      (response) => {
        let body = "";

        response.setEncoding("utf8");
        response.on("data", (chunk) => {
          body += chunk;
        });
        response.on("end", () => {
          resolve({
            body: JSON.parse(body),
            statusCode: response.statusCode
          });
        });
      }
    );

    request.on("error", reject);
    request.end();
  });
}

before(async () => {
  server = createServer(testConfig);

  await new Promise((resolve, reject) => {
    server.listen(0, testConfig.host, () => {
      port = server.address().port;
      resolve();
    });
    server.once("error", reject);
  });
});

after(async () => {
  if (!server) {
    return;
  }

  await new Promise((resolve, reject) => {
    server.close((error) => {
      if (error) {
        reject(error);
        return;
      }

      resolve();
    });
  });
});

test("GET / retorna nome da aplicação e status", async () => {
  const response = await requestJson("/");

  assert.equal(response.statusCode, 200);
  assert.deepEqual(response.body, {
    appName: testConfig.appName,
    status: "ok"
  });
});

test("GET /health retorna status ok", async () => {
  const response = await requestJson("/health");

  assert.equal(response.statusCode, 200);
  assert.deepEqual(response.body, {
    status: "ok"
  });
});

test("GET /runner-info retorna informações seguras do runner", async () => {
  const response = await requestJson("/runner-info");

  assert.equal(response.statusCode, 200);
  assert.equal(response.body.nodeVersion, process.version);
  assert.equal(response.body.platform, process.platform);
  assert.equal(response.body.arch, process.arch);
  assert.equal(response.body.ci, true);
  assert.equal(response.body.githubActions, false);
  assert.equal(response.body.runnerName, testConfig.runnerName);
});

test("GET /build-info retorna nome, versão e ambiente", async () => {
  const response = await requestJson("/build-info");

  assert.equal(response.statusCode, 200);
  assert.deepEqual(response.body, {
    appName: testConfig.appName,
    environment: testConfig.nodeEnv,
    version: testConfig.appVersion
  });
});

test("rota inexistente retorna 404", async () => {
  const response = await requestJson("/nao-existe");

  assert.equal(response.statusCode, 404);
  assert.equal(response.body.status, "not_found");
});
