/// 
func f(lines: [String]) -> [String] {
    var newLines = lines
    for i in 0..<newLines.count {
        let padding = String(repeating: " ", count: lines.last!.count - lines[i].count)
        newLines[i] = padding + lines[i] + padding
    }
    return newLines
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
            
assert(f(lines: ["dZwbSR", "wijHeq", "qluVok", "dxjxbF"]) == ["dZwbSR", "wijHeq", "qluVok", "dxjxbF"])
