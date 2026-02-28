function f(dic: {[key: string]: number}): [string, number][] {
    const sortedItems = Object.entries(dic).sort((a, b) => a[0].toString().length - b[0].toString().length).slice(0, -1);
    sortedItems.forEach(([k, v]) => delete dic[k]);
    return Object.entries(dic);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"11": 52, "65": 34, "a": 12, "4": 52, "74": 31}),[["74", 31]]);
}

test();
