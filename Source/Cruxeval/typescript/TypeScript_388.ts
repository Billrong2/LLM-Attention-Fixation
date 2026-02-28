function f(text: string, characters: string): string {
    let characterList: string[] = characters.split(' ').concat([' ', '_']);

    let i: number = 0;
    while (i < text.length && characterList.includes(text[i])) {
        i++;
    }

    return text.slice(i);
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("2nm_28in", "nm"),"2nm_28in");
}

test();
