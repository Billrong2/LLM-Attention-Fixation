import Foundation

func f(text: String, to_place: String) -> String {
    if let range = text.range(of: to_place) {
        let afterPlace = text[..<range.upperBound]
        let beforePlace = text[range.upperBound...]
        return String(afterPlace + beforePlace)
    }
    return text
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
            
assert(f(text: "some text", to_place: "some") == "some text")
