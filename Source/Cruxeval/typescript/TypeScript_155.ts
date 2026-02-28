function f(ip: string, n: number): string {
    let i: number = 0;
    let out: string = '';
    for (let c of ip) {
        if (i === n) {
            out += '\n';
            i = 0;
        }
        i += 1;
        out += c;
    }
    return out;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("dskjs hjcdjnxhjicnn", 4),"dskj\ns hj\ncdjn\nxhji\ncnn");
}

test();
