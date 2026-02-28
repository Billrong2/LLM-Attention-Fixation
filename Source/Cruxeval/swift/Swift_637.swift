/// 
func f(text: String) -> String {
    let textArray = text.split(separator: " ")
    for t in textArray {
        if !t.allSatisfy({ $0.isNumber }) {
            return "no"
        }
    }
    return "yes"
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
            
assert(f(text: "03625163633 d") == "no")
