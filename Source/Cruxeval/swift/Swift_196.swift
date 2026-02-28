import Foundation

func f(text: String) -> String {
    var modifiedText = text.replacingOccurrences(of: " x", with: " x.")
    if modifiedText.capitalized == modifiedText {
        return "correct"
    }
    modifiedText = modifiedText.replacingOccurrences(of: " x.", with: " x")
    return "mixed"
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
            
assert(f(text: "398 Is A Poor Year To Sow") == "correct")
