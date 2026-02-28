function f(t){
    const parts = t.split('-');
    const a = parts.slice(0, -1).join('-');
    const sep = '-';
    const b = parts[parts.length - 1];
    
    if (b.length === a.length) {
        return 'imbalanced';
    }
    
    return a + b.split(sep).join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("fubarbaz"),"fubarbaz");
}

test();
