/// 
func f(value: String) -> String {
    var ls = Array(value)
    ls.append(contentsOf: "NHIB")
    return String(ls)
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
            
assert(f(value: "ruam") == "ruamNHIB")
