/// 
func f(items: [Int]) -> [Int] {
    var oddPositioned: [Int] = []
    var mutableItems = items
    while mutableItems.count > 0 {
        let position = mutableItems.firstIndex(of: mutableItems.min()!) ?? 0
        mutableItems.remove(at: position)
        let item = mutableItems.remove(at: position)
        oddPositioned.append(item)
    }
    return oddPositioned
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
            
assert(f(items: [1, 2, 3, 4, 5, 6, 7, 8]) == [2, 4, 6, 8])
