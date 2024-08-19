import {setBaseURL} from './baseURL';

/**
 * Create React App
 * @see https://create-react-app.dev/docs/adding-custom-environment-variables/
 */
export function setCRABaseURL() {
  setBaseURL(process.env.REACT_APP_BASE_URL);
}
