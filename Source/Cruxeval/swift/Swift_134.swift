/// 
func f(n: Int) -> String {
    var t = 0
    var b = ""
    let digits = String(n).compactMap { Int(String($0)) }
    for d in digits {
        if d == 0 {
            t += 1
        } else {
            break
        }
    }
    for _ in 0..<t {
        b += "\(1)0\(4)"
    }
    b += String(n)
    return b
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
            
assert(f(n: 372359) == "372359")
