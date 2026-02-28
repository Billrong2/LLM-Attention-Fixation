func f(st: String) -> String {
    let lowercasedSt = st.lowercased()
    
    if let iIndex = lowercasedSt.lastIndex(of: "i") {
        if let hIndex = lowercasedSt[..<iIndex].lastIndex(of: "h") {
            if lowercasedSt.distance(from: hIndex, to: iIndex) >= 0 {
                return "Hey"
            }
        }
    }
    
    return "Hi"
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
            
assert(f(st: "Hi there") == "Hey")
