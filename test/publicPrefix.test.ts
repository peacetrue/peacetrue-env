/**@deprecated */
import {getEnvPublicPrefix, setEnvPublicPrefix} from '../src';

xdescribe('peacetrue-env', () => {
  xit('default', () => {
    expect(getEnvPublicPrefix()).toEqual('');
  });
  xit('PUBLIC_PREFIX', () => {
    let prefix = 'NEXT_PUBLIC';
    setEnvPublicPrefix(prefix);
    expect(getEnvPublicPrefix()).toEqual(prefix);
  });
});
