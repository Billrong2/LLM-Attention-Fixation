import Foundation

func f(text: String) -> String {
    var newText = text.trimmingCharacters(in: .whitespacesAndNewlines)
    if newText.contains("cd") {
        newText = newText.replacingOccurrences(of: "cd", with: " ")
    }
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
            
assert(f(text: "lorem ipsum") == "lorem ipsum")
