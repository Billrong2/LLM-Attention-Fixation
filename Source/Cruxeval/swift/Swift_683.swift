/// 
func f(dict1: [String : Int], dict2: [String : Int]) -> [String : Int] {
    var result = dict1
    for (key, value) in dict2 {
        result[key] = value
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
            
assert(f(dict1: ["disface" : 9, "cam" : 7], dict2: ["mforce" : 5]) == ["disface" : 9, "cam" : 7, "mforce" : 5])
