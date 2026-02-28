import XCTest

var g: String = ""
var field: String = ""

func f(text: String) -> String {
    field = text.replacingOccurrences(of: " ", with: "")
    g = text.replacingOccurrences(of: "0", with: " ")
    return text.replacingOccurrences(of: "1", with: "i")
}

func testF() {
    XCTAssertEqual(f(text: "example"), "example")
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
            
assert(f(text: "00000000 00000000 01101100 01100101 01101110") == "00000000 00000000 0ii0ii00 0ii00i0i 0ii0iii0")
