import Foundation

func f(text: String) -> String {
    return text.split(separator: " ").map { String($0).trimmingCharacters(in: CharacterSet.whitespaces) }.joined(separator: " ")
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
            
assert(f(text: "pvtso") == "pvtso")
