/// 
func f(text: String) -> [String] {
    let ls = text.split(separator: " ").map { String($0) }
    let lines = ls.enumerated().filter { $0.offset % 3 == 0 }.map { $0.element }
    var res: [String] = []
    
    for i in 0..<2 {
        let ln = ls.enumerated().filter { ($0.offset - 1) % 3 == 0 }.map { $0.element }
        if 3 * i + 1 < ln.count {
            res.append(ln[3 * i..<3 * (i + 1)].joined(separator: " "))
        }
    }
    
    return lines + res
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
            
assert(f(text: "echo hello!!! nice!") == ["echo"])
