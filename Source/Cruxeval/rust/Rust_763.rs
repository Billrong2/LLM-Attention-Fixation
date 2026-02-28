fn f(values: String, text: String, markers: String) -> String {
    let values = values.chars().collect::<Vec<char>>();
    let text = text.chars().collect::<Vec<char>>();
    let markers = markers.chars().collect::<Vec<char>>();

    let mut text = text;

    while let Some(c) = text.pop() {
        if !values.contains(&c) && !markers.contains(&c) {
            text.push(c);
            break;
        }
    }
    text.into_iter().collect::<String>()
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("2Pn"), String::from("yCxpg2C2Pny2"), String::from("")), String::from("yCxpg2C2Pny"));
}
