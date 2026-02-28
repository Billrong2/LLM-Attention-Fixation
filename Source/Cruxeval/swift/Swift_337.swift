/// 
func f(txt: String) -> String {
    var d = [String]()
    
    for c in txt {
        if c.isNumber {
            continue
        }
        if c.isLowercase {
            d.append(String(c).uppercased())
        } else if c.isUppercase {
            d.append(String(c).lowercased())
        }
    }
    
    return d.joined()
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
            
assert(f(txt: "5ll6") == "LL")
