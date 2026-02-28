/// 
func f(text: String) -> (Int, Int) {
    var ws = 0
    for s in text {
        if s.isWhitespace {
            ws += 1
        }
    }
    return (ws, text.count)
}


func ==(left: [(Int, Int)], right: [(Int, Int)]) -> Bool {
    if left.count != right.count {
        return false
    }
    for (l, r) in zip(left, right) {
        if l != r {
            return false
        }
    }
    return true
}
            
assert(f(text: "jcle oq wsnibktxpiozyxmopqkfnrfjds") == (2, 34))
