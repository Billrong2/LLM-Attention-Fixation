/// 
func f(text: String) -> Bool {
    return text.allSatisfy { $0.isASCII }
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
            
assert(f(text: "wW의IV]HDJjhgK[dGIUlVO@Ess$coZkBqu[Ct") == false)
