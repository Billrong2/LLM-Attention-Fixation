function f(text: string): string {
    const arr = text.split(' ');
    const result: string[] = [];
    for (const item of arr) {
        if (item.endsWith('day')) {
            result.push(item + 'y');
        } else {
            result.push(item + 'day');
        }
    }
    return result.join(' ');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("nwv mef ofme bdryl"),"nwvday mefday ofmeday bdrylday");
}

test();
