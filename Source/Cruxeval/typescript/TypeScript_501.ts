function f(text: string, char: string): string {
    let index: number = text.lastIndexOf(char);
    let result: string[] = text.split('');
    while (index > 0) {
        result[index] = result[index - 1];
        result[index - 1] = char;
        index -= 2;
    }
    return result.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("qpfi jzm", "j"),"jqjfj zm");
}

test();
