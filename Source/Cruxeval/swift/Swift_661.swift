import Foundation

func f(letters: String, maxsplit: Int) -> String {
    let splitLetters = letters.split(separator: " ")
    let result = splitLetters.suffix(maxsplit).joined()
    return result
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
            
assert(f(letters: "elrts,SS ee", maxsplit: 6) == "elrts,SSee")
