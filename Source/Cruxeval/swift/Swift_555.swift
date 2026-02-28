import Foundation

func f(text: String, tabstop: Int) -> String {
    let newLine = "_____"
    var newText = text
        .replacingOccurrences(of: "\n", with: newLine)
        .replacingOccurrences(of: "\t", with: String(repeating: " ", count: tabstop))
        .replacingOccurrences(of: newLine, with: "\n")
    return newText
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
            
assert(f(text: "odes\tcode\twell", tabstop: 2) == "odes  code  well")
