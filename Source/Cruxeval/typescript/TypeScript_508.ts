function f(text: string, sep: string, maxsplit: number): string {
    const splitted: string[] = text.split(sep, maxsplit);
    const length: number = splitted.length;
    const new_splitted: string[] = splitted.slice(0, Math.floor(length / 2)).reverse();
    new_splitted.push(...splitted.slice(Math.floor(length / 2)));
    return new_splitted.join(sep);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ertubwi", "p", 5),"ertubwi");
}

test();
