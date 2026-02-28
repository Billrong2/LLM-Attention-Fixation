function f(list1: number[], list2: number[]): number| string {
    let l: number[] = list1.slice();
    while (l.length > 0) {
        if (list2.includes(l[l.length - 1])) {
            l.pop();
        } else {
            return l[l.length - 1];
        }
    }
    return 'missing';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([0, 4, 5, 6], [13, 23, -5, 0]),6);
}

test();
