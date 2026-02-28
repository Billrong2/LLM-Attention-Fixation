fn f(perc: String, full: String) -> String {
    let mut reply = String::new();
    let mut i = 0;
    while i < full.len() && i < perc.len() && perc.chars().nth(i) == full.chars().nth(i) {
        if perc.chars().nth(i) == full.chars().nth(i) {
            reply.push_str("yes ");
        } else {
            reply.push_str("no ");
        }
        i += 1;
    }
    reply
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("xabxfiwoexahxaxbxs"), String::from("xbabcabccb")), String::from("yes "));
}
