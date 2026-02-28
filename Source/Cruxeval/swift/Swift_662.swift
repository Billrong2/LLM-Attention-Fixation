/// 
func f(values: [String]) -> [String] {
    var names = ["Pete", "Linda", "Angela"]
    names.append(contentsOf: values)
    names.sort()
    return names
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
            
assert(f(values: ["Dan", "Joe", "Dusty"]) == ["Angela", "Dan", "Dusty", "Joe", "Linda", "Pete"])
