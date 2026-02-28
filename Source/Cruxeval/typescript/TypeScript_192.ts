function f(text: string, suffix: string): string {
    let output: string = text;
    while (text.endsWith(suffix)) {
        output = text.substring(0, text.length - suffix.length);
        text = output;
    }
    return output;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("!klcd!ma:ri", "!"),"!klcd!ma:ri");
}

test();
