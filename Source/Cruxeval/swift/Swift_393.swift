func f(text: String) -> String {
    let ls = String(text.reversed())
    var text2 = ""
    for i in stride(from: ls.count - 3, to: 0, by: -3) {
        let substring = ls[ls.index(ls.startIndex, offsetBy: i)..<ls.index(ls.startIndex, offsetBy: i + 3)]
        text2 += substring.map { String($0) }.joined(separator: "---") + "---"
    }
    return String(text2.dropLast(3))
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
            
assert(f(text: "scala") == "a---c---s")
