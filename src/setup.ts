import { getPublicEnv, setEnvPublicPrefix } from './publicPrefix';
import { PROP_BASE_URL, setBaseURL } from './baseURL';

export function setup(prefix: string) {
  setEnvPublicPrefix(prefix);
  let publicEnv = getPublicEnv(PROP_BASE_URL);
  publicEnv && setBaseURL(publicEnv);
}
