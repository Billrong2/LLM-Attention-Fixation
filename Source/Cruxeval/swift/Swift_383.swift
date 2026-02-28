import Foundation

func f(text: String, chars: String) -> String {
    var result = Array(text)
    while result.suffix(3).contains(where: { String($0) == chars }) {
        result.removeAll { String($0) == String(chars) }
        result.removeAll { String($0) == String(chars) }
    }
    return String(result).trimmingCharacters(in: CharacterSet(charactersIn: "."))
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
            
assert(f(text: "ellod!p.nkyp.exa.bi.y.hain", chars: ".n.in.ha.y") == "ellod!p.nkyp.exa.bi.y.hain")
