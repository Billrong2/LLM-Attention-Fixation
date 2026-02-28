function f(text){
    let k = 0;
    let l = text.length - 1;
    while (!text[l].match(/[a-z]/i)) {
        l--;
    }
    while (!text[k].match(/[a-z]/i)) {
        k++;
    }
    if (k !== 0 || l !== text.length - 1) {
        return text.slice(k, l + 1);
    } else {
        return text[0];
    }
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("timetable, 2mil"),"t");
}

test();
