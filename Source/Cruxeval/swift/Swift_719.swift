func f(code: String) -> String {
    var lines = code.split(separator: "]")
    var result = [String]()
    var level = 0
    for line in lines {
        if let firstChar = line.first {
            let spaces = String(repeating: "  ", count: level)
            let modifiedLine = String(firstChar) + " " + spaces + String(line.dropFirst())
            result.append(modifiedLine)
            level += line.filter { "{" == String($0) }.count - line.filter { "}" == String($0) }.count
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
            
assert(f(code: "if (x) {y = 1;} else {z = 1;}") == "i f (x) {y = 1;} else {z = 1;}")
