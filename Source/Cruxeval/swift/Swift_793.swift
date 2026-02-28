/// 
func f(lst: [Int], start: Int, end: Int) -> Int {
    var count = 0
    for i in start..<end {
        for j in i..<end {
            if lst[i] != lst[j] {
                count += 1
            }
        }
    }
    return count
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
            
assert(f(lst: [1, 2, 4, 3, 2, 1], start: 0, end: 3) == 3)
