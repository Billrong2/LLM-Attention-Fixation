import Foundation

func f(text: String, wrong: String, right: String) -> String {
    let newText = text.replacingOccurrences(of: wrong, with: right)
    return newText.uppercased()
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
            
assert(f(text: "zn kgd jw lnt", wrong: "h", right: "u") == "ZN KGD JW LNT")
