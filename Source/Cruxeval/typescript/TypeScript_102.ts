function f(names: string[], winners: string[]): number[] {
    const ls: number[] = names.filter(name => winners.includes(name)).map(name => names.indexOf(name));
    ls.sort((a, b) => b - a);
    return ls;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["e", "f", "j", "x", "r", "k"], ["a", "v", "2", "im", "nb", "vj", "z"]),[]);
}

test();
