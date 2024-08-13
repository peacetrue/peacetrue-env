import { isProduction } from './nodeEnv';

export const PROP_BASE_URL = 'BASE_URL';
export const defaultBaseURL = isProduction() ? '' : 'http://localhost:8081';
let _baseURL = defaultBaseURL;

export function setBaseURL(baseURL: string) {
  _baseURL = baseURL;
}

export function getBaseURL() {
  return _baseURL;
}
