function f(text: string, char1: string, char2: string): string {
    const t1a: string[] = [];
    const t2a: string[] = [];
    for (let i = 0; i < char1.length; i++) {
        t1a.push(char1[i]);
        t2a.push(char2[i]);
    }
    const t1: { [key: string]: string } = {};
    t1a.forEach((key, index) => {
        t1[key] = t2a[index];
    });
    const result = text.replace(new RegExp(t1a.join('|'), 'g'), match => t1[match]);
    return result;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("ewriyat emf rwto segya", "tey", "dgo"),"gwrioad gmf rwdo sggoa");
}

test();
