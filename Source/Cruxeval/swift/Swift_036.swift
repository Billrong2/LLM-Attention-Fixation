import Foundation

func f(text: String, chars: String) -> String {
    return text.trimmingCharacters(in: CharacterSet(charactersIn: chars))
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
            
assert(f(text: "ha", chars: "") == "ha")
