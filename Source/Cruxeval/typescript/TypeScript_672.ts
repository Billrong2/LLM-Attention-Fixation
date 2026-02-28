function f(text: string, position: number, value: string): string {
    const length: number = text.length;
    let index: number = (position % (length + 2)) - 1;
    if (index >= length || index < 0) {
        return text;
    }
    let textList: string[] = text.split('');
    textList[index] = value;
    return textList.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("1zd", 0, "m"),"1zd");
}

test();
