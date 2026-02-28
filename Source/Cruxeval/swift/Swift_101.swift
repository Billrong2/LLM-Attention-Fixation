/// 
func f(array: [AnyHashable], i_num: Int, elem: AnyHashable) -> [AnyHashable] {
    var updatedArray = array
    updatedArray.insert(elem, at: i_num)
    return updatedArray
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
            
assert(f(array: [-4, 1, 0], i_num: 1, elem: 4) == [-4, 4, 1, 0])
