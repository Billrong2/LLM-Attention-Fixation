/// 
func f(string: String, encryption: Int) -> String {
    if encryption == 0 {
        return string
    } else {
        return string.uppercased()
    }
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
            
assert(f(string: "UppEr", encryption: 0) == "UppEr")
