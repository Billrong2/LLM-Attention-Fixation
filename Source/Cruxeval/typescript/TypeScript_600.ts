function f(array: number[]): string[] {
    const just_ns = array.map(num => 'n'.repeat(num));
    const final_output: string[] = [];
    just_ns.forEach(wipe => {
        final_output.push(wipe);
    });
    return final_output;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([]),[]);
}

test();
