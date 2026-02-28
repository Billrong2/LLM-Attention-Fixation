function f(text, char1, char2){
    let t1a = [];
    let t2a = [];
    for (let i = 0; i < char1.length; i++) {
        t1a.push(char1[i]);
        t2a.push(char2[i]);
    }
    let t1 = {};
    t1a.forEach((key, i) => t1[key] = t2a[i]);
    return text.split('').map(char => t1[char] || char).join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ewriyat emf rwto segya", "tey", "dgo"),"gwrioad gmf rwdo sggoa");
}

test();
