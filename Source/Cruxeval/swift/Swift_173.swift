/// 
func f(list_x: [Int]) -> [Int] {
    var newList = [Int]()
    var mutableList = list_x
    for _ in 0..<list_x.count {
        newList.append(mutableList.removeLast())
    }
    return newList
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
            
assert(f(list_x: [5, 8, 6, 8, 4]) == [4, 8, 6, 8, 5])
