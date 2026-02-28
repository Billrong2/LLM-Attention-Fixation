/// 
func f(strings: [String], substr: String) -> [String] {
    let list = strings.filter { $0.hasPrefix(substr) }
    return list.sorted { $0.count < $1.count }
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
            
assert(f(strings: ["condor", "eyes", "gay", "isa"], substr: "d") == [] as [String])
