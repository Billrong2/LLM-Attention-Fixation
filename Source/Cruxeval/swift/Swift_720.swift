func f(items: [String], item: String) -> Int {
    var mutableItems = items
    while let lastItem = mutableItems.last, lastItem == item {
        mutableItems.removeLast()
    }
    mutableItems.append(item)
    return mutableItems.count
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
            
assert(f(items: ["bfreratrrbdbzagbretaredtroefcoiqrrneaosf"], item: "n") == 2)
