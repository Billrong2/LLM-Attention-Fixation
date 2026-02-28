function f(list_: string[], num: number): string[] {
    let temp: string[] = [];
    for(let i of list_) {
        temp.push(`${i},`.repeat(Math.floor(num / 2)));
    }
    return temp;
}

declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["v"], 1),[""]);
}

test();
