import Foundation

func f(text: String, sub: String) -> [Int] {
    var index: [Int] = []
    var starting = text.startIndex
    
    while let range = text.range(of: sub, range: starting..<text.endIndex) {
        let pos = text.distance(from: text.startIndex, to: range.lowerBound)
        index.append(pos)
        starting = text.index(range.lowerBound, offsetBy: sub.count)
    }
    
    return index
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
            
assert(f(text: "egmdartoa", sub: "good") == [] as [Int])
