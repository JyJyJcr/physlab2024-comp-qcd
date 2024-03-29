/// 状態`S`から物理量`Q`を読み取る
pub trait StateScholar<S, Q> {
    fn measure(s: &S) -> Q;
}
/// 状態`S`のモンテカルロの実装
pub trait StateTheos<S> {
    /// 状態`S`の生成
    fn generate(&mut self) -> Result<S, TheosFail>;
    /// 状態`S`の擬時間発展
    fn next(&mut self, s: &mut S) -> Result<(), TheosFail>;
}
/// `StateTheos`のエラー
#[derive(Debug)]
pub struct TheosFail;
