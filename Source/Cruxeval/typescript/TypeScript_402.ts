function f(n: number, l: string[]): { [key: number]: number } {
    let archive: { [key: number]: number } = {};
    for (let i = 0; i < n; i++) {
        const newArchive: { [key: number]: number } = {};
        l.forEach((x) => {
            newArchive[x + 10] = parseInt(x) * 10;
        });
        archive = { ...archive, ...newArchive };
    }
    return archive;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(0, ["aaa", "bbb"]),{});
}

test();
