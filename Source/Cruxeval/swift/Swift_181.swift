/// 
func f(s: String) -> (String, Int) {
    var count = 0
    var digits = ""
    for c in s {
        if c.isNumber {
            count += 1
            digits += String(c)
        }
    }
    return (digits, count)
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
            
assert(f(s: "qwfasgahh329kn12a23") == ("3291223", 7))
