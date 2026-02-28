function f(chemicals: string[], num: number): string[] {
    let fish: string[] = chemicals.slice(1);
    chemicals.reverse();
    for (let i = 0; i < num; i++) {
        fish.push(chemicals.splice(1, 1)[0]);
    }
    chemicals.reverse();
    return chemicals;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["lsi", "s", "t", "t", "d"], 0),["lsi", "s", "t", "t", "d"]);
}

test();
