import Foundation

func f(text: String, char: String) -> Bool {
    if text.contains(char) {
        let textArray = text.split(separator: Character(char)).compactMap{ String($0).trimmingCharacters(in: .whitespaces) }
        if textArray.count > 1 {
            return true
        }
    }
    return false
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
            
assert(f(text: "only one line", char: " ") == true)
