function f(a: {[key: number]: string}, b: number, c: string, d: string, e: number| number): string| number {
    let key: string = d;
    let num: string = a[key];
    if (key in a) {
        delete a[key];
    }
    if (b > 3) {
        return c;
    } else {
        return num;
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({7: "ii5p", 1: "o3Jwus", 3: "lot9L", 2: "04g", 9: "Wjf", 8: "5b", 0: "te6", 5: "flLO", 6: "jq", 4: "vfa0tW"}, 4, "Wy", "Wy", 1.0),"Wy");
}

test();
