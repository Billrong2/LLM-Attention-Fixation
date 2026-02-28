func f(alphabet: String, s: String) -> [String] {
    let sCharacters = Array(s)
    let a = alphabet.filter { x in sCharacters.contains(x.uppercased().first ?? Character("")) }
    var result = a.map { String($0) }
    
    if s.uppercased() == s {
        result.append("all_uppercased")
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
            
assert(f(alphabet: "abcdefghijklmnopqrstuvwxyz", s: "uppercased # % ^ @ ! vz.") == [] as [String])
