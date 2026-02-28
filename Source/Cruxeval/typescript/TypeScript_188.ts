function f(strings: string[]): string[] {
    const new_strings: string[] = [];
    strings.forEach(string => {
        const first_two = string.slice(0, 2);
        if (first_two.startsWith('a') || first_two.startsWith('p')) {
            new_strings.push(first_two);
        }
    });

    return new_strings;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["a", "b", "car", "d"]),["a"]);
}

test();
