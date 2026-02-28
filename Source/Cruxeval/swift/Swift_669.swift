/// 
func f(t: String) -> String {
    let components = t.split(separator: "-").map { String($0) }
    let a = components.count > 0 ? components[0] : ""
    let b = components.count > 2 ? components[2] : ""
    
    if a.count == b.count {
        return "imbalanced"
    }
    
    return a + b
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
            
assert(f(t: "fubarbaz") == "fubarbaz")
