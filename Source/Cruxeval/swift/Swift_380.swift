import Foundation

func f(text: String, delimiter: String) -> String {
    let parts = text.rpartition(separator: delimiter)
    return parts.0 + parts.2
}

extension String {
    func rpartition(separator: String) -> (String, String, String) {
        if let range = self.range(of: separator, options: .backwards) {
            let before = String(self[..<range.lowerBound])
            let match = String(self[range])
            let after = String(self[range.upperBound...])
            return (before, match, after)
        } else {
            return (self, "", "")
        }
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
            
assert(f(text: "xxjarczx", delimiter: "x") == "xxjarcz")
