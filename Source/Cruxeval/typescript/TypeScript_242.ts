function f(book: string): string {
    let a = book.split(':');
    if (a[0].split(' ').slice(-1)[0] === a[1].split(' ')[0]) {
        return f(a[0].split(' ').slice(0, -1).join(' ') + ' ' + a[1]);
    }
    return book;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("udhv zcvi nhtnfyd :erwuyawa pun"),"udhv zcvi nhtnfyd :erwuyawa pun");
}

test();
