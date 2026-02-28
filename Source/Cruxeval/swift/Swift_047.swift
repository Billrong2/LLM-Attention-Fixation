import Foundation

func f(text: String) -> Bool {
    let length = text.count
    let half = length / 2
    let firstHalf = text.prefix(half)
    let secondHalf = text.dropFirst(half)
    if let encodedFirstHalf = firstHalf.data(using: .ascii),
       let decodedSecondHalf = String(data: encodedFirstHalf, encoding: .ascii) {
        return decodedSecondHalf == secondHalf
    }
    return false
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
            
assert(f(text: "bbbbr") == false)
