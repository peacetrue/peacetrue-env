import { setBaseURL } from './baseURL';

export function setStoryBookBaseURL() {
  setBaseURL(process.env.STORYBOOK_BASE_URL);
}
