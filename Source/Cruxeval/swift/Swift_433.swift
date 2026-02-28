func f(text: String) -> String {
    var textArray = text.split(separator: ",")
    textArray.removeFirst()
    let indexOfT = textArray.firstIndex(of: "T")!
    textArray.remove(at: indexOfT)
    textArray.insert("T", at: 0)
    return "T" + "," + textArray.joined(separator: ",")
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
            
assert(f(text: "Dmreh,Sspp,T,G ,.tB,Vxk,Cct") == "T,T,Sspp,G ,.tB,Vxk,Cct")
