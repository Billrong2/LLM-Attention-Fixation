/// 
func f(ints: [Int]) -> String {
    var counts = Array(repeating: 0, count: 301)
    
    for i in ints {
        counts[i] += 1
    }
    
    var r = [String]()
    for i in 0..<counts.count {
        if counts[i] >= 3 {
            r.append(String(i))
        }
    }
    counts.removeAll()
    return r.joined(separator: " ")
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
            
assert(f(ints: [2, 3, 5, 2, 4, 5, 2, 89]) == "2")
