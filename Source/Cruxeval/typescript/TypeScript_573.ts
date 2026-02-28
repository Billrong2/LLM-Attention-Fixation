function f(string: string, prefix: string): string {
    if (string.startsWith(prefix)) {
        return string.substring(prefix.length);
    }
    return string;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Vipra", "via"),"Vipra");
}

test();
