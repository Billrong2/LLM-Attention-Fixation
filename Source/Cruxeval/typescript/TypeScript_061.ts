function f(text: string): string {
    const texts = text.split(' ');
    if (texts.length > 0) {
        const xtexts = texts.filter(t => /[ -~]+/.test(t) && t !== 'nada' && t !== '0');
        return xtexts.reduce((a, b) => a.length >= b.length ? a : b, '') || 'nada';
    }
    return 'nada';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(""),"nada");
}

test();
