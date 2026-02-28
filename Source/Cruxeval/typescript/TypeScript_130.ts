function f(m: {[key: string]: number}): string {
    let items = Object.entries(m);
    for(let i = items.length - 2; i >= 0; i--) {
        let tmp = items[i];
        items[i] = items[i+1]; 
        items[i+1] = tmp;
    }
    return items.length % 2 === 0 ? 
        `${Object.keys(m)[0]}=${Object.keys(m)[1]}` : 
        `${Object.keys(m)[1]}=${Object.keys(m)[0]}`;
}

declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"l": 4, "h": 6, "o": 9}),"h=l");
}

test();
