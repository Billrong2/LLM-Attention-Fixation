function f(sentence: string): string {
    let ls: string[] = Array.from(sentence);
    for(let letter of ls) {
        if (!(letter.charAt(0) === letter.charAt(0).toUpperCase() && letter.charAt(0).match(/[a-z]/i))) {
            let index = ls.indexOf(letter);
            if (index !== -1) {
                ls.splice(index, 1);
            }
        }
    }
    return ls.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("XYZ LittleRedRidingHood LiTTleBIGGeXEiT fault"),"XYZLtRRdnHodLTTBIGGeXET fult");
}

test();
