/// 
func f(text: String, new_ending: String) -> String {
    var result = Array(text)
    result.append(contentsOf: new_ending)
    return String(result)
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
            
assert(f(text: "jro", new_ending: "wdlp") == "jrowdlp")
