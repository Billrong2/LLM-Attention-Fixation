/// 
func f(line: String) -> String {
    var count = 0
    var a: [Character] = []
    
    for i in line.indices {
        count += 1
        if count % 2 == 0 {
            a.append(line[i].isLetter ? Character(line[i].lowercased() == String(line[i]) ? line[i].uppercased() : line[i].lowercased()) : line[i])
        } else {
            a.append(line[i])
        }
    }
    
    return String(a)
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
            
assert(f(line: "987yhNSHAshd 93275yrgSgbgSshfbsfB") == "987YhnShAShD 93275yRgsgBgssHfBsFB")
