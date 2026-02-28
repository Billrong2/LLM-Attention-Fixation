function f(perc, full){
    let reply = "";
    let i = 0;
    while (perc[i] === full[i] && i < full.length && i < perc.length) {
        if (perc[i] === full[i]) {
            reply += "yes ";
        } else {
            reply += "no ";
        }
        i++;
    }
    return reply;
}
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("xabxfiwoexahxaxbxs", "xbabcabccb"),"yes ");
}

test();
