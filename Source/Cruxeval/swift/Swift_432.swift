extension Bool: Error {}

func f(length: Int, text: String) -> Result<String, Bool> {
    if text.count == length {
        return .success(String(text.reversed()))
    }
    return .failure(false)
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
            
assert(f(length: -5, text: "G5ogb6f,c7e.EMm") == .failure(false))
