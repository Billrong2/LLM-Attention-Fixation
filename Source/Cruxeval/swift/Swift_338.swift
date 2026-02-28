func f(my_dict: [String : Int]) -> [Int : String] {
    var result: [Int : String] = [:]
    for (key, value) in my_dict {
        result[value] = key
    }
    return result
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
            
assert(f(my_dict: ["a" : 1, "b" : 2, "c" : 3, "d" : 2]) == [1 : "a", 2 : "d", 3 : "c"])
