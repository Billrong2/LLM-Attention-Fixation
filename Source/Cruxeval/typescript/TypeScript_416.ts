function f(text: string, old: string, newStr: string): string {
    let index = text.lastIndexOf(old, text.indexOf(old));
    let result = text.split('');
    while (index > 0) {
        result.splice(index, old.length, newStr);
        index = text.lastIndexOf(old, index);
    }
    return result.join('');
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("jysrhfm ojwesf xgwwdyr dlrul ymba bpq", "j", "1"),"jysrhfm ojwesf xgwwdyr dlrul ymba bpq");
}

test();
