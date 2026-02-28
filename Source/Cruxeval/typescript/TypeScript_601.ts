function f(text: string): string {
    let t: number = 5;
    let tab: string[] = [];
    for (let i of text) {
        if ('aeiouy'.includes(i.toLowerCase())) {
            tab.push(i.toUpperCase().repeat(t));
        } else {
            tab.push(i.repeat(t));
        }
    }
    return tab.join(' ');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("csharp"),"ccccc sssss hhhhh AAAAA rrrrr ppppp");
}

test();
