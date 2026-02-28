/// 
func f(array: [Int]) -> [Int] {
    var array_2: [Int] = []
    
    for i in array {
        if i > 0 {
            array_2.append(i)
        }
    }
    
    array_2.sort(by: >)
    
    return array_2
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
            
assert(f(array: [4, 8, 17, 89, 43, 14]) == [89, 43, 17, 14, 8, 4])
