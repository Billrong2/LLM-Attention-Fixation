fn f(text: String) -> String {
    let mut text = text.split(',').collect::<Vec<&str>>();
    text.remove(0);
    let index_t = text.iter().position(|&x| x == "T").unwrap();
    let t_element = text.remove(index_t);
    text.insert(0, t_element);
    let result = format!("T,{}", text.join(","));
    result
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(String::from("Dmreh,Sspp,T,G ,.tB,Vxk,Cct")), String::from("T,T,Sspp,G ,.tB,Vxk,Cct"));
}
