import Foundation

func f(text: String, pref: String) -> String {
    if text.hasPrefix(pref) {
        let n = pref.count
        let startIndex = text.index(text.startIndex, offsetBy: n)
        let remainingText = String(text[startIndex...])
        let remainingParts = remainingText.split(separator: ".").dropFirst()
        let prefixParts = text.prefix(n).split(separator: ".").dropLast()
        return remainingParts.joined(separator: ".") + (remainingParts.isEmpty || prefixParts.isEmpty ? "" : ".") + prefixParts.joined(separator: ".")
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
            
assert(f(text: "omeunhwpvr.dq", pref: "omeunh") == "dq")
