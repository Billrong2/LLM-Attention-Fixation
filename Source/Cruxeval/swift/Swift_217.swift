import Foundation

func f(string: String) -> String {
    if string.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil {
        return "ascii encoded is allowed for this language"
    }
    return "more than ASCII"
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
            
assert(f(string: "Str zahrnuje anglo-ameriæske vasi piscina and kuca!") == "more than ASCII")
