/// 
func f(bag: [Int : Int]) -> [Int : Int] {
    var values = Array(bag.values)
    var tbl: [Int: Int] = [:]
    for v in 0..<100 {
        if values.contains(v) {
            tbl[v] = values.filter { $0 == v }.count
        }
    }
    return tbl
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
            
assert(f(bag: [0 : 0, 1 : 0, 2 : 0, 3 : 0, 4 : 0]) == [0 : 5])
