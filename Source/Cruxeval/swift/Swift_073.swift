func f(row: String) -> (Int, Int) {
    let oneCount = row.filter { $0 == "1" }.count
    let zeroCount = row.filter { $0 == "0" }.count
    return (oneCount, zeroCount)
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
            
assert(f(row: "100010010") == (3, 6))
