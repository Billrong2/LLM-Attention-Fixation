/// 
func f(d: [Int : Int]) -> [(Int, Int)] {
    let sortedPairs = d.sorted { String($0.key) + String($0.value) < String($1.key) + String($1.value) }
    return sortedPairs.filter { $0.key < $0.value }
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
            
assert(f(d: [55 : 4, 4 : 555, 1 : 3, 99 : 21, 499 : 4, 71 : 7, 12 : 6]) == [(1, 3), (4, 555)])
