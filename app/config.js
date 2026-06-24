const fs = require("fs");
const path = require("path");

const DEFAULT_PORT = 3000;
const ENV_FILE_PATH = path.resolve(__dirname, "..", ".env");
const PACKAGE_JSON_PATH = path.resolve(__dirname, "..", "package.json");

function loadEnvFile(filePath) {
  if (!fs.existsSync(filePath)) {
    return;
  }

  const fileContents = fs.readFileSync(filePath, "utf8");
  const lines = fileContents.split(/\r?\n/);

  for (const line of lines) {
    const trimmedLine = line.trim();

    if (!trimmedLine || trimmedLine.startsWith("#")) {
      continue;
    }

    const separatorIndex = trimmedLine.indexOf("=");

    if (separatorIndex === -1) {
      continue;
    }

    const key = trimmedLine.slice(0, separatorIndex).trim();
    const value = trimmedLine.slice(separatorIndex + 1).trim();

    if (key && process.env[key] === undefined) {
      process.env[key] = value;
    }
  }
}

loadEnvFile(ENV_FILE_PATH);

function parsePort(value) {
  const parsedValue = Number.parseInt(value, 10);

  if (Number.isInteger(parsedValue) && parsedValue > 0) {
    return parsedValue;
  }

  return DEFAULT_PORT;
}

function readPackageMetadata() {
  try {
    const fileContents = fs.readFileSync(PACKAGE_JSON_PATH, "utf8");
    return JSON.parse(fileContents);
  } catch (error) {
    return {
      name: "github-actions-self-hosted-runner-lab",
      version: "0.1.0"
    };
  }
}

function parseBoolean(value) {
  return ["1", "true", "yes", "on"].includes(String(value || "").toLowerCase());
}

function readRunnerName(value) {
  const runnerName = String(value || "").trim();
  return runnerName || undefined;
}

const packageMetadata = readPackageMetadata();

module.exports = {
  appName: process.env.APP_NAME || packageMetadata.name || "github-actions-self-hosted-runner-lab",
  appVersion: packageMetadata.version || "0.1.0",
  ci: parseBoolean(process.env.CI),
  githubActions: parseBoolean(process.env.GITHUB_ACTIONS),
  host: process.env.HOST || "0.0.0.0",
  nodeEnv: process.env.NODE_ENV || "development",
  port: parsePort(process.env.PORT),
  runnerName: readRunnerName(process.env.RUNNER_NAME)
};
