/// 
func f(lst: [Int]) -> [Int] {
    var res: [Int] = []
    
    for num in lst {
        if num % 2 == 0 {
            res.append(num)
        }
    }
    
    return lst
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
            
assert(f(lst: [1, 2, 3, 4]) == [1, 2, 3, 4])
