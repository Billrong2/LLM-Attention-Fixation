function f(text: string, speaker: string): string {
    while (text.startsWith(speaker)) {
        text = text.substring(speaker.length);
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("[CHARRUNNERS]Do you know who the other was? [NEGMENDS]", "[CHARRUNNERS]"),"Do you know who the other was? [NEGMENDS]");
}

test();
