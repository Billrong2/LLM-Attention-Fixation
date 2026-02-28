/// 
func f(title: String) -> String {
    return title.lowercased()
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
            
assert(f(title: "   Rock   Paper   SCISSORS  ") == "   rock   paper   scissors  ")
