import Foundation

func f(text: String, froms: String) -> String {
    let characterSet = CharacterSet(charactersIn: froms)
    let trimmedText = text.trimmingCharacters(in: characterSet)
    return String(trimmedText)
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
            
assert(f(text: "0 t 1cos ", froms: "st 0\t\n  ") == "1co")
