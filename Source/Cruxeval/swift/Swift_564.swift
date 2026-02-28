func f(lists: [[Int]]) -> [Int] {
    var mutableLists = lists
    mutableLists[1].removeAll()
    mutableLists[2].append(contentsOf: mutableLists[1])
    return mutableLists[0]
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
            
assert(f(lists: [[395, 666, 7, 4], [] as [Int], [4223, 111]]) == [395, 666, 7, 4])
