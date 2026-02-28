/// 
func f(text: String, ch: String) -> String {
    var result = [String]()
    let lines = text.split(separator: "\n")
    
    for line in lines {
        if line.count > 0 && line.first == Character(ch) {
            result.append(line.lowercased())
        } else {
            result.append(line.uppercased())
        }
    }
    
    return result.joined(separator: "\n")
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
            
assert(f(text: "t\nza\na", ch: "t") == "t\nZA\nA")
