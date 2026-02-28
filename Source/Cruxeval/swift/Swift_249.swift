/// 
func f(s: String) -> [String : Int] {
    var count: [String: Int] = [:]
    
    for i in s {
        if i.isLowercase {
            count[String(i.lowercased())] = s.filter { $0.lowercased() == i.lowercased() }.count + (count[i.lowercased()] ?? 0)
        } else {
            count[String(i.lowercased())] = s.filter { $0.uppercased() == i.uppercased() }.count + (count[i.lowercased()] ?? 0)
        }
    }
    
    return count
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
            
assert(f(s: "FSA") == ["f" : 1, "s" : 1, "a" : 1])
