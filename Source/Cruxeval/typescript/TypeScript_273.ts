function f(name: string): string {
    let new_name: string = '';
    name = name.split('').reverse().join('');
    for (let i = 0; i < name.length; i++) {
        let n = name[i];
        if (n !== '.' && new_name.split('.').length < 3) {
            new_name = n + new_name;
        } else {
            break;
        }
    }
    return new_name;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(".NET"),"NET");
}

test();
