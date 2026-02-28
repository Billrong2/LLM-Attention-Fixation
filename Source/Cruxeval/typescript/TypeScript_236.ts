function f(array: string[]): string {
    if (array.length === 1) {
        return array[0];
    }
    let result: string[] = [...array];
    let i: number = 0;
    while (i < array.length - 1) {
        for (let j = 0; j < 2; j++) {
            result[i * 2] = array[i];
            i++;
        }
    }
    return result.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["ac8", "qk6", "9wg"]),"ac8qk6qk6");
}

test();
