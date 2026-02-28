/// 
func f(text: String, space_symbol: String, size: Int) -> String {
    let spaces = String(repeating: space_symbol, count: max(size - text.count, 0))
    return text + spaces
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
            
assert(f(text: "w", space_symbol: "))", size: 7) == "w))))))))))))")
