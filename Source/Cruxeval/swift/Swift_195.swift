import Foundation

func f(text: String) -> String {
    var text = text
    for p in ["acs", "asp", "scn"] {
        if text.hasPrefix(p) {
            text.removeFirst(p.count)
        }
        text += " "
    }
    if text.hasPrefix(" ") {
        text.removeFirst()
    }
    return String(text.dropLast())
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
            
assert(f(text: "ilfdoirwirmtoibsac") == "ilfdoirwirmtoibsac  ")
