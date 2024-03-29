mod capacity;
mod monte;
mod qcd;
mod test_linalg;

use clap::{Parser, Subcommand};

#[derive(Parser, Debug)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand, Debug)]
enum Commands {
    /// Ising
    Ising(qcd::Opt),
    /// QCD
    QCD(qcd::Opt),
}

fn main() {
    let cli = Cli::parse();
    match cli.command {
        Commands::Ising(opt) => qcd::run(opt).unwrap(),
        Commands::QCD(opt) => qcd::run(opt).unwrap(),
    };
}
