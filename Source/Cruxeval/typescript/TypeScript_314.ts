function f(text: string): string {
    if (text.includes(',')) {
        const [before, after] = text.split(/,(.+)/);
        return after + ' ' + before;
    }
    const parts = text.split(' ');
    return ',' + parts[parts.length - 1] + ' 0';
}

declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("244, 105, -90")," 105, -90 244");
}

test();
