import Foundation

func f(text: String) -> String {
    let t = 5
    var tab = [String]()
    for i in text {
        if "aeiouy".contains(i.lowercased()) {
            tab.append(String(repeating: i.uppercased(), count: t))
        } else {
            tab.append(String(repeating: i, count: t))
        }
    }
    return tab.joined(separator: " ")
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
            
assert(f(text: "csharp") == "ccccc sssss hhhhh AAAAA rrrrr ppppp")
