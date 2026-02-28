/// 
func f(perc: String, full: String) -> String {
    var reply = ""
    var i = 0
    while i < full.count && i < perc.count && perc[perc.index(perc.startIndex, offsetBy: i)] == full[full.index(full.startIndex, offsetBy: i)] {
        if perc[perc.index(perc.startIndex, offsetBy: i)] == full[full.index(full.startIndex, offsetBy: i)] {
            reply += "yes "
        } else {
            reply += "no "
        }
        i += 1
    }
    return reply
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
            
assert(f(perc: "xabxfiwoexahxaxbxs", full: "xbabcabccb") == "yes ")
