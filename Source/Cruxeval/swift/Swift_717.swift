/// 
func f(text: String) -> String {
    var k = 0
    var l = text.count - 1
    let chars = Array(text)

    while !chars[l].isLetter {
        l -= 1
    }

    while !chars[k].isLetter {
        k += 1
    }

    if k != 0 || l != text.count - 1 {
        return String(chars[k...l])
    } else {
        return String(chars[0])
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
            
assert(f(text: "timetable, 2mil") == "t")
