import Foundation

func f(text: String) -> [Int] {
    var d: [Character: Int] = [:]
    for char in text.replacingOccurrences(of: "-", with: "").lowercased() {
        d[char, default: 0] += 1
    }
    let sortedDict = d.sorted { $0.value < $1.value }
    return sortedDict.map { $0.value }
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
            
assert(f(text: "x--y-z-5-C") == [1, 1, 1, 1, 1])
