function f(text: string, to_place: string): string {
    const after_place = text.substring(0, text.indexOf(to_place) + 1);
    const before_place = text.substring(text.indexOf(to_place) + 1);
    return after_place + before_place;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("some text", "some"),"some text");
}

test();
