function f(price: number, product: string): number {
    let inventory: string[] = ['olives', 'key', 'orange'];
    if (!inventory.includes(product)) {
        return price;
    } else {
        price *= 0.85;
        inventory.splice(inventory.indexOf(product), 1);
    }
    return price;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(8.5, "grapes"),8.5);
}

test();
