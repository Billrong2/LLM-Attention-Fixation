function f(text: string): string {
    let i: number = Math.floor((text.length + 1) / 2);
    let result: string[] = text.split('');
    while (i < text.length) {
        let t: string = result[i].toLowerCase();
        if (t === result[i]) {
            i++;
        } else {
            result[i] = t;
        }
        i += 2;
    }
    return result.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("mJkLbn"),"mJklbn");
}

test();
