function f(array){
    let just_ns = array.map(num => 'n'.repeat(num));
    let final_output = [];
    just_ns.forEach(wipe => {
        final_output.push(wipe);
    });
    return final_output;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([]),[]);
}

test();
