function f(text: string, changes: string): string {
    let result: string = '';
    let count: number = 0;
    let changesArr: string[] = changes.split('');
    for (let char of text) {
        result += char === 'e' ? char : changesArr[count % changesArr.length];
        count += (char !== 'e' ? 1 : 0);
    }
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("fssnvd", "yes"),"yesyes");
}

test();
