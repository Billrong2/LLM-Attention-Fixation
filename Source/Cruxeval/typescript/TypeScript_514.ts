function f(text: string): string {
    const words = text.split(' ');
    words.forEach(item => {
        text = text.split('-' + item).join(' ')
                     .split(item + '-').join(' ');
    });
    return text.replace(/^-|-$/g, '').trim();
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("-stew---corn-and-beans-in soup-.-"),"stew---corn-and-beans-in soup-.");
}

test();
