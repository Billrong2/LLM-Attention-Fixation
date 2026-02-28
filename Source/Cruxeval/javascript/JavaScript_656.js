function f(letters){
    let a = [];
    for(let i = 0; i < letters.length; i++){
        if(a.includes(letters[i])){
            return 'no';
        }
        a.push(letters[i]);
    }
    return 'yes';
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["b", "i", "r", "o", "s", "j", "v", "p"]),"yes");
}

test();
