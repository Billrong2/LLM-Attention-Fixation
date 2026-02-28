function f(text: string): number[] {
    const occ: {[key: string]: number} = {};
    for (const ch of text) {
        const name: {[key: string]: string} = {'a': 'b', 'b': 'c', 'c': 'd', 'd': 'e', 'e': 'f'};
        const newName = name[ch] || ch;
        occ[newName] = (occ[newName] || 0) + 1;
    }
    
    return Object.values(occ);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("URW rNB"),[1, 1, 1, 1, 1, 1, 1]);
}

test();
