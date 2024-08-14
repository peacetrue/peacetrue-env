import { isProduction } from './nodeEnv';

declare namespace NodeJS {
  interface ProcessEnv {
    [PROP_BASE_URL]: string;
  }
}

export const PROP_BASE_URL = 'BASE_URL';
export const defaultBaseURL = isProduction() ? '' : 'http://localhost:8081';
let _baseURL = defaultBaseURL;

export function setBaseURL(baseURL?: string) {
  baseURL != null && (_baseURL = baseURL);
}

export function getBaseURL() {
  return _baseURL;
}
