function f(n){
    let streak = '';
    for(let c of n.toString()){
        streak += c.padEnd(parseInt(c) * 2);
    }
    return streak;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(1),"1 ");
}

test();
