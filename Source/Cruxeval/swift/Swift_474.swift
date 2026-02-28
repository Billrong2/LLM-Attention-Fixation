import Foundation

func f(txt: String, marker: Int) -> String {
    var a: [String] = []
    let lines = txt.split(separator: "\n", omittingEmptySubsequences: false)
    for line in lines {
        a.append(String(line).center(marker))
    }
    return a.joined(separator: "\n")
}

extension String {
    func center(_ width: Int) -> String {
        if width <= self.count {
            return self
        }
        let totalPadding = width - self.count
        let paddingLeft = totalPadding / 2
        let paddingRight = totalPadding - paddingLeft
        return String(repeating: " ", count: paddingLeft) + self + String(repeating: " ", count: paddingRight)
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
            
assert(f(txt: "#[)[]>[^e>\n 8", marker: -5) == "#[)[]>[^e>\n 8")
