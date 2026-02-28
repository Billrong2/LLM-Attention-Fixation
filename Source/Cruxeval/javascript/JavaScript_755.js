function f(replace, text, hide){
    while(text.includes(hide)){
        replace += 'ax';
        text = text.replace(hide, replace);
    }
    return text;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("###", "ph>t#A#BiEcDefW#ON#iiNCU", "."),"ph>t#A#BiEcDefW#ON#iiNCU");
}

test();
