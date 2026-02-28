function f(tags: {[key: string]: string}): string {
    let resp: string = "";
    for (let key in tags) {
        resp += key + " ";
    }
    return resp;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"3": "3", "4": "5"}),"3 4 ");
}

test();
