import { setBaseURL } from './baseURL';
// console.info(process.env.NEXT_PUBLIC_BASE_URL)
// console.info(process.env['NEXT_PUBLIC_BASE_URL'])
// console.info(process.env['NEXT_PUBLIC' + 'BASE_URL']);
export function setNextBaseURL() {
  setBaseURL(process.env.NEXT_PUBLIC_BASE_URL);
}
