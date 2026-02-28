function f(s: string, char: string): string {
    const base = char.repeat(s.split(char).length);
    return s.replace(new RegExp(`${base}$`), '');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("mnmnj krupa...##!@#!@#$$@##", "@"),"mnmnj krupa...##!@#!@#$$@##");
}

test();
