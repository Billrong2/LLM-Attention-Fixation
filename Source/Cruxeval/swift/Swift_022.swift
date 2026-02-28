extension Int: Error {}
        
/// 
func f(a: Int) -> Result<[Int], Int> {
if a == 0 {
        return .success([0])
    }
    var result = [Int]()
    var tempA = a
    while tempA > 0 {
        result.append(tempA % 10)
        tempA = tempA / 10
    }
    result.reverse()
    let resultString = result.map { String($0) }.joined()
    guard let resultInt = Int(resultString) else {
        return .failure(a)
    }
    return .success(result)
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
            
assert(f(a: 0) == .success([0]))
