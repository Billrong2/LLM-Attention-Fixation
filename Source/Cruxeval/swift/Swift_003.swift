/// 
func f(text: String, value: String) -> String {
    var textList = Array(text)
    textList.append(contentsOf: value)
    return textList.reduce("", { $0 + String($1) })
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
            
assert(f(text: "bcksrut", value: "q") == "bcksrutq")
