function f(text, tabsize) {
    return text.split('\n').map(t => t.replace(/\t/g, ' '.repeat(tabsize))).join('\n');
}

const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(`	f9
	ldf9
	adf9!
	f9?`, 1),` f9
 ldf9
 adf9!
 f9?`);
}

test();
