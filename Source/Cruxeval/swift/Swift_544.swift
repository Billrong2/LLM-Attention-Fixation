import Foundation

func f(text: String) -> String {
    let a = text.components(separatedBy: "\n")
    var b = [String]()
    for i in 0..<a.count {
        let c = a[i].replacingOccurrences(of: "\t", with: "    ")
        b.append(c)
    }
    return b.joined(separator: "\n")
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
            
assert(f(text: "\t\t\ttab tab tabulates") == "            tab tab tabulates")
