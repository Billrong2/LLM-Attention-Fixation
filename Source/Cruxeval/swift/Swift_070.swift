/// 
func f(x: String) -> Int {
    var a = 0
    for i in x.split(separator: " ") {
        a += i.count * 2
    }
    return a
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
            
assert(f(x: "999893767522480") == 30)
