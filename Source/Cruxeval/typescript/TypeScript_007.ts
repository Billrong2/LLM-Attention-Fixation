function f(list: number[]): number[] {
    const original = [...list];
    while(list.length > 1) {
        list.pop();
        for(let i = 0; i < list.length; i++) {
            list.splice(i, 1);
        }
    }
    list = [...original];
    if(list.length > 0) {
        list.shift();
    }
    return list;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([]),[]);
}

test();
