/// 
func f(total: [String], arg: String) -> [String] {
    var totalVar = total
    for letter in arg {
        totalVar.append(String(letter))
    }
    return totalVar
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
            
assert(f(total: ["1", "2", "3"], arg: "nammo") == ["1", "2", "3", "n", "a", "m", "m", "o"])
