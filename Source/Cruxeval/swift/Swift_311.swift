import Foundation

func f(text: String) -> String {
    let newText = text.replacingOccurrences(of: "#", with: "1").replacingOccurrences(of: "$", with: "5")
    let numeric = CharacterSet.decimalDigits
    return newText.rangeOfCharacter(from: numeric.inverted) == nil ? "yes" : "no"
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
            
assert(f(text: "A") == "no")
