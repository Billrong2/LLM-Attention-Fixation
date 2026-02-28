/// 
func f(n: String) -> String {
    let length = n.count + 2
    var revn = Array(n)
    let result = String(revn)
    revn.removeAll()
    return result + String(repeating: "!", count: length)
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
            
assert(f(n: "iq") == "iq!!!!")
