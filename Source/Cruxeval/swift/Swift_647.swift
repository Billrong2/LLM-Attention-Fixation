/// 
func f(text: String, chunks: Int) -> [String] {
    return text.split(separator: "\n").map(String.init)
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
            
assert(f(text: "/alcm@ an)t//eprw)/e!/d\nujv", chunks: 0) == ["/alcm@ an)t//eprw)/e!/d", "ujv"])
