/// 
func f(text: String, n: Int) -> String {
    if n < 0 || text.count <= n {
        return text
    }
    let result = text.prefix(n)
    var i = result.count - 1
    while i >= 0 {
        if result[result.index(result.startIndex, offsetBy: i)] != text[text.index(text.startIndex, offsetBy: i)] {
            break
        }
        i -= 1
    }
    return String(text.prefix(i + 1))
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
            
assert(f(text: "bR", n: -1) == "bR")
