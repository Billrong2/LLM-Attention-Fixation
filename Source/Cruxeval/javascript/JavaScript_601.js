function f(text){
    let t = 5;
    let tab = [];
    for(let i=0; i<text.length; i++){
        let char = text[i];
        if('aeiouy'.includes(char.toLowerCase())){
            tab.push(char.toUpperCase().repeat(t));
        } else {
            tab.push(char.repeat(t));
        }
    }
    return tab.join(' ');
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("csharp"),"ccccc sssss hhhhh AAAAA rrrrr ppppp");
}

test();
