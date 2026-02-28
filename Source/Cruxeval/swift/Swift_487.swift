/// 
func f(dict: [Int : String]) -> [Int] {
    var evenKeys: [Int] = []
    for key in dict.keys {
        if key % 2 == 0 {
            evenKeys.append(key)
        }
    }
    return evenKeys
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
            
assert(f(dict: [4 : "a"]) == [4])
