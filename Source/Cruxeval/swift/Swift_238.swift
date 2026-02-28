extension Int: Error {}
        
/// 
func f(ls: [[Int]], n: Int) -> Result<[Int], Int> {
    var answer: [Int] = []
    for i in ls {
        if i[0] == n {
            answer = i
        }
    }
    return Result.success(answer)
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
            
assert(f(ls: [[1, 9, 4], [83, 0, 5], [9, 6, 100]], n: 1) == .success([1, 9, 4]))
