import Foundation

func f(text: String, chars: String) -> String {
    var text = text
    if !chars.isEmpty {
        text = text.trimmingCharacters(in: CharacterSet(charactersIn: chars))
    } else {
        text = text.trimmingCharacters(in: .whitespaces)
    }
    if text.isEmpty {
        return "-"
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
            
assert(f(text: "new-medium-performing-application - XQuery 2.2", chars: "0123456789-") == "new-medium-performing-application - XQuery 2.")
