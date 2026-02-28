function partitionString(s: string, p: string): [string, string, string] {
    const index = s.indexOf(p);
    if (index === -1) {
        return [s, '', ''];
    }
    return [s.slice(0, index), p, s.slice(index + p.length)];
}

function f(s: string, p: string): string {
    const arr = partitionString(s, p);
    const part_one = arr[0].length;
    const part_two = arr[1].length;
    const part_three = arr[2].length;

    if (part_one >= 2 && part_two <= 2 && part_three >= 2) {
        return (arr[0].split('').reverse().join('') + arr[1] + arr[2].split('').reverse().join('') + '#');
    }

    return (arr[0] + arr[1] + arr[2]);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("qqqqq", "qqq"),"qqqqq");
}

test();
