/// 
func f(x: [Int]) -> Int {
    if x.isEmpty {
        return -1
    } else {
        var cache = [Int: Int]()
        for item in x {
            if let count = cache[item] {
                cache[item] = count + 1
            } else {
                cache[item] = 1
            }
        }
        return cache.values.max() ?? 0
    }
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
            
assert(f(x: [1, 0, 2, 2, 0, 0, 0, 1]) == 4)
