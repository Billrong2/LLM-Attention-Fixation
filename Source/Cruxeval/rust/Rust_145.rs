use std::slice;

fn f(price: f64, product: String) -> f64 {
    let mut inventory: Vec<&'static str> = vec![ "olives", "key", "orange"];
    let index = inventory.iter().position(|&x| x == product);
    match index {
        Some(_) => {
            let price = price * 0.85;
            let index = index.unwrap();
            inventory.remove(index);
            price
        },
        None => price,
    }
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(8.5, String::from("grapes")), 8.5);
}
