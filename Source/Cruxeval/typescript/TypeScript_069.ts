function f(student_marks: {[key: string]: number}, name: string): number| string {
    if (name in student_marks) {
        let value = student_marks[name];
        delete student_marks[name];
        return value;
    }
    return 'Name unknown';
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate({"882afmfp": 56}, "6f53p"),"Name unknown");
}

test();
