/// 
func f(phrase: String) -> String {
    var result = ""
    for i in phrase {
        if !i.isLowercase {
            result.append(i)
        }
    }
    return result
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
            
assert(f(phrase: "serjgpoDFdbcA.") == "DFA.")
