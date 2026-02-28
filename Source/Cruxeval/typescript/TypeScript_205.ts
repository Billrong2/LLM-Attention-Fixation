function f(a: string): string {
    for (let _ = 0; _ < 10; _++) {
        for (let j = 0; j < a.length; j++) {
            if (a[j] !== '#') {
                a = a.substring(j);
                break;
            } else if (j === a.length - 1) {
                a = "";
                break;
            }
        }
    }

    while (a.charAt(a.length - 1) === '#') {
        a = a.slice(0, -1);
    }

    return a;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("##fiu##nk#he###wumun##"),"fiu##nk#he###wumun");
}

test();
