func f(s: String) -> String {
    guard s.count >= 6 else {
        return ""
    }
    
    let startIndex = s.index(s.startIndex, offsetBy: 3)
    let middleIndex = s.index(s.startIndex, offsetBy: 2)
    let endIndex = s.index(s.startIndex, offsetBy: 5)
    let endRange = s.index(s.startIndex, offsetBy: 6)
    
    let part1 = String(s[startIndex...])
    let part2 = String(s[middleIndex])
    let part3 = String(s[endIndex..<endRange])
    
    return part1 + part2 + part3
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
            
assert(f(s: "jbucwc") == "cwcuc")
