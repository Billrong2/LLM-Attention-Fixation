function f(names: string): string {
    let parts = names.split(',');
    for(let i = 0; i < parts.length; i++) {
        parts[i] = parts[i].replace(' and', '+').split(' ').map((s)=>s.charAt(0).toUpperCase()+s.substring(1)).join(' ').replace('+', ' and');
    }
    return parts.join(', ');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("carrot, banana, and strawberry"),"Carrot,  Banana,  and Strawberry");
}

test();
