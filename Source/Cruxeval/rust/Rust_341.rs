use std::collections::HashMap;

fn f(mut cart: HashMap<isize, isize>) -> HashMap<isize, isize> {
    while cart.len() > 5 {
        if let Some(key) = cart.keys().next().cloned() {
            cart.remove(&key);
        }
    }
    cart
}

fn main() {
    let candidate = f;
    assert_eq!(candidate(HashMap::from([])), HashMap::from([]));
}
