import Foundation

func f(text: String, tab_size: Int) -> String {
    let tabReplacement = String(repeating: " ", count: tab_size)
    return text.replacingOccurrences(of: "    ", with: tabReplacement)
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
            
assert(f(text: "a", tab_size: 100) == "a")
