/// 
func f(dic: [Int : Int]) -> [Int : Int] {
    var dic_op = dic
    for (key, val) in dic {
        dic_op[key] = val * val
    }
    return dic_op
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
            
assert(f(dic: [1 : 1, 2 : 2, 3 : 3]) == [1 : 1, 2 : 4, 3 : 9])
