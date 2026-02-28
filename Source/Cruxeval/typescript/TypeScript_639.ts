function f(perc: string, full: string): string {
    let reply: string = "";
    let i: number = 0;
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
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("xabxfiwoexahxaxbxs", "xbabcabccb"),"yes ");
}

test();
