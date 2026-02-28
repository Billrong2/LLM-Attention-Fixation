fn f(text: String, chars: String) -> String {
    let mut result = text.chars().collect::<Vec<char>>();
    while result.windows(3).rev().step_by(2).any(|w| w == chars.chars().collect::<Vec<char>>()) {
        if let Some(pos) = result.iter().rposition(|&c| c == result[result.len() - 3]) {
            result.remove(pos);
            result.remove(pos);
        }
    }
    result.into_iter().collect::<String>().trim_matches('.').to_string()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("ellod!p.nkyp.exa.bi.y.hain"), String::from(".n.in.ha.y")), String::from("ellod!p.nkyp.exa.bi.y.hain"));
}
