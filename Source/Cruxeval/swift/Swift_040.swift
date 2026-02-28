/// 
func f(text: String) -> String {
    var output = text
    output.append("#")
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
            
assert(f(text: "the cow goes moo") == "the cow goes moo#")
