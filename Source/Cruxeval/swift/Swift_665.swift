/// 
func f(chars: String) -> String {
    var s = ""
    for ch in chars {
        if chars.filter({$0 == ch}).count % 2 == 0 {
            s += ch.uppercased()
        } else {
            s += String(ch)
        }
    }
    return s
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
            
assert(f(chars: "acbced") == "aCbCed")
