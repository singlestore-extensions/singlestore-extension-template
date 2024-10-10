wit_bindgen_rust::export!("build/extension.wit");

struct Extension;

impl extension::Extension for Extension {
    fn power_of(base: i32, exp: i32) -> i32 {
        let mut res = 1;
        for _i in 0..exp {
            res *= base;
        }
        res
    }
}