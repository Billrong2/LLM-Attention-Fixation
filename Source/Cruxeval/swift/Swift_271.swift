import Foundation

func f(text: String, c: String) -> String {
    var ls = Array(text)
    guard let lastIndex = text.lastIndex(of: Character(c)) else {
        fatalError("Text has no \(c)")
    }
    ls.remove(at: text.distance(from: text.startIndex, to: lastIndex))
    return String(ls)
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
            
assert(f(text: "uufhl", c: "l") == "uufh")
