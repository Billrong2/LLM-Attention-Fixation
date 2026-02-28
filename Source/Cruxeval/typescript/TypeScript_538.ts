function f(text: string, width: number): string {
    let new_text = text.slice(0, width);
    while (new_text.length < width) {
        new_text = 'z' + new_text + 'z';
        if (new_text.length > width) {
            new_text = new_text.slice(0, width);
        }
    }
    return new_text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("0574", 9),"zzz0574zz");
}

test();
