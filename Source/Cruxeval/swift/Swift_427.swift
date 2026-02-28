func f(s: String) -> String {
    var count = s.count - 1
    var reverse_s = String(s.reversed())
    
    while count > 0, let range = reverse_s.enumerated().filter({ $0.offset % 2 == 0 && $0.element == "s" }).last {
        count -= 1
        reverse_s = String(reverse_s.prefix(count))
    }
    
    let startIndex = reverse_s.index(reverse_s.startIndex, offsetBy: count)
    return String(reverse_s.suffix(from: startIndex))
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
            
assert(f(s: "s a a b s d s a a s a a") == "")
