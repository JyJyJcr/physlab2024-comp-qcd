mod test_linalg;

type FL = f64;
type SI = usize;

pub trait StateScholar<S, Q> {
    fn measure(s: &S) -> Q;
}
pub trait StateTheos<S> {
    fn generate(&self) -> Result<S, TheosFail>;
    fn next(&self, s: &mut S) -> Result<(), TheosFail>;
}
#[derive(Debug)]
pub struct TheosFail;

use ndarray::*;
struct QCDState<const X: SI, const Y: SI, const Z: SI, const T: SI> {
    f: Array4<FL>,
    u: Array4<FL>,
}
impl<const X: SI, const Y: SI, const Z: SI, const T: SI> QCDState<X, Y, Z, T> {
    fn new() -> Self {
        QCDState::<X, Y, Z, T> {
            f: ndarray::Array4::zeros((X, Y, Z, T)),
            u: ndarray::Array4::zeros((X, Y, Z, T)),
        }
    }
}

struct QCDTheos<const X: SI, const Y: SI, const Z: SI, const T: SI> {
    virt_dt: FL,
}
impl<const X: SI, const Y: SI, const Z: SI, const T: SI> QCDTheos<X, Y, Z, T> {
    fn new(virt_dt: FL) -> Self {
        QCDTheos::<X, Y, Z, T> { virt_dt: virt_dt }
    }
}
impl<const X: SI, const Y: SI, const Z: SI, const T: SI> StateTheos<QCDState<X, Y, Z, T>>
    for QCDTheos<X, Y, Z, T>
{
    fn generate(&self) -> Result<QCDState<X, Y, Z, T>, TheosFail> {
        Ok(QCDState::new())
    }

    fn next(&self, s: &mut QCDState<X, Y, Z, T>) -> Result<(), TheosFail> {
        //currently do nothing
        Ok(())
        //Err(TheosFail)
    }
}

fn main() {
    let steps: SI = 10000;
    const X: SI = 10;
    const Y: SI = 10;
    const Z: SI = 10;
    const T: SI = 10;
    let th = QCDTheos::<X, Y, Z, T>::new(1.0e-8);
    let mut s = th.generate().unwrap();
    for _ in 1..steps {
        th.next(&mut s).unwrap();
    }
}
