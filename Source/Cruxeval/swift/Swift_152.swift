import Foundation

func f(text: String) -> Int {
    let upperCaseLetters = CharacterSet.uppercaseLetters
    return text.unicodeScalars.filter { upperCaseLetters.contains($0) }.count
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
            
assert(f(text: "AAAAAAAAAAAAAAAAAAAA") == 20)
