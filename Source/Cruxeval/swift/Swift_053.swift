/// 
func f(text: String) -> [Int] {
    var occ: [String: Int] = [:]
    for ch in text {
        let name = ["a": "b", "b": "c", "c": "d", "d": "e", "e": "f"]
        let updatedName = name[String(ch)] ?? String(ch)
        occ[updatedName, default: 0] += 1
    }
    return occ.values.sorted()
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
            
assert(f(text: "URW rNB") == [1, 1, 1, 1, 1, 1, 1])
