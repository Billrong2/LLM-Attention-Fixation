import Foundation

func f(text: String) -> (String, String) {
    let components = text.split(separator: "|").map { String($0) }
    var topic = components.dropLast().joined(separator: "|")
    var problem = components.last ?? ""
    
    if problem == "r" {
        let topicMutable = NSMutableString(string: topic)
        topic = topicMutable.replacingOccurrences(of: "u", with: "p") as String
    }
    
    return (topic, problem)
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
            
assert(f(text: "|xduaisf") == ("", "xduaisf"))
