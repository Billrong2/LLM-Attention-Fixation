function f(items: string, target: string): number| string {
    let splitItems = items.split(' ');
    for (let i = 0; i < splitItems.length; i++) {
        if (target.includes(splitItems[i])) {
            return items.indexOf(splitItems[i]) + 1;
        }
        if (splitItems[i].indexOf('.') === splitItems[i].length - 1 || splitItems[i].indexOf('.') === 0) {
            return 'error';
        }
    }
    return '.';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("qy. dg. rnvprt rse.. irtwv tx..", "wtwdoacb"),"error");
}

test();
