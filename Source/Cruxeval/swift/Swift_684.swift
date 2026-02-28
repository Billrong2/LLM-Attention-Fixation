/// 
func f(text: String) -> String {
    let trans = ["\"": "9", "'": "8", ">": "3", "<": "3"]
    return text.reduce("") { $0 + (trans[String($1)] ?? String($1)) }
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
            
assert(f(text: "Transform quotations\"\nnot into numbers.") == "Transform quotations9\nnot into numbers.")
