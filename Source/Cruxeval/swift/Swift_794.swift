/// 
func f(line: String) -> String {
    var a: [Character] = []
    for c in line {
        if c.isLetter || c.isNumber {
            a.append(c)
        }
    }
    return String(a)
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
            
assert(f(line: "\"\\%$ normal chars $%~ qwet42'") == "normalcharsqwet42")
