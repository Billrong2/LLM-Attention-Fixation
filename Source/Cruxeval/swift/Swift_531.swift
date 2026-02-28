import Foundation

func f(text: String, x: String) -> String {
    if text.hasPrefix(x) {
        return text
    } else {
        let newText = String(text.dropFirst())
        return f(text: newText, x: x)
    }
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
            
assert(f(text: "Ibaskdjgblw asdl ", x: "djgblw") == "djgblw asdl ")
