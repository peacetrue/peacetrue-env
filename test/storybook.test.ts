import 'dotenv/config';
import '../src/storybook.setup';
import { getBaseURL } from '../src';

describe('peacetrue-env', () => {
  it('storybook', () => {
    const baseURL = getBaseURL();
    expect(baseURL).toEqual('http://localhost:8081');
  });
});
