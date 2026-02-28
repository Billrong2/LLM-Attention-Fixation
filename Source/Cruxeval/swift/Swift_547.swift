import Foundation

func f(letters: String) -> String {
    let lettersOnly = letters.trimmingCharacters(in: CharacterSet(charactersIn: ".,!?*"))
    return lettersOnly.components(separatedBy: " ").joined(separator: "....")
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
            
assert(f(letters: "h,e,l,l,o,wo,r,ld,") == "h,e,l,l,o,wo,r,ld")
