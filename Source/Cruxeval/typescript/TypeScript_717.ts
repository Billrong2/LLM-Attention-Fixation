function f(text: string): string {
    let k: number = 0;
    let l: number = text.length - 1;

    while (!text[l].match(/[a-zA-Z]/)) {
        l -= 1;
    }

    while (!text[k].match(/[a-zA-Z]/)) {
        k += 1;
    }

    if (k !== 0 || l !== text.length - 1) {
        return text.substring(k, l + 1);
    } else {
        return text[0];
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("timetable, 2mil"),"t");
}

test();
