function f(names: string[]): number {
    let count: number = names.length;
    let numberOfNames: number = 0;
    names.forEach((name) => {
        if (name.match(/^[a-zA-Z]+$/)) {
            numberOfNames++;
        }
    });
    return numberOfNames;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["sharron", "Savannah", "Mike Cherokee"]),2);
}

test();
