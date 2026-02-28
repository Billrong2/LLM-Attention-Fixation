function f(text: string): string {
    let textArr = text.split(',');
    textArr.shift();
    textArr.unshift(textArr.splice(textArr.indexOf('T'), 1)[0]);
    return 'T' + ',' + textArr.join(',');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("Dmreh,Sspp,T,G ,.tB,Vxk,Cct"),"T,T,Sspp,G ,.tB,Vxk,Cct");
}

test();
