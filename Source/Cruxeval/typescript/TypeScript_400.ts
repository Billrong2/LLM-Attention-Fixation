function f(multi_string: string): string {
    const cond_string = multi_string.split(' ').map(x => x.split('').every(char => char.charCodeAt(0) < 128));
    if (cond_string.includes(true)) {
        return multi_string.split(' ').filter(x => x.split('').every(char => char.charCodeAt(0) < 128)).join(', ');
    }
    return '';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("I am hungry! eat food."),"I, am, hungry!, eat, food.");
}

test();
