function f(text){
    let textList = text.split('');
    for (let i = 0; i < textList.length; i++) {
        textList[i] = textList[i].toUpperCase() === textList[i] ?
            textList[i].toLowerCase() : textList[i].toUpperCase();
    }
    return textList.join('');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("akA?riu"),"AKa?RIU");
}

test();
