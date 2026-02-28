extension Int: Error {}
        
/// 
func f(array: [Result<String, Int>]) -> [Result<String, Int>] {
    var result = [Result<String, Int>]()
    for elem in array {
        if case let .success(value) = elem {
            if let intValue = Int(value), !String(abs(intValue)).contains(where: { !$0.isASCII }) {
                result.append(.success(value))
            } else if value.allSatisfy({ $0.isASCII }) {
                result.append(.success(value))
            }
        }
    }
    return result
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
            
assert(f(array: [.success("a"), .success("b"), .success("c")]) == [.success("a"), .success("b"), .success("c")])
