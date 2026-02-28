/// 
func f(text: String, changes: String) -> String {
    var result = ""
    var count = 0
    var changesArray = Array(changes)
    
    for char in text {
        result += char == "e" ? String(char) : String(changesArray[count % changesArray.count])
        count += (char != "e" ? 1 : 0)
    }
    
    return result
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
            
assert(f(text: "fssnvd", changes: "yes") == "yesyes")
