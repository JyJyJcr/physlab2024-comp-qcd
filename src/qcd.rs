use crate::{capacity::*, monte::*};
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

use clap::Parser;
#[derive(Parser, Debug)]
pub struct Opt {
    /// steps
    steps: SI,
}

struct Conf {
    x: SI,
    y: SI,
    z: SI,
    t: SI,
}
const CONF: Conf = Conf {
    x: 10,
    y: 10,
    z: 10,
    t: 10,
};

pub fn run(opt: Opt) -> Result<(), TheosFail> {
    let th = QCDTheos::<{ CONF.x }, { CONF.y }, { CONF.z }, { CONF.t }>::new(1.0e-8);
    let mut s = th.generate()?;
    for _ in 1..opt.steps {
        th.next(&mut s)?;
    }
    Ok(())
}
