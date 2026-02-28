function f(lines: string[]): string[] {
    for (let i = 0; i < lines.length; i++) {
        lines[i] = lines[i].padStart(lines[lines.length - 1].length + Math.floor((lines[lines.length - 1].length - lines[i].length) / 2));
    }
    return lines;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(["dZwbSR", "wijHeq", "qluVok", "dxjxbF"]),["dZwbSR", "wijHeq", "qluVok", "dxjxbF"]);
}

test();
