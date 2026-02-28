import Foundation

func f(input_string: String, spaces: Int) -> String {
    let tabWidth = spaces
    let tabReplacement = String(repeating: " ", count: tabWidth)
    return (input_string as NSString).replacingOccurrences(of: "\t", with: tabReplacement)
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
            
assert(f(input_string: "a\\tb", spaces: 4) == "a\\tb")
