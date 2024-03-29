/// 実数型
pub type FL = f64;
/// 非負整数型
pub type SI = usize;

/// SIのコンパイル時取得
#[macro_export]
macro_rules! build_env_SI {
    ($name:expr,$default:expr) => {
        match option_env!($name) {
            Some(s) => match konst::primitive::parse_usize(s) {
                Ok(v) => v,
                Err(_) => $default,
            },
            None => $default,
        }
    };
}
