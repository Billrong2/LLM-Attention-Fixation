function f(text: string): string {
    let textArr = text.split('');
    for (let i = 0; i < textArr.length; i++) {
        if (i % 2 === 1) {
            textArr[i] = textArr[i].toUpperCase() === textArr[i] ? textArr[i].toLowerCase() : textArr[i].toUpperCase();
        }
    }
    return textArr.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Hey DUdE THis $nd^ &*&this@#"),"HEy Dude tHIs $Nd^ &*&tHiS@#");
}

test();
