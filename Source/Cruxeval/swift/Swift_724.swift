import Foundation

func f(text: String, function: String) -> [Int] {
    var cites = [text.components(separatedBy: function).joined().count]
    for character in text {
        if String(character) == function {
            cites.append(text.components(separatedBy: function).joined().count)
        }
    }
    return cites
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
            
assert(f(text: "010100", function: "010") == [3])
