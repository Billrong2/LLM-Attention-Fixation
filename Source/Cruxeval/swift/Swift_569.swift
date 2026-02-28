/// 
func f(txt: String) -> Int {
    var coincidences = [Character: Int]()
    for c in txt {
        if let count = coincidences[c] {
            coincidences[c] = count + 1
        } else {
            coincidences[c] = 1
        }
    }
    return coincidences.values.reduce(0, +)
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
            
assert(f(txt: "11 1 1") == 6)
