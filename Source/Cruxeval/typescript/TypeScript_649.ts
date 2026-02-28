function expandTabs(text: string, tabsize: number): string {
    return text.replace(/\t/g, ' '.repeat(tabsize));
}

function f(text: string, tabsize: number): string {
    return text.split('\n').map(t => expandTabs(t, tabsize)).join('\n');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("	f9\n	ldf9\n	adf9!\n	f9?", 1)," f9\n ldf9\n adf9!\n f9?");
}

test();
