import Foundation

func f(text: String, substr: String, occ: Int) -> Int {
    var text = text
    var n = 0
    
    while true {
        if let range = text.range(of: substr, options: .backwards) {
            let i = text.distance(from: text.startIndex, to: range.lowerBound)
            if n == occ {
                return i
            } else {
                n += 1
                text = String(text[..<range.lowerBound])
            }
        } else {
            break
        }
    }
    
    return -1
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
            
assert(f(text: "zjegiymjc", substr: "j", occ: 2) == -1)
