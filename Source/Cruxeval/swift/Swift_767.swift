import Foundation

func f(text: String) -> String {
    let a = text.trimmingCharacters(in: CharacterSet.whitespaces).split(separator: " ")
    for element in a {
        if !element.allSatisfy({ $0.isNumber }) {
            return "-"
        }
    }
    return a.joined(separator: " ")
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
            
assert(f(text: "d khqw whi fwi bbn 41") == "-")
