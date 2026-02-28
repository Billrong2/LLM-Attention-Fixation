function f(text: string, elem: string): string[] {
    let newText = text;
    let newElem = elem;
    
    if (elem !== '') {
        while (newText.startsWith(elem)) {
            newText = newText.replace(elem, '');
        }
        while (elem.startsWith(newText)) {
            newElem = newElem.replace(newText, '');
        }
    }
    
    return [newElem, newText];
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("some", "1"),["1", "some"]);
}

test();
