function f(string: string, encryption: number): string {
    if (encryption === 0) {
        return string;
    } else {
        return string.toUpperCase().replace(/[a-zA-Z]/g, (char) => {
            const charCode = char.charCodeAt(0);
            let offset = 13;

            if ((char >= 'a' && char <= 'z') || (char >= 'A' && char <= 'Z')) {
                if (char <= 'Z' && char >= 'A') {
                    offset = 13 - ('Z'.charCodeAt(0) - charCode);
                    return String.fromCharCode('A'.charCodeAt(0) + offset);
                } else if (char <= 'z' && char >= 'a') {
                    offset = 13 - ('z'.charCodeAt(0) - charCode);
                    return String.fromCharCode('a'.charCodeAt(0) + offset);
                }
            }

            return char;
        });
    }
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("UppEr", 0),"UppEr");
}

test();
