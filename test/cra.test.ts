import 'dotenv/config';
import {getBaseURL} from '../src';
import "../src/cra.setup"

describe('peacetrue-env', () => {
  it('CRA', () => {
    const baseURL = getBaseURL();
    expect(baseURL).toEqual('http://localhost:8081');
  });
});
