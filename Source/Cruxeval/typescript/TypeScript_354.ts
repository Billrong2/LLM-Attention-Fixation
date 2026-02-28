function f(description: string, values: (string | undefined)[]): string {
    if (values[1] === undefined) {
        values = [values[0]];
    } else {
        values = values.slice(1);
    }
    return description.replace(/\{(\d+)\}/g, function(match, index) {
        return values[index] || match;
    });
}

declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("{0}, {0}!!!", ["R", undefined]),"R, R!!!");
}

test();
