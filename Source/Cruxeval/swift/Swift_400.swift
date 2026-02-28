/// 
func f(multi_string: String) -> String {
    let cond_string = multi_string.split(separator: " ").map { $0.unicodeScalars.allSatisfy { $0.isASCII } }
    if cond_string.contains(true) {
        return multi_string.split(separator: " ").filter { $0.unicodeScalars.allSatisfy { $0.isASCII } }.joined(separator: ", ")
    }
    return ""
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
            
assert(f(multi_string: "I am hungry! eat food.") == "I, am, hungry!, eat, food.")
