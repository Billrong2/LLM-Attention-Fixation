import Foundation

func f(text: String, sub: String) -> Int {
    var a = 0
    var b = text.count - 1

    while a <= b {
        let c = (a + b) // 2
        if text.range(of: sub, options: .backwards, range: text.startIndex..<text.index(text.startIndex, offsetBy: c + 1)) != nil {
            a = c + 1
        } else {
            b = c - 1
        }
    }

    return a
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
            
assert(f(text: "dorfunctions", sub: "2") == 0)
