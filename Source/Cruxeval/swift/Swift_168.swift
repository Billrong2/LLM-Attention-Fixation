/// 
func f(text: String, new_value: String, index: Int) -> String {
    var key = [Character: Character]()
    key[text[text.index(text.startIndex, offsetBy: index)]] = new_value[new_value.startIndex]
    let result = String(text.map { key[$0] ?? $0 })
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
            
assert(f(text: "spain", new_value: "b", index: 4) == "spaib")
