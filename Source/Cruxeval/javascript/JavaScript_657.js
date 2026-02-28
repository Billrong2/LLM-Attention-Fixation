function f(text){
    let punctuations = '!.?,:;';
    for (let punct of punctuations) {
        if (text.split(punct).length - 1 > 1) {
            return 'no';
        }
        if (text.endsWith(punct)) {
            return 'no';
        }
    }
    return text.charAt(0).toUpperCase() + text.slice(1);
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("djhasghasgdha"),"Djhasghasgdha");
}

test();
