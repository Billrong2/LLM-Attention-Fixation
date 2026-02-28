/// 
func f(original: [Int : Int], string: [Int : Int]) -> [Int : Int] {
    var temp = original
    for (a, b) in string {
        temp[b] = a
    }
    return temp
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
            
assert(f(original: [1 : -9, 0 : -7], string: [1 : 2, 0 : 3]) == [1 : -9, 0 : -7, 2 : 1, 3 : 0])
