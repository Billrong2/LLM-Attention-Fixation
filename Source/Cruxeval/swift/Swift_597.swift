/// 
func f(s: String) -> String {
    return s.uppercased()
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
            
assert(f(s: "Jaafodsfa SOdofj AoaFjIs  JAFasIdfSa1") == "JAAFODSFA SODOFJ AOAFJIS  JAFASIDFSA1")
