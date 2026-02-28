function f(text: string): string {
    let a: string[] = text.split('\n');
    let b: string[] = [];
    for (let i = 0; i < a.length; i++) {
        let c: string = a[i].replace(/\t/g, '    ');
        b.push(c);
    }
    return b.join('\n');
}

declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("			tab tab tabulates"),"            tab tab tabulates");
}

test();
