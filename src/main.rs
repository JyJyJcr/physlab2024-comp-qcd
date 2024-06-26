mod capacity;
mod monte;
mod ising;
mod qcd;

//このモジュールはndarrayの調子の確認用なので、いずれ排除
mod test_linalg;

use clap::{Parser, Subcommand};
/// コマンドライン入力を整形
#[derive(Parser, Debug)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand, Debug)]
/// サブモジュールに割り振り
enum Commands {
    /// Ising
    Ising(ising::Opt),
    /// QCD
    QCD(qcd::Opt),
}

/// コマンドライン引数を読んでサブモジュールを実行
fn main() {
    let cli = Cli::parse();
    match cli.command {
        Commands::Ising(opt) => ising::run(opt).unwrap(),
        Commands::QCD(opt) => qcd::run(opt).unwrap(),
    };
}
