import Foundation

func f(float_number: Double) -> String {
    let number = String(float_number)
    if let dotIndex = number.firstIndex(of: ".") {
        let beforeDot = number[number.startIndex..<dotIndex]
        let afterDot = number[number.index(after: dotIndex)...]
        let paddedAfterDot = afterDot.padding(toLength: max(afterDot.count, 2), withPad: "0", startingAt: 0)
        return beforeDot + "." + paddedAfterDot
    }
    return number + ".00"
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
            
assert(f(float_number: 3.121) == "3.121")
