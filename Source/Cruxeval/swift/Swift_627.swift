/// 
func f(parts: [(String, Int)]) -> [Int] {
    return Array(Dictionary(parts, uniquingKeysWith: { $1 }).values)
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
            
assert(f(parts: [("u", 1), ("s", 7), ("u", -5)]) == [-5, 7])
