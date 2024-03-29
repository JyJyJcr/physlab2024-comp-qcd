pub trait StateScholar<S, Q> {
    fn measure(s: &S) -> Q;
}
pub trait StateTheos<S> {
    fn generate(&self) -> Result<S, TheosFail>;
    fn next(&self, s: &mut S) -> Result<(), TheosFail>;
}
#[derive(Debug)]
pub struct TheosFail;
