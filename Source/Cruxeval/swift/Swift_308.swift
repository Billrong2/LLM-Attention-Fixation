/// 
func f(strings: [String]) -> [String : Int] {
    var occurrences: [String: Int] = [:]
    
    for string in strings {
        if occurrences[string] == nil {
            occurrences[string] = strings.filter { $0 == string }.count
        }
    }
    
    return occurrences
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
            
assert(f(strings: ["La", "Q", "9", "La", "La"]) == ["La" : 3, "Q" : 1, "9" : 1])
