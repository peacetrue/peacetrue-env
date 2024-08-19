import { setBaseURL } from './baseURL';

export function setNextBaseURL() {
  setBaseURL(process.env.NEXT_PUBLIC_BASE_URL);
}
