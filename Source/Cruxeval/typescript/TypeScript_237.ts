function f(text: string, char: string): string {
    if (text.includes(char)) {
        const index = text.indexOf(char);
        const suff = text.substring(0, index);
        const pref = text.substring(index + char.length);
        const newPref = suff.slice(0, -char.length) + suff.slice(char.length) + char + pref;
        return suff + char + newPref;
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("uzlwaqiaj", "u"),"uuzlwaqiaj");
}

test();
