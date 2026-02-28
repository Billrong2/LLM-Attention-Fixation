function f(text: string): string {
    const textList: string[] = text.split('');
    textList.forEach((char, i) => {
        textList[i] = char === char.toUpperCase() ? char.toLowerCase() : char.toUpperCase();
    });
    return textList.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("akA?riu"),"AKa?RIU");
}

test();
