function f(bots: string[]): number {
    const clean: string[] = [];
    for (const username of bots) {
        if (username !== username.toUpperCase()) {
            clean.push(username.slice(0, 2) + username.slice(-3));
        }
    }
    return clean.length;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["yR?TAJhIW?n", "o11BgEFDfoe", "KnHdn2vdEd", "wvwruuqfhXbGis"]),4);
}

test();
