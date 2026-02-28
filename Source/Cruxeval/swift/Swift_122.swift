import Foundation

func f(string: String) -> String {
    if !string.hasPrefix("Nuva") {
        return "no"
    } else {
        return string.trimmingCharacters(in: .whitespacesAndNewlines)
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
            
assert(f(string: "Nuva?dlfuyjys") == "Nuva?dlfuyjys")
