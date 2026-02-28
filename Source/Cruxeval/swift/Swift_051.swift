extension Int: Error {}
        
/// 
func f(num: Int) -> Result<String, Int> {
    let s = String(repeating: "<", count: 10)
    if num % 2 == 0 {
        return Result.success(s)
    } else {
        return Result.failure(num - 1)
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
            
assert(f(num: 21) == .failure(20))
