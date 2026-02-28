function f(line: string, equalityMap: [string, string][]): string {
    const rs: {[key: string]: string} = {};
    equalityMap.forEach(([k, v]) => rs[k] = v);
    return line.split('').map(c => rs[c] || c).join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("abab", [["a", "b"], ["b", "a"]]),"baba");
}

test();
