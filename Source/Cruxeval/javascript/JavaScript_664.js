function f(tags){
    let resp = "";
    for(let key in tags){
        resp += key + " ";
    }
    return resp;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"3": "3", "4": "5"}),"3 4 ");
}

test();
