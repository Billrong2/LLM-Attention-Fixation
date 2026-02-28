/// 
func f(lst: [Int]) -> [Int] {
    var i = 0
    var new_list = [Int]()
    while i < lst.count {
        if lst[i] == lst[i+1..<lst.count].first(where: { $0 == lst[i] }) {
            new_list.append(lst[i])
            if new_list.count == 3 {
                return new_list
            }
        }
        i += 1
    }
    return new_list
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
            
assert(f(lst: [0, 2, 1, 2, 6, 2, 6, 3, 0]) == [0, 2, 2])
