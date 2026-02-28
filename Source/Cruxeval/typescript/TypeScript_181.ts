function f(s: string): [string, number] {
    let count = 0;
    let digits = "";
    for(let c of s){
        if(!isNaN(Number(c))){
            count += 1;
            digits += c;
        } 
    }
    return [digits, count];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("qwfasgahh329kn12a23"),["3291223", 7]);
}

test();
