use ndarray::*;
use rand::{rngs::*, *};

use crate::monte::*;

use clap::Parser;
/// `ising`モジュールのオプション
#[derive(Parser, Debug)]
pub struct Opt {
    /// ステップ数
    steps: usize,
    /// 格子の数
    size: usize,
    /// 温度
    temp: f64
}

/// イジング模型の状態(空間2次元)
struct IsingState {
    /// スピン(±1)
    spin: Array2<i64>,
    /// 磁化
    magnetization: i64,
    /// エネルギー
    energy: i64
}
impl IsingState {
    /// スピンの初期値を指定して生成
    fn new(spin: Array2<i64>) -> Self {
        // 磁化
        let magnetization = spin.sum();
        // エネルギー
        let mut energy = 0;
        for i in 0..spin.nrows() {
            for j in 0..spin.ncols() {
                energy -= spin[[i, j]] * spin[[(i + 1) % spin.nrows(), j]];
                energy -= spin[[i, j]] * spin[[i, (j + 1) % spin.nrows()]];
            }
        }
        IsingState { spin, magnetization, energy }
    }
}

/// `IsingState`用の`StateTheos`
struct IsingTheos {
    /// 格子の数
    size: usize,
    /// 温度
    temp: f64,
    /// 乱数生成器
    rng: ThreadRng,
}
impl StateTheos<IsingState> for IsingTheos {
    /// `IsingState`の生成、全てのスピンが1の状態を返す
    fn generate(&mut self) -> Result<IsingState, TheosFail> {
        Ok(IsingState::new(Array2::ones((self.size, self.size))))
    }

    /// `IsingState`の擬時間発展、メトロポリス法
    fn next(&mut self, s: &mut IsingState) -> Result<(), TheosFail> {
        // 変更するサイトを選ぶ
        let i = self.rng.gen_range(0..self.size);
        let j = self.rng.gen_range(0..self.size);
        // 変更したときのエネルギーの変化を計算
        let de = 2 * s.spin[[i, j]] *
            (s.spin[[(i + self.size - 1) % self.size, j]]
            + s.spin[[(i + 1) % self.size, j]]
            + s.spin[[i, (j + self.size - 1) % self.size]]
            + s.spin[[i, (j + 1) % self.size]]);
        // エネルギー変化が負なら採択、正なら exp(-ΔE/T) の確率で採択
        if de < 0 || self.rng.gen_bool((-de as f64 / self.temp).exp()) {
            s.spin[[i, j]] = -s.spin[[i, j]];
            // 磁化とエネルギーを差分更新
            s.magnetization += 2 * s.spin[[i, j]];
            s.energy += de;
        }
        Ok(())
    }
}

/// `ising`モジュールのシミュレーション実行
pub fn run(opt: Opt) -> Result<(), TheosFail> {
    let mut th = IsingTheos { size: opt.size, temp: opt.temp, rng: rand::thread_rng() };
    let mut s = th.generate()?;
    for _ in 1..opt.steps {
        th.next(&mut s)?;
    }
    Ok(())
}
