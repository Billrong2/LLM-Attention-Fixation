import Foundation

func f(string: String) -> String {
    return string.replacingOccurrences(of: "needles", with: "haystacks")
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
            
assert(f(string: "wdeejjjzsjsjjsxjjneddaddddddefsfd") == "wdeejjjzsjsjjsxjjneddaddddddefsfd")
