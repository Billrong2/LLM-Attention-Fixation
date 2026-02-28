function f(s: string): string {
    let count: number = s.length - 1;
    let reverse_s: string = s.split('').reverse().join('');
    while (count > 0 && reverse_s.match(/sea/g) === null) {
        count--;
        reverse_s = reverse_s.substring(0, count);
    }
    return reverse_s.substring(count);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("s a a b s d s a a s a a"),"");
}

test();
