let ENV_PUBLIC_PREFIX = '';

export function setEnvPublicPrefix(prefix: string) {
  ENV_PUBLIC_PREFIX = prefix;
}

export function getEnvPublicPrefix() {
  return ENV_PUBLIC_PREFIX;
}

export function getPublicEnv(name: string) {
  return process.env[ENV_PUBLIC_PREFIX + name];
}


export function isDevelopment() {
  return process.env.NODE_ENV === 'development';
}

export function isTest() {
  return process.env.NODE_ENV === 'test';
}

export function isProduction() {
  return process.env.NODE_ENV === 'production';
}
