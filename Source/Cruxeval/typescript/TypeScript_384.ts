function f(text: string, chars: string): string {
    let new_text: string[] = text.split('');
    let charArray: string[] = chars.split('');
    
    while (new_text.length > 0 && text.length > 0) {
        if (charArray.includes(new_text[0])) {
            new_text.shift();
        } else {
            break;
        }
    }
    
    return new_text.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("asfdellos", "Ta"),"sfdellos");
}

test();
