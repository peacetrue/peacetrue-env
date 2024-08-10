import {getEnvPublicPrefix, setEnvPublicPrefix} from "../src";

describe('peacetrue-env', () => {
  it('default', () => {
    expect(getEnvPublicPrefix()).toEqual("");
  });
  it('PUBLIC_PREFIX', () => {
    let prefix = "NEXT_PUBLIC";
    setEnvPublicPrefix(prefix);
    expect(getEnvPublicPrefix()).toEqual(prefix);
  });
});
