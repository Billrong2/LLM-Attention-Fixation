function f(text: string, chars: string): string {
    if (chars) {
        text = text.replace(new RegExp(`[${chars}]+$`), '');
    } else {
        text = text.trimRight();
    }
    if (text === '') {
        return '-';
    }
    return text;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("new-medium-performing-application - XQuery 2.2", "0123456789-"),"new-medium-performing-application - XQuery 2.");
}

test();
