/**@deprecated */
import { PROP_BASE_URL, setBaseURL } from './baseURL';

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

export function setupEnvPublicPrefix(prefix: string) {
  setEnvPublicPrefix(prefix);
  let publicEnv = getPublicEnv(PROP_BASE_URL);
  publicEnv && setBaseURL(publicEnv);
}
