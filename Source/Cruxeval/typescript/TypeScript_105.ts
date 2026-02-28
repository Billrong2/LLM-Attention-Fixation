function f(text: string): string {
    if (!isTitleCase(text)) {
        return toTitleCase(text);
    }
    return text.toLowerCase();
}

function isTitleCase(text: string): boolean {
    return text.split(' ').every(word => word[0] === word[0].toUpperCase() && word.slice(1) === word.slice(1).toLowerCase());
}

function toTitleCase(text: string): string {
    return text.split(' ').map(word => word[0].toUpperCase() + word.slice(1).toLowerCase()).join(' ');
}

declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate("PermissioN is GRANTed"),"Permission Is Granted");
}

test();
