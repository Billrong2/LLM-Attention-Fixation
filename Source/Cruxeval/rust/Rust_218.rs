fn f(string: String, sep: String) -> String {
    let cnt = string.matches(&sep).count();
    return format!("{}{}", string, &sep).repeat(cnt).chars().rev().collect::<String>();
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("caabcfcabfc"), String::from("ab")), String::from("bacfbacfcbaacbacfbacfcbaac"));
}
