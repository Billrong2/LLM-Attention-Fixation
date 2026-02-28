function f(text: string, splitter: string): string {
    return text.toLowerCase().split(' ').join(splitter);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("LlTHH sAfLAPkPhtsWP", "#"),"llthh#saflapkphtswp");
}

test();
