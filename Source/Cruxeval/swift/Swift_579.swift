import Foundation

func f(text: String) -> String {
    if text.capitalized == text {
        if text.count > 1 && text.lowercased() != text {
            return text.prefix(1).lowercased() + text.dropFirst()
        }
    } else if text.rangeOfCharacter(from: CharacterSet.letters) != nil {
        return text.capitalized
    }
    
    return text
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
            
assert(f(text: "") == "")
