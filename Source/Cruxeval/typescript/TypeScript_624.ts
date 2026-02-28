function f(text: string, char: string): string {
    const charIndex = text.indexOf(char);
    let result: string[] = [];
    if (charIndex > 0) {
        result = text.slice(0, charIndex).split('');
    }
    result = result.concat(char.split(''), text.slice(charIndex + char.length).split(''));
    return result.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("llomnrpc", "x"),"xllomnrpc");
}

test();
