/// 
func f(lst: [Int]) -> [Int] {
    var sortedList = lst
    for i in (1..<sortedList.count).reversed() {
        for j in 0..<i {
            if sortedList[j] > sortedList[j + 1] {
                let temp = sortedList[j]
                sortedList[j] = sortedList[j + 1]
                sortedList[j + 1] = temp
            }
        }
    }
    return sortedList
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
            
assert(f(lst: [63, 0, 1, 5, 9, 87, 0, 7, 25, 4]) == [0, 0, 1, 4, 5, 7, 9, 25, 63, 87])
