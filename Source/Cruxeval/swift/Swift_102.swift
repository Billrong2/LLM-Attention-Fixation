/// 
func f(names: [String], winners: [String]) -> [Int] {
    var ls: [Int] = names.compactMap { winners.contains($0) ? names.firstIndex(of: $0) : nil }
    ls.sort(by: >)
    return ls
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
            
assert(f(names: ["e", "f", "j", "x", "r", "k"], winners: ["a", "v", "2", "im", "nb", "vj", "z"]) == [] as [Int])
