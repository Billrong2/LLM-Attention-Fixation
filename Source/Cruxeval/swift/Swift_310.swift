/// 
func f(strands: [String]) -> String {
    var subs = strands
    for i in 0..<subs.count {
        let j = subs[i]
        for _ in 0..<(j.count / 2) {
            subs[i] = String(j.last!) + j.dropFirst().dropLast() + String(j.first!)
        }
    }
    return subs.joined()
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
            
assert(f(strands: ["__", "1", ".", "0", "r0", "__", "a_j", "6", "__", "6"]) == "__1.00r__j_a6__6")
