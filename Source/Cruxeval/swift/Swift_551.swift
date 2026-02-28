/// 
func f(data: [String : [String]]) -> [String] {
    var members: [String] = []
    for (_, values) in data {
        for member in values {
            if !members.contains(member) {
                members.append(member)
            }
        }
    }
    return members.sorted()
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
            
assert(f(data: ["inf" : ["a", "b"], "a" : ["inf", "c"], "d" : ["inf"]]) == ["a", "b", "c", "inf"])
