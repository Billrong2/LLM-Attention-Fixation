import Foundation

func f(text: String, sep: String) -> [String] {
    let components = text.components(separatedBy: sep)
    if components.count <= 3 {
        return components
    } else {
        let lastIndex = components.count - 1
        let secondLastIndex = components.count - 2
        let remaining = components[0..<secondLastIndex].joined(separator: sep)
        return [remaining, components[secondLastIndex], components[lastIndex]]
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
            
assert(f(text: "a-.-.b", sep: "-.") == ["a", "", "b"])
