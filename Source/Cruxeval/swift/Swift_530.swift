import Foundation

func f(s: String, ch: String) -> String {
    var sl = s
    if s.contains(ch.first ?? Character("")) {
        sl = s.trimmingCharacters(in: CharacterSet(charactersIn: ch))
        if sl.isEmpty {
            sl += "!?"
        }
    } else {
        return "no"
    }
    return sl
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
            
assert(f(s: "@@@ff", ch: "@") == "ff")
