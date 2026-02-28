/// 
func f(values: [String], value: Int) -> [String : Int] {
    var newDict = [String: Int]()
    let sortedValues = values.joined().sorted().map { String($0) }.joined()
    
    for val in values {
        newDict[val] = value
    }
    
    newDict[sortedValues] = value * 3
    
    return newDict
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
            
assert(f(values: ["0", "3"], value: 117) == ["0" : 117, "3" : 117, "03" : 351])
