/// 
func f(doc: String) -> String {
    for x in doc {
        if x.isLetter {
            return x.uppercased()
        }
    }
    return "-"
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
            
assert(f(doc: "raruwa") == "R")
