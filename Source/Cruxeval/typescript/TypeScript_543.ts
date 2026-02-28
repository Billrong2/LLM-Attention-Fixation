function f(item: string): string {
    let modified = item.replace('. ', ' , ').replace('&#33; ', '! ').replace('. ', '? ').replace('. ', '. ');
    return modified[0].toUpperCase() + modified.substring(1);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(".,,,,,. منبت"),".,,,,, , منبت");
}

test();
