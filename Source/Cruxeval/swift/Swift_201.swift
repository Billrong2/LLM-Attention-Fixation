/// 
func f(text: String) -> String {
    var chars: [Character] = []
    for c in text {
        if c.isNumber {
            chars.append(c)
        }
    }
    return String(chars.reversed())
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
            
assert(f(text: "--4yrw 251-//4 6p") == "641524")
