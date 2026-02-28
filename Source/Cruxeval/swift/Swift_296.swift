import Foundation

func f(url: String) -> String {
    if url.hasPrefix("http://www.") {
        return String(url.dropFirst("http://www.".count))
    } else {
        return url
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
            
assert(f(url: "https://www.www.ekapusta.com/image/url") == "https://www.www.ekapusta.com/image/url")
