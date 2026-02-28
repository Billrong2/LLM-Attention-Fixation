/// 
func f(text: String, suffix: String) -> String {
    var output = text
    while output.hasSuffix(suffix) {
        output = String(output.dropLast(suffix.count))
    }
    return output
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
            
assert(f(text: "!klcd!ma:ri", suffix: "!") == "!klcd!ma:ri")
