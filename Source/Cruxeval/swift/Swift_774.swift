/// 
func f(num: Int, name: String) -> String {
    let f_str = "quiz leader = \(name), count = \(num)"
    return f_str
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
            
assert(f(num: 23, name: "Cornareti") == "quiz leader = Cornareti, count = 23")
