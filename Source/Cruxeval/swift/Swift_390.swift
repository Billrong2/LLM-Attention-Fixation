import Foundation

func f(text: String) -> Int? {
    if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).count
    }
    return nil
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
            
assert(f(text: " \t ") == 0)
