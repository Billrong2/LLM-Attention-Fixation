/// 
func f(dictionary: [Int : Int?]) -> [Int : Int?] {
    return dictionary
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
            
assert(f(dictionary: [563 : 555, 133 : nil]) == [563 : 555, 133 : nil])
