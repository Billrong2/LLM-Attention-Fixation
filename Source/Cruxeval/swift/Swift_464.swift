extension String: Error {}
        
/// 
func f(ans: String) -> Result<Int, String> {
    if let total = Int(ans) {
        var result = total * 4 - 50
        result -= ans.filter { !"02468".contains($0) }.count * 100
        return .success(result)
    }
    return .failure("NAN")
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
            
assert(f(ans: "0") == .success(-50))
