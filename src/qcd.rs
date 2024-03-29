use crate::{build_env_SI, capacity::*, monte::*};
use ndarray::*;
/// QCDの状態(3空間+1虚時間の4次元)
struct QCDState<const X: SI, const Y: SI, const Z: SI, const T: SI> {
    /// クォーク場
    f: Array4<FL>,
    /// グルーオン場
    u: Array4<FL>,
}
impl<const X: SI, const Y: SI, const Z: SI, const T: SI> QCDState<X, Y, Z, T> {
    /// 真空状態を生成
    fn zeros() -> Self {
        QCDState::<X, Y, Z, T> {
            f: ndarray::Array4::zeros((X, Y, Z, T)),
            u: ndarray::Array4::zeros((X, Y, Z, T)),
        }
    }
}

/// `QCDState`用の`StateTheos`
struct QCDTheos<const X: SI, const Y: SI, const Z: SI, const T: SI> {
    /// 擬時間発展の時間幅
    virt_dt: FL,
}
impl<const X: SI, const Y: SI, const Z: SI, const T: SI> QCDTheos<X, Y, Z, T> {
    /// 擬時間発展の時間幅を`virt_dt`に設定して生成
    fn new(virt_dt: FL) -> Self {
        QCDTheos::<X, Y, Z, T> { virt_dt: virt_dt }
    }
}
impl<const X: SI, const Y: SI, const Z: SI, const T: SI> StateTheos<QCDState<X, Y, Z, T>>
    for QCDTheos<X, Y, Z, T>
{
    /// `QCDState`の生成、今は真空を返す
    fn generate(&self) -> Result<QCDState<X, Y, Z, T>, TheosFail> {
        Ok(QCDState::zeros())
    }

    /// `QCDState`の擬時間発展、今は何もしない
    fn next(&self, s: &mut QCDState<X, Y, Z, T>) -> Result<(), TheosFail> {
        //currently do nothing
        Ok(())
        //Err(TheosFail)
    }
}

use clap::Parser;
use ndarray_linalg::krylov::householder::calc_reflector;
/// `qcd`モジュールのオプション
#[derive(Parser, Debug)]
pub struct Opt {
    /// 擬時間発展のステップ数
    steps: SI,
}

/// `qcd`モジュールのコンフィグ
struct Conf {
    x: SI,
    y: SI,
    z: SI,
    t: SI,
}

/// `qcd`モジュールのコンフィグ定数(コンパイル時設定)
const CONF: Conf = Conf {
    x: build_env_SI!("QCD_X", 10),
    y: build_env_SI!("QCD_Y", 10),
    z: build_env_SI!("QCD_Z", 10),
    t: build_env_SI!("QCD_T", 10),
};
/// `qcd`モジュールのシミュレーション実行
pub fn run(opt: Opt) -> Result<(), TheosFail> {
    println!("{}", CONF.x);
    let th = QCDTheos::<{ CONF.x }, { CONF.y }, { CONF.z }, { CONF.t }>::new(1.0e-8);
    let mut s = th.generate()?;
    for _ in 1..opt.steps {
        th.next(&mut s)?;
    }
    Ok(())
}
