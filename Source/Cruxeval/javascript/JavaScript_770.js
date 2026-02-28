function center(line, length, char) {
    let lineLength = line.length;
    if (lineLength >= length) {
        return line;
    }
    let padleft = Math.floor((length - lineLength) / 2);
    let padRight = length - padleft - lineLength;
    return char.repeat(padleft) + line + char.repeat(padRight);
}

function f(line, char){
    let count = line.split(char).length - 1;
    for(let i = count+1; i > 0; i--){
        line = center(line, line.length + Math.floor(i / char.length), char);
    }
    return line;
}

const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("$78", "$"),"$$78$$");
}

test();
