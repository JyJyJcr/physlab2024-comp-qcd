#import "../template.typ": *
#import "@preview/physica:0.9.2": *

#show: report.with(title: "6章〜7.1,7.2", author: none)

#let section-coutner = counter("section")
#let eq-coutner = counter("eq")

#let eqnum(_) = {
  locate(loc => {
    let x = section-coutner.at(loc).at(0)
    let y = eq-coutner.at(loc).at(0)
    "(" + str(x) + "." + str(y) + ")"
  })
}
#let number(body) = {
  eq-coutner.step()
  set math.equation(supplement: none, numbering: eqnum)
  body
}
#show ref: it => {
  if it.element != none and it.element.func() == math.equation {
    let loc = it.element.location()
    let x = section-coutner.at(loc).at(0)
    let y = eq-coutner.at(loc).at(0)
    it.element.supplement + " (" + str(x) + "." + str(y) + ")"
  } else {
    it
  }
}

= 非可換ゲージ理論

#section-coutner.update(6)

== ゲージ対称性を持つ作用

前回は $U(1)$ 対称性を持つ理論、つまり可換ゲージ理論を格子に乗せた。今回は非可換ゲージ理論を扱う。非可換ゲージ理論では、同じ質量 $M_0$ を持った $N$ 個のフェルミオン $psi^a (a=1,dots.c,N)$ を考える。Euclid化された作用(Wilsonフェルミオン)は
#number[$
S_F&=(hat(M)_0+4r)sum_n sum_(a=1)^N overline(psi)^a (n)psi^a (n)\
&quad-1/2 sum_(n,mu)sum_(a=1)^N [overline(psi)^a (n)(r-gamma_mu)psi^a (n+hat(mu))+overline(psi)^a (n+hat(mu))(r+gamma_mu)psi^a (n)]
$]
である。無次元化された量であることを示すハットは $psi,overline(psi)$ については面倒なので省略されている。

#let SU(x) = $S U(#x)$

この作用には $SU(N)$ 対称性がある。$N$ 個のフェルミオンをユニタリ行列で入れ替えるものである。$N$ 行のベクトルを
#number[$
tilde(psi)=vec(psi^1,dots.v,psi^N),quad overline(tilde(psi))=(overline(psi)^1,dots.c,overline(psi)^N)
$]
と定義し、$tilde(G) in SU(N)$ による変換を
$
psi(n)&-->tilde(G)tilde(psi)(n)\
overline(tilde(psi))(n)&-->overline(tilde(psi))(n)tilde(G)^(-1)
$
と置くと、確かに作用は不変である。

可換ゲージ理論のときと同様に、リンク変数を
#number[$
tilde(U)_mu (n)=e^(i tilde(phi.alt)_mu (n))
$]
として導入する。$tilde(phi.alt)_mu (n)$ は $SU(N)$ のLie代数の元、つまりトレースが $0$ のHermiteな$N times N$ 行列である。これによって作用を
#number[$
S_F&=(hat(M)_0+4r)sum_n overline(tilde(psi))(n)tilde(psi) (n)\
&quad-1/2 sum_(n,mu) [overline(tilde(psi))(n)(r-gamma_mu)tilde(U)_mu (n)tilde(psi)(n+hat(mu))\
&quad +overline(tilde(psi)) (n+hat(mu))(r+gamma_mu)tilde(U)_mu^dagger (n) tilde(psi)(n)]
$<eq:action_fermion>]
と書き換える。ここに出てくる $hat(M)_0$ はフェルミオンの質量*ではなく*、ただのパラメータと見るべきものである。相互作用によってフェルミオンの質量がずれるからである。

行列やスピノルの略記をやめれば、
$
overline(tilde(psi))(n)(r-gamma_mu)tilde(U)_mu (n)tilde(psi)(n+hat(mu))=sum_(alpha,beta,a,b)overline(psi)^a_alpha (n)(r-gamma_mu)_(alpha beta)(tilde(U)_mu (n))_(a b)psi^b_beta (n+hat(mu))
$
のようになる。

@eq:action_fermion の作用は次の変換について不変である。
#number[$
psi(n)&-->tilde(G)(n)tilde(psi)(x)\
overline(tilde(psi))(n)&-->overline(tilde(psi))(x)tilde(G)^(-1)(n)\
tilde(U)_mu (n)&-->tilde(G)(n)tilde(U)_mu (n)tilde(G)^(-1)(n+hat(mu))\
tilde(U)^dagger_mu (n)&-->tilde(G)(n+hat(mu))tilde(U)^dagger_mu (n)tilde(G)^(-1)(n)
$]
ただし $tilde(G)(n)$ は $SU(N)$ の元であり、
$
tilde(G)(n)=e^(i tilde(Lambda)(n))
$
と書ける。$tilde(Lambda)_mu (n)$ は $SU(N)$ のLie代数の元である。

ゲージの方の作用 $S_G$ はゲージ不変である必要がある。リンク変数 $tilde(U)_mu (n)$ の変換性
$
tilde(U)_mu (n)&-->tilde(G)(n)tilde(U)_mu (n)tilde(G)^(-1)(n+hat(mu))
$
はリンク変数が頂点 $n$ から頂点 $n+hat(mu)$ への矢印であって、出る頂点の $tilde(G)(n)$ が左、向かう頂点の $tilde(G)^(-1)(n+hat(mu))$ が右にかかると解釈できる。Hermite共役 $tilde(U)^dagger_mu (n)$ の変換性は頂点 $n+hat(mu)$ から頂点 $n$ への矢印と解釈できるので、格子上の線は単純な変換性を持つ。例えば最も簡単なループである頂点 $n,n+hat(mu),n+hat(mu)+hat(nu),n+hat(nu)$ を順番にまわるループ
#number[$
tilde(U)_(mu nu)(n)=tilde(U)_mu (n)tilde(U)_nu (n+hat(mu))tilde(U)^dagger_mu (n+hat(nu))tilde(U)^dagger_nu (n)
$]
の変換性は
$
tilde(U)_(mu nu)(n)-->tilde(G)(n)tilde(U)_(mu nu)(n)tilde(G)^(-1)(n)
$
となる。最初と最後に現れる $tilde(G)(n)$ はトレースを取れば巡回性によって消えるので、$S_G$ を
#number[$
S_G=c Tr sum_(n,mu<nu)(1-1/2 (tilde(U)_(mu nu)(n)+tilde(U)^dagger_(mu nu)(n)))
$]
とすることができる。$c$ は定数である。

== $SU(3)$ での連続極限
ここからは強い相互作用のゲージ対称性である $SU(3)$ について議論しよう。$SU(3)$ のLie代数の元 $tilde(Theta)$ はトレースが $0$ のHermiteな $3times 3$ 行列なので、適当に8個の基底 $lambda^B$ を取って
$
tilde(Theta)=sum_(B=1)^8 Theta^B lambda^B/2
$
と書ける。$lambda^B$ は普通Gell--mann行列と呼ばれるものに取られる。$SU(3)$ のLie代数の元の交換子はまたトレースが $0$ のHermite行列になるので
#number[$
[lambda^A,lambda^B]=2i sum_(C=1)^8 f_(A B C)lambda^C
$]
と書ける。このとき完全反対称な係数 $f_(A B C)$ は構造定数と呼ばれる。

連続極限を取るために、リンク変数 $tilde(U)_mu (n)=e^(i tilde(phi.alt)_mu (n))$ の肩を
#number[$
tilde(phi.alt)_mu (n)=g_0 a tilde(A)_mu (n)
$]
と置く。$a$ は格子間隔であり、$g_0$ は(裸の)結合定数である。$tilde(A)_mu (n)$ は $SU(3)$ のLie代数の元なので
#number[$
tilde(A)_mu (n)=sum_(B=1)^8 A_mu^B (n)lambda^B/2
$]
と書ける。これと他の量のスケーリング
$
x&-->n a\
M_0&-->a^(-1) hat(M)_0\
psi(x)&-->a^(-3\/2)psi(n)\
overline(psi)(x)&-->a^(-3\/2)overline(psi)(n)\
integral d^4x&-->a^4 sum_n
$
をフェルミオンの作用
$
S_F&=(hat(M)_0+4r)sum_n overline(tilde(psi))(n)tilde(psi) (n)\
&quad-1/2 sum_(n,mu)sum_(a=1)^N [overline(tilde(psi))(n)(r-gamma_mu)tilde(U)_mu (n)tilde(psi)(n+hat(mu))\
&quad +overline(tilde(psi)) (n+hat(mu))(r+gamma_mu)tilde(U)_mu^dagger (n) tilde(psi)(n)]
$
に代入して $a->0$ とする。$r$ に比例する項はWilsonフェルミオンで加えた項なので $a->0$ で消えるから、
$
S_F&=hat(M)_0sum_n overline(tilde(psi))(n)tilde(psi) (n)\
&quad+1/2 sum_(n,mu) [overline(tilde(psi))(n)gamma_mu (1+i g_0 a tilde(A)_mu (n))tilde(psi)(n+hat(mu))\
&quad -overline(tilde(psi)) (n+hat(mu))gamma_mu (1-i g_0 a tilde(A)_mu (n))tilde(psi)(n)]\
&=hat(M)_0sum_n overline(tilde(psi))(n)tilde(psi) (n)\
&quad+1/2 sum_(n,mu)[overline(tilde(psi))(n)gamma_mu tilde(psi)(n+hat(mu))-overline(tilde(psi)) (n)gamma_mu tilde(psi)(n-hat(mu))]\
&quad+1/2 i g_0 a sum_(n,mu)[overline(tilde(psi))(n)tilde(A)_mu (n)tilde(psi)(n+hat(mu))+overline(tilde(psi))(n+hat(mu))tilde(A)_mu (n)tilde(psi)(n)]
$
の $a->0$ の極限を考えればよいので
$
S_F^"(cont.)"=integral d^4x overline(tilde(psi))(x)(gamma_mu (diff_mu+i g_0 tilde(A)_mu (x))+M_0)tilde(psi)(x)
$
となる。

$S_G$ の方の連続極限も考える。ループ
#number[$
tilde(U)_(mu nu)(n)=tilde(U)_mu (n)tilde(U)_nu (n+hat(mu))tilde(U)^dagger_mu (n+hat(nu))tilde(U)^dagger_nu (n)
$]
について
$
tilde(U)_(mu nu)(n)=exp(i g_0 a^2 tilde(cal(F))_(mu nu)(n))
$
と置いて $tilde(cal(F))_(mu nu)(n)$ を求める。Baker--Campbell-Hausdorffの公式
#number[$
exp(A)exp(B)=exp(A+B+1/2[A,B]+dots.c)
$]
を使い、$a$ の2次まで取って計算すると、$tilde(phi.alt)_mu (n)=g_0 a tilde(A)_mu (n)$ は $a$ の1次の量であることに注意して
$
tilde(U)_(mu nu)(n)&=exp(i tilde(phi.alt)_mu (n))exp(i tilde(phi.alt)_nu (n+hat(mu)))exp(-i tilde(phi.alt)_mu (n+hat(nu)))exp(-i tilde(phi.alt)_nu (n))\
&=exp(i tilde(phi.alt)_mu (n))exp(i tilde(phi.alt)_nu (n)+i a diff_mu tilde(phi.alt)_nu (n))exp(-i tilde(phi.alt)_mu (n)-i a diff_nu tilde(phi.alt)_mu (n))exp(-i tilde(phi.alt)_nu (n))\
&=exp(i tilde(phi.alt)_mu (n)+i tilde(phi.alt)_nu (n)+i a diff_mu tilde(phi.alt)_nu (n)-1/2[tilde(phi.alt)_mu (n),tilde(phi.alt)_nu (n)])\
&quad times exp(-i tilde(phi.alt)_mu (n)-i a diff_nu tilde(phi.alt)_mu (n)-i tilde(phi.alt)_nu (n)-1/2[tilde(phi.alt)_mu (n),tilde(phi.alt)_nu (n)])\
&=exp(i a diff_mu tilde(phi.alt)_nu (n)-i a diff_nu tilde(phi.alt)_mu (n)-[tilde(phi.alt)_mu (n),tilde(phi.alt)_nu (n)])
$
となる。よって
$
tilde(cal(F))_(mu nu)(n)=1/(g_0 a) (diff_mu tilde(phi.alt)_nu (n)-diff_nu tilde(phi.alt)_mu (n))+i 1/(g_0 a^2)[tilde(phi.alt)_mu (n),tilde(phi.alt)_nu (n)]
$
となるから、確かに連続極限で
#number[$
tilde(cal(F))_(mu nu)-->_(a->0)tilde(F)_(mu nu)=diff_mu tilde(A)_nu-diff_nu tilde(A)_mu+i g_0[tilde(A)_mu,tilde(A)_nu]
$]
となる。

$tilde(F)_(mu nu)$ もGell-Mann行列で
#number[$
tilde(F)_(mu nu)=sum_(B=1)^8 F_(mu nu)^B lambda^B/2
$]
と展開する。Gell-Mann行列の直交関係
#number[$
Tr (lambda^B lambda^C)=2delta_(B C)
$]
から、$lambda^B$ をかけてトレースを取ると成分が
$
F_(mu nu)^B=Tr (tilde(F)_(mu nu)lambda^B)
$
のように取り出せることが分かるので、
#number[$
F_(mu nu)^B=diff_mu A^B_nu-diff_nu A^B_mu-g_0 f_(B C D)A^C_mu A^D_nu
$]
となる。こうして
$
S_G&=c Tr sum_(n,mu<nu)(1-1/2 (tilde(U)_(mu nu)(n)+tilde(U)^dagger_(mu nu)(n)))\
&=c Tr sum_(n,mu<nu)(1-1/2 (1+i g_0 a^2 tilde(cal(F))_(mu nu)(n)-1/2 g^2_0 a^4 tilde(cal(F))_(mu nu)(n)tilde(cal(F))_(mu nu)(n))\
&quad-1/2 (1-i g_0 a^2 tilde(cal(F))_(mu nu)(n)-1/2 g^2_0 a^4 tilde(cal(F))_(mu nu)(n)tilde(cal(F))_(mu nu)(n)))+O(a^6)\
&=1/2 c g_0^2 a^4 Tr sum_(n,mu<nu)tilde(cal(F))_(mu nu)(n)tilde(cal(F))_(mu nu)(n)+O(a^6)
$
の連続極限は
$
S_G->c g_0^2/2 S_G^"(cont.)"
$
となる。ただし
#number[$
S_G^"(cont.)"=1/2 Tr integral d^4x sum_(mu,nu) tilde(F)_(mu nu)tilde(F)_(mu nu)
$]
と置いた。そこで $c=g_0^2\/2$ と置くのがよいことが分かる。

Gell-Mann行列の直交関係を使うと
#eq-coutner.update(20)
#number[$
S_G^"(cont.)"=1/4 Tr integral d^4x sum_(mu,nu) sum_(B=1)^8 F^B_(mu nu)F^B_(mu nu)
$]
となる。これはよく知られているQCDのゲージ場の作用である。この形の作用はYangとMillsによって $SU(2)$ の場合に最初に与えられたのでYang--Mills作用と呼ばれる。
#eq-coutner.update(17)

一般の $N>1$ においては、
$
tilde(U)_P=tilde(U)_(mu nu) (n)
$
と置くことで
#number[$
S_G^((SU(N)))=beta sum_P [1-1/(2N)Tr(tilde(U)_P+tilde(U)_P^dagger)]
$]
となる。$P$ はプラケット、つまりループ $tilde(U)_(mu nu) (n)$ が囲む面を表している。$beta$ は $SU(3)$ と同じ議論によって
$
beta=(2N)/g_0^2
$
とすればよい。

リンク変数
#number[$
  tilde(U)_mu (n)=e^(i g_0 a tilde(A)_mu (n))
$]
は局所ゲージ変換に対して
$
tilde(U)_mu (n)&->tilde(G)(n)tilde(U)_mu (n)tilde(G)^(-1)(n+hat(mu))\
&=tilde(G)(n)tilde(U)_mu (n)(tilde(G)^(-1)(n)+a diff_mu tilde(G)^(-1)(n)+O(a^2))\
&=1+i g_0 a tilde(G)(n)tilde(A)_mu (n)tilde(G)^(-1)(n)+tilde(G)(n)diff_mu tilde(G)^(-1)(n)+O(a^2)
$
と変換するので、連続極限では
#number[$
tilde(A)_mu (x)->tilde(G)(x)tilde(A)_mu (x)tilde(G)^(-1)(x)-i/g_0 tilde(G)(x)diff_mu tilde(G)^(-1)(x)
$]
と変換する。これはよく知られたゲージ場の変換性である。
#eq-coutner.update(21)

== 経路積分
非可換ゲージ理論の経路積分を定める。リンク変数の積分測度 $D U$ はゲージ不変なものでなければならない。$ell$ 番目のリンク変数の $SU(3)$ のパラメータを $alpha_ell^A,(A=1,dots.c,8)$ とすると、
#number[$
D U=product_ell J(alpha_ell)(d alpha_ell)
$]
と書ける。ただし
$
(d alpha_ell)=product_(A=1)^8 d alpha_ell^A
$
である。このとき
$
d U_ell=J(alpha_ell)(d alpha_ell)
$
と置く。

コンパクトなLie群には一意に不変な測度が取れることが知られており、Haar測度と呼ばれている。ここでは詳細には立ち入らないが、次の公式を使えば十分である。
#number[$
integral d U U^(a b)&=0\
integral d U U^(a b)U^(c d)&=0\
integral d U U^(a b)(U^dagger)^(c d)&=1/3 delta_(a d)delta_(b c)\
integral d U U^(a_1 b_1)U^(a_2 b_2)U^(a_3 b_3)&=1/3! epsilon_(a_1a_2a_3)epsilon_(b_1b_2b_3)
$]
このような積分の一般的な計算はCreutz(1978)に与えられているらしい。

相関関数は経路積分で
#number[$
expval(psi^(a_1)_(alpha_1)(n_1)dots.c psi^(b_1)_(beta_1)(m_1)dots.c U^(c d)_(mu_1)(k_1)dots.c)=1/Z integral D U D overline(psi) D psi psi^(a_1)_(alpha_1)(n_1)dots.c psi^(b_1)_(beta_1)(m_1)dots.c U^(c d)_(mu_1)(k_1)dots.c e^(-S_"QCD")\
Z=integral D U D overline(psi) D psi e^(-S_"QCD")
$]
と与えられる。QCDの作用はまとめておくと
#number[$
S_"QCD"&=S_G [U]+S_F^((W)) [U,psi,overline(psi)]\
S_G&=6/g_0^2 sum_P [1-1/6Tr(tilde(U)_P+tilde(U)_P^dagger)]\
S_F^((W))&=(hat(M)_0+4r)sum_n overline(tilde(psi))(n)tilde(psi) (n)\
&quad-1/2 sum_(n,mu) [overline(tilde(psi))(n)(r-gamma_mu)tilde(U)_mu (n)tilde(psi)(n+hat(mu))\
&quad +overline(tilde(psi)) (n+hat(mu))(r+gamma_mu)tilde(U)_mu^dagger (n) tilde(psi)(n)]
$]
である。

ここまでWilsonフェルミオンしか扱ってこなかったが、スタッガードフェルミオンの場合は $tilde(chi)=(chi^1,chi^2,chi^3)$ によって
#number[$
S_F^"(stag.)"=1/2 sum_(n,mu)eta_mu (n)overline(tilde(chi))(n)(tilde(U)_mu (n)tilde(chi)(n+hat(mu))-tilde(U)_mu^dagger (n-hat(mu))tilde(chi)(n-hat(mu)))+hat(M)_0sum_n overline(chi)(n)chi(n)
$]
とすればいいらしい。

#pagebreak()
#section-coutner.step()
#eq-coutner.update(0)
= Wilsonループと静止クォーク・反クォークポテンシャル
強い相互作用ではクォークが単体で観測されないというクォークの閉じ込めという現象が起こる。これはクォークと反クォークのペア $(q overline(q))$ のポテンシャルが距離が離れると大きくなり、十分離れると新しくハドロンを作った方が全体のエネルギーが小さくなるという描像によって理解できる。また、核力が短距離でしか働かないことは、真空の偏極による遮蔽が起こり、Van der Waals力のような形でしか働かないと解釈できる。ポテンシャルを計算することで、このような定性的な解釈が本当に正しいかを確認できる。

まずは非相対論的量子力学において、ポテンシャルを経路積分で計算する方法を見る。

== 非相対論的量子力学におけるポテンシャル
1次元空間のポテンシャル $V(x)$ の中を運動する質量 $m$ の粒子を考える。この粒子の伝播は
#number[$
K(x',t;x,0)=bra(x')e^(-i H t)ket(x)
$]
によって与えられる。ハミルトニアンは
$
H=p^2/(2m)+V(x)
$
だから、静止極限 $m->infinity$ を取ると
#number[$
K(x',t;x,0)->delta(x-x')e^(-i V(x) t)
$]
となる。$t->-i T$ としてEuclid化すると、ポテンシャルは $K(x',t;x,0)$ のEuclid時間 $T$ に対する指数関数的な減衰から決まることが分かる。デルタ関数は単純に静止極限 $m->infinity$ で粒子が動かないことを表している。

静止極限の波動関数はSchrödinger方程式
$
i diff_t psi(x,t)=V(x)psi(x,t)
$
を満たすから、
#number[$
psi(x,t)=e^(-i V(x)t)psi(x,0)
$]
と書ける。

具体的に調和振動子
$
H=p^2/(2m)+1/2 kappa x^2
$
で確認してみよう。調和振動子では普通に計算できて
#number[$
K(x',t;x,0)=((m omega)/(2pi i sin omega t))^(1\/2) exp((i m omega)/(2 sin omega t)[(x^2+x'^2)cos omega t-2x x'])
$]
となる。ただし $omega=sqrt(kappa\/m)$ と置いた。$kappa$ を一定に保って $m->infinity$ とすると
#number[$
K(x',t;x,0)->[(1/(2pi i epsilon))^(1\/2)exp((i(x-x')^2)/(2epsilon))]exp(-i/2 (V(x')+V(x))t)
$]
となる。ただし $epsilon=t\/m$ と置いた。$epsilon->0$ で $[]$ の中身はデルタ関数になるので、確かにポテンシャルが指数関数の中に現れている。

== WilsonループとQEDにおける静止 $q overline(q)$-ポテンシャル
とりあえず $U(1)$ ゲージ理論、つまりQEDを考える。重いクォーク $(Q)$ と反クォーク $(overline(Q))$ がQEDの作用
$
S=-1/4 integral d^4x F^(mu nu)F_(mu nu)+integral d^4x overline(psi)(i gamma^mu D_mu-M)psi+integral d^4x overline(psi)^((Q))(i gamma^mu D_mu-M_Q)psi^((Q))
$
に従っているとする。$psi,overline(psi)$ は他のフェルミオンである。このとき、ゲージ不変な状態
#number[$
ket(phi.alt_(alpha beta)(arrow(x),arrow(y)))=overline(Psi)_alpha^((Q))(arrow(x),0)U(arrow(x),0;arrow(y),0)Psi_beta^((Q))(arrow(y),0)ket(Omega)
$]
を考える。ただし $ket(Omega)$ は基底状態であり、
#number[$
U(arrow(x),t;arrow(y),t)=exp(i e integral_arrow(x)^arrow(y)d z^i A_i (arrow(z),t))
$]
とした。線積分は $arrow(x),arrow(y)$ を結ぶ直線について行う。

$ket(phi.alt_(alpha beta))$ と重なりを持つ状態であって、最低のエネルギーを持つ状態を求めたい。$ket(phi.alt_(alpha beta))$ と重なりを持つ状態は無限にたくさんあるが、非相対論的量子力学においても質量を有限と考えているときは同じことが起こる。ハミルトニアン $H$ のエネルギー $E_n$ の固有状態を $ket(n)$ とすると、
#number[$
K(x',t;x,0)=sum_n braket(x',n)braket(n,x)e^(-i E_n t)
$]
と展開できる。$t->-i T$ と置き換えて $T->infinity$ とすれば
$
K(x',-i T;x,0)-->_(T->infinity)braket(x',0)braket(0,x)e^(-E_0 T)
$
となるから、最低のエネルギー状態 $E_0$ が得られる。これをFeynman--Kacの公式と呼ぶ。この例から質量を無限にする前に $T->infinity$ としてはいけないことが分かるらしい。

QEDの方に戻り、Green関数
#number[$
&G_(alpha'beta',alpha beta)(arrow(x)',arrow(y)';arrow(x),arrow(y);t)\
&=bra(Omega)T(overline(Psi)_(beta')^((Q))(arrow(y)',t)U(arrow(y)',t;arrow(x)',t)Psi_(alpha')^((Q))(arrow(x)',t)overline(Psi)_alpha^((Q))(arrow(x),0)U(arrow(x),0;arrow(y),0)Psi_beta^((Q))(arrow(y),0))ket(Omega)
$]
を考える。クォーク質量 $M_Q$ が大きい極限を考えるので、
#number[$
G_(alpha'beta',alpha beta)(arrow(x)',arrow(y)';arrow(x),arrow(y);-i T)-->_("1)"M_Q->infinity\ "2)"T->infinity)delta^3(arrow(x)-arrow(x)')delta^3(arrow(y)-arrow(y)')C_(alpha'beta',alpha beta)(arrow(x),arrow(y))e^(-E(R)T)
$]
という形になることが期待できる。ただし $R=abs(arrow(x)-arrow(y))$ と置いた。

$G_(alpha'beta',alpha beta)$ の右辺は経路積分で表すと
#number[$
G_(alpha'beta',alpha beta)&=1/Z integral D A D psi D overline(psi)D psi^((Q)) D overline(psi)^((Q)) overline(psi)_(beta')^((Q))(arrow(y)',t)U(arrow(y)',t;arrow(x)',t)psi_(alpha')^((Q))(arrow(x)',t)\
&quad times overline(psi)_alpha^((Q))(arrow(x),0)U(arrow(x),0;arrow(y),0)psi_beta^((Q))(arrow(y),0)e^(i S)
$]
となる。ここで、作用は
#number[$
S=S_G [A]+S_F [psi,overline(psi),A]+S_Q [psi^((Q)),overline(psi)^((Q)),A]
$]
と書け、$psi^((Q)),overline(psi)^((Q))$ に関する部分は
$
S_Q [psi^((Q)),overline(psi)^((Q)),A]=integral d^4x overline(psi)^((Q))(i gamma^mu D_mu-M_Q)psi^((Q))
$
と $psi^((Q)),overline(psi)^((Q))$ について双線型なので、積分が普通に実行できる。
#number[$
G_(alpha'beta',alpha beta)&=-1/Z integral D A D psi D overline(psi)[S_(beta'beta)(y,y';A)S_(alpha'alpha)(x',x;A)-S_(alpha'beta')(x',y';A)S_(beta alpha)(y,x;A)]\
&times U(arrow(x),0;arrow(y),0)U(arrow(y)',t;arrow(x)',t)det K^((Q))[A]e^(i S_G+i S_F)
$]
ここで、
#number[$
  x=(arrow(x),0),quad y=(arrow(y),0),\
  x'=(arrow(x)',t),quad y'=(arrow(y)',t)
$]
と置き、$S(z,z';A)$ は
#number[$
  [i gamma^mu (diff_mu+i e A_mu (z))-M_Q]S(z,z';A)=delta^3 (arrow(z)-arrow(z)')delta(t-t')
$]
の解とした。$det K^((Q))[A]$ は行列
$
K^((Q))_(alpha x,beta y)=[i gamma^mu (diff_mu+i e A_mu (z))-M_Q]_(alpha beta)delta^4(x-y)
$
の行列式であるが、$M_Q->infinity$ とすることを考えると $Z$ の方に出てくる行列式と相殺すると考えられるので $det K^((Q))=1$ とする。

よく分からないが $M_Q->infinity$ だと空間成分が無視できて
#number[$
  [i gamma^0 (diff_0+i e A_0 (z))-M_Q]S(z,z';A)=delta^4 (z-z')
$]
としていいらしい。これは
#number[$
  S(z,z';A)=exp(i e integral_(z_0)^(z'_0)d t A_0(arrow(z),t))hat(S)(z-z')
$]
と置くと
#number[$
  [i gamma^0 diff_0-M_Q]hat(S)(z-z')=delta^4 (z-z')
$]
と書ける。この解はFourier変換で
#number[$
  S(z,z';A)&=delta^3(arrow(z)-arrow(z)')exp(i e integral_(z_0)^(z'_0)d t A_0(arrow(z),t)){Theta(z_0-z_0')((1+gamma_0)/2)e^(-i M_Q (z_0-z'_0))\
  &quad+Theta(z'_0-z_0)((1-gamma_0)/2)e^(i M_Q (z_0-z'_0))}
$]
となる。これを(7.13)に入れれば
#number[$
G_(alpha'beta',alpha beta)-->_(M_Q->infinity)delta^3(arrow(x)-arrow(x)')delta^3(arrow(y)-arrow(y)')(P_+)_(alpha'alpha)(P_-)_(beta beta')e^(-2i M_Q t)expval(exp(i e integral.cont d z^mu A_mu (z)))
$]
となる。ただし、
$
P_plus.minus=1/2 (1plus.minus gamma^0)
$
であり、
#number[$
expval(exp(i e integral.cont d z^mu A_mu (z)))=(integral D A D psi D overline(psi)exp(i e integral.cont d z^mu A_mu (z))e^(i S_"QED"))/(integral D A D psi D overline(psi)e^(i S_"QED"))
$]
はクォーク・反クォークを無視した基底状態での期待値である。

ここで $t->-i T,A_0->i A_4$ などとしてEuclid化を行うと
#number[$
[G_(alpha'beta',alpha beta)]_(t->-i T)-->_(M_Q->infinity)delta^3(arrow(x)-arrow(x)')delta^3(arrow(y)-arrow(y)')(P_+)_(alpha'alpha)(P_-)_(beta beta')e^(-2 M_Q T)expval(W_C [A])_"eucl."\
W_C [A]=exp(i e integral.cont d z_mu A_mu (z))\
expval(W_C [A])_"eucl."=(integral D A D psi D overline(psi)W_C [A]e^(-S_"QED"^(("eucl."))))/(integral D A D psi D overline(psi)e^(-S_"QED"^(("eucl."))))
$]
となる。$W_C [A]$ の線積分は導出の過程から $(arrow(x),0),(arrow(y),0),(arrow(y),T),(arrow(x),T)$ を順番に巡るようになっていて、*Wilsonループ*と呼ばれている。

前々からやっているように、この $W_C (A)$ の基底状態での期待値が
$
W(R,T)equiv expval(W_C [A])-->_(T->infinity)F(R)e^(-E(R)T)
$
と振る舞うことを期待しよう。そうすると
$
E(R)=-lim_(T->infinity)1/T ln expval(W_C [A])
$
となるのでエネルギーが取り出せる。

格子ではWilsonループは経路 $C$ に対して
$
W_C [U]=product_(ell in C)U_ell
$
と定義される。この基底状態での期待値
$
W(hat(R),hat(T))equiv expval(W_C [U])
$
は
$
W(hat(R),hat(T))=(integral D A D psi D overline(psi)W_C [U]e^(-S_"QED" [U,psi,overline(psi)]))/(integral D A D psi D overline(psi)e^(-S_"QED" [U,psi,overline(psi)]))
$
で与えられる。ただし $hat(R)=R\/a,hat(T)=T\/a$ である。連続極限のときと同じように
$
hat(E)(hat(R))=-lim_(hat(T)->infinity)1/(hat(T))ln W(hat(R),hat(T))
$
とすれば $q overline(q)$-ペアのエネルギー $hat(E)(hat(R))$ が求まる。

この $hat(E)(hat(R))$ には $hat(R)$ に依存しない自己エネルギーの項も入ってしまっているらしいので、引き算しないと正しいポテンシャルは出ない。だがこの式を使うことで原理的にクォーク間ポテンシャルを数値的に計算できる気がする。
