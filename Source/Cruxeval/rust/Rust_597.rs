fn f(s: String) -> String {
    s.to_uppercase()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Jaafodsfa SOdofj AoaFjIs  JAFasIdfSa1")), String::from("JAAFODSFA SODOFJ AOAFJIS  JAFASIDFSA1"));
}
