import Foundation

func f(text: String, tabsize: Int) -> String {
    return text.split(separator: "\n").map { $0.replacingOccurrences(of: "\t", with: String(repeating: " ", count: tabsize)) }.joined(separator: "\n")
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
            
assert(f(text: "\tf9\n\tldf9\n\tadf9!\n\tf9?", tabsize: 1) == " f9\n ldf9\n adf9!\n f9?")
