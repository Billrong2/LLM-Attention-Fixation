/// 
func f(text: String, width: Int) -> String {
    var result = ""
    let lines = text.split(separator: "\n")
    for line in lines {
        result += String(repeating: " ", count: max(0, (width - line.count) / 2))
        result += line
        result += String(repeating: " ", count: max(0, (width - line.count + 1) / 2))
        result += "\n"
    }

    // Remove the very last empty line
    result = String(result.dropLast())
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
            
assert(f(text: "l\nl", width: 2) == "l \nl ")
