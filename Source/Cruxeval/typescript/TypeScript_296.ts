function f(url: string): string {
    return url.replace('http://www.', '');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("https://www.www.ekapusta.com/image/url"),"https://www.www.ekapusta.com/image/url");
}

test();
