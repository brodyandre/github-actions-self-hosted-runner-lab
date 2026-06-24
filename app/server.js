const http = require("http");
const { appName, host, nodeEnv, port } = require("./config");

function sendJson(response, statusCode, payload) {
  response.writeHead(statusCode, { "Content-Type": "application/json; charset=utf-8" });
  response.end(JSON.stringify(payload, null, 2));
}

const server = http.createServer((request, response) => {
  if (request.url === "/health") {
    return sendJson(response, 200, {
      app: appName,
      status: "ok",
      environment: nodeEnv,
      timestamp: new Date().toISOString()
    });
  }

  if (request.url === "/") {
    return sendJson(response, 200, {
      app: appName,
      message: "Laboratório de GitHub Actions ativo.",
      endpoints: ["/", "/health"]
    });
  }

  return sendJson(response, 404, {
    app: appName,
    message: "Rota não encontrada."
  });
});

server.on("error", (error) => {
  console.error(`Não foi possível iniciar ${appName} em ${host}:${port}.`);
  console.error(error.message);
  process.exit(1);
});

server.listen(port, host, () => {
  console.log(`[${appName}] ativo em http://${host}:${port} (${nodeEnv})`);
});
