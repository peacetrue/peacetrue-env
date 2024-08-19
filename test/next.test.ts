import 'dotenv/config';
import {getBaseURL} from '../src';
import "../src/next.setup"

describe('peacetrue-env', () => {
  it('NextJS', () => {
    const baseURL = getBaseURL();
    expect(baseURL).toEqual('http://localhost:8081');
  });
});
