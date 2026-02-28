function f(text: string): string {
    let ans: string = '';
    while (text !== '') {
        const index = text.indexOf('(');
        if (index === -1) {
            ans += text;
            break;
        }
        const x = text.substring(0, index);
        const sep = text[index];
        const remainingText = text.substring(index + 1);
        ans = x + sep.replace('(', '|') + ans;
        ans = ans + remainingText[0] + ans;
        text = remainingText.slice(1);
    }
    return ans;
}
declare var require: any;
const assert = require('node:assert');


function test() {
  let candidate = f;
  assert.deepEqual(candidate(""),"");
}

test();
