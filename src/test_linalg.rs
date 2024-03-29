#[test]
fn test_lin() {
    println!("test ndarray-linalg!");
    println!("solve {}", solve().unwrap());
    println!("factorize {}", factorize().unwrap());
}

use ndarray::*;
use ndarray_linalg::*;

// Solve `Ax=b`
fn solve() -> Result<bool, error::LinalgError> {
    let a: Array2<f64> = random((3, 3));
    let b: Array1<f64> = random(3);
    let x = a.solve(&b)?;
    Ok(a.dot(&x).abs_diff_eq(&b, 1.0e-6))
}

// Solve `Ax=b` for many b with fixed A
fn factorize() -> Result<bool, error::LinalgError> {
    let a: Array2<f64> = random((3, 3));
    let a_copy = a.clone();
    let f = a.factorize_into()?; // LU factorize A (A is consumed)
    let a = a_copy;
    let mut flag = true;
    for _ in 0..10 {
        let b: Array1<f64> = random(3);
        let b_copy = b.clone();
        let x = f.solve_into(b)?; // solve Ax=b using factorized L, U
        let b = b_copy;
        flag &= flag & (a.dot(&x).abs_diff_eq(&b, 1.0e-6));
    }
    Ok(flag)
}
