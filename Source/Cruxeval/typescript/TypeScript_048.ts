function f(names: string[]): string {
    if (names.length === 0) {
        return "";
    }
    let smallest: string = names[0];
    for (const name of names.slice(1)) {
        if (name < smallest) {
            smallest = name;
        }
    }
    const index = names.indexOf(smallest);
    names.splice(index, 1);
    return smallest;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate([]),"");
}

test();
