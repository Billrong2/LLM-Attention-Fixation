import Foundation

func f(sequence: String, value: String) -> String {
    guard let valueIndex = sequence.firstIndex(of: Character(value)) else {
        return sequence
    }
    
    let index = max(sequence.distance(from: sequence.startIndex, to: valueIndex) - sequence.count / 3, 0)
    let startIndex = sequence.index(sequence.startIndex, offsetBy: index)
    
    var result = ""
    for (j, v) in sequence[startIndex...].enumerated() {
        if v == "+" {
            result += value
        } else {
            result += String(v)
        }
    }
    
    return result
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
            
assert(f(sequence: "hosu", value: "o") == "hosu")
