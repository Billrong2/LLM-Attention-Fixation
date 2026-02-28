function f(items: string[]): string[] {
    let result: string[] = [];
    for(let item of items) {
        for(let d of item) {
            if (!(/\d/.test(d))) {
                result.push(d);
            }
        }
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["123", "cat", "d dee"]),["c", "a", "t", "d", " ", "d", "e", "e"]);
}

test();
