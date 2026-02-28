func f(arr: [String], d: [String : String]) -> [String : String] {
    var newDict = d
    var i = 1
    while i < arr.count {
        newDict[arr[i]] = arr[i - 1]
        i += 2
    }
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
            
assert(f(arr: ["b", "vzjmc", "f", "ae", "0"], d: [:] as [String : String]) == ["vzjmc" : "b", "ae" : "f"])
