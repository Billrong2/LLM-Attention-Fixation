import Foundation

func f(s: String, char: String) -> String {
    let base = String(repeating: char, count: s.filter { $0 == Character(char) }.count + 1)
    if s.hasSuffix(base) {
        return String(s.dropLast(base.count))
    } else {
        return s
    }
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
            
assert(f(s: "mnmnj krupa...##!@#!@#$$@##", char: "@") == "mnmnj krupa...##!@#!@#$$@##")
