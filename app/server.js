const http = require("node:http");
const { URL } = require("node:url");
const defaultConfig = require("./config");

function sendJson(response, statusCode, payload) {
  response.writeHead(statusCode, {
    "Cache-Control": "no-store",
    "Content-Type": "application/json; charset=utf-8"
  });
  response.end(`${JSON.stringify(payload, null, 2)}\n`);
}

function buildRunnerInfo(config) {
  const payload = {
    nodeVersion: process.version,
    platform: process.platform,
    arch: process.arch,
    ci: config.ci,
    githubActions: config.githubActions
  };

  if (config.runnerName) {
    payload.runnerName = config.runnerName;
  }

  return payload;
}

function createRequestHandler(config = defaultConfig) {
  return (request, response) => {
    const requestUrl = new URL(request.url || "/", "http://localhost");

    if (request.method !== "GET") {
      return sendJson(response, 405, {
        appName: config.appName,
        message: "Método não permitido.",
        status: "error"
      });
    }

    if (requestUrl.pathname === "/") {
      return sendJson(response, 200, {
        appName: config.appName,
        status: "ok"
      });
    }

    if (requestUrl.pathname === "/health") {
      return sendJson(response, 200, {
        status: "ok"
      });
    }

    if (requestUrl.pathname === "/runner-info") {
      return sendJson(response, 200, buildRunnerInfo(config));
    }

    if (requestUrl.pathname === "/build-info") {
      return sendJson(response, 200, {
        appName: config.appName,
        environment: config.nodeEnv,
        version: config.appVersion
      });
    }

    return sendJson(response, 404, {
      appName: config.appName,
      message: "Rota não encontrada.",
      status: "not_found"
    });
  };
}

function createServer(config = defaultConfig) {
  return http.createServer(createRequestHandler(config));
}

function startServer(config = defaultConfig) {
  const server = createServer(config);

  server.on("error", (error) => {
    console.error(`Não foi possível iniciar ${config.appName} em ${config.host}:${config.port}.`);
    console.error(error.message);
    process.exit(1);
  });

  server.listen(config.port, config.host, () => {
    console.log(`[${config.appName}] ativo em http://${config.host}:${config.port} (${config.nodeEnv})`);
  });

  return server;
}

if (require.main === module) {
  startServer();
}

module.exports = {
  buildRunnerInfo,
  createRequestHandler,
  createServer,
  startServer
};
