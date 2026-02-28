function f(text: string, chars: string): string {
    let num_applies: number = 2;
    let extra_chars: string = '';
    for (let i = 0; i < num_applies; i++) {
        extra_chars += chars;
        text = text.replace(extra_chars, '');
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("zbzquiuqnmfkx", "mk"),"zbzquiuqnmfkx");
}

test();
