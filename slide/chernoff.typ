// 基于 typesetting/presentations/simple.typ：Touying 0.6.1 / simple / 16:9。
// 编译：typst compile --root . slide/chernoff.typ slide/chernoff.pdf
// 讲者模式：添加 --input notes=true（右侧显示讲者备注）。
#import "@preview/touying:0.6.1": *
#import themes.simple: *
#import "chernoff/style.typ": *

#let Pr = math.op("Pr")
#let EE = math.op("E")
#let Var = math.op("Var")
#let takeaway(body) = block(width: 100%, fill: pale, inset: 12pt, radius: 4pt, text(fill: accent, body))
#let small(body) = text(size: .8em, fill: muted, body)
#let tag(body) = block(below: 8pt, text(fill: accent, weight: "bold", body))

#show: simple-theme.with(
  aspect-ratio: "16-9",
  header: [三、随机算法 / 随机变量取值估计],
  footer: [高级算法设计与分析 · 切诺夫不等式],
  primary: accent,
  subslide-preamble: block(below: .7em,
    text(size: 1.22em, weight: "bold", fill: ink,
      utils.display-current-heading(level: 2))),
  config-common(show-notes-on-second-screen: if sys.inputs.at("notes", default: "false") == "true" { right } else { none }),
)
#set text(font: body-font, size: body-size, fill: ink, lang: "zh", region: "cn")
#set document(title: "切诺夫不等式：高级算法设计与分析", keywords: ("随机算法", "切诺夫不等式", "概率集中", "中文教学"))
#set par(leading: .6em)
#set list(spacing: .65em)
#set enum(spacing: .65em)
#set math.equation(block: true, supplement: none)

#title-slide[
  #text(size: 18pt, fill: muted)[高级算法设计与分析 · 三、随机算法]
  #v(16pt)
  #text(size: 43pt, weight: "bold", fill: accent)[切诺夫不等式]
  #v(8pt)
  #text(size: 26pt)[总量偏离平均的概率，能有多小？]
  #v(25pt)
  随机变量取值估计：马尔可夫 · 切比雪夫 · *切诺夫*
  #v(12pt)
  #small[定理与符号 · 三界对比 · 原理与应用]
]

== 切诺夫不等式：独立小贡献之和的集中保证

#set text(size: 21pt)
#set par(leading: .4em)
#show math.equation: set block(above: .45em, below: .45em)
设 $n$ 个随机变量 $X_1, dots, X_n$ *相互独立*，各取值于 $[0,1]$；*不要求同分布*。
总量为 $X$，总量的期望为 $mu$（读作“缪”），$EE$ 表示取期望：
$ X=sum_(i=1)^n X_i, quad mu=EE[X]=sum_(i=1)^n EE[X_i]>0. $

*若各项只取 0 或 1：*记 $p_i=Pr(X_i=1)$，*各次概率可以不同*，
此时 $mu=sum_(i=1)^n p_i$。只有所有 $p_i=p$ 时，才简化为 $mu=n p$。

当相对偏差 $0<delta<=1$ 时，上尾界可写成以下*分母为 3 的简式*：
#takeaway[$ Pr(X >= (1+delta)mu) <= e^(-frac(mu delta^2,3)). $]

#small[$Pr$ 表示事件的概率，$e approx 2.718$。$delta>0$ 表示向上偏离；*$delta<=1$ 是此简式的适用范围*，偏差更大仍有切诺夫界，见后面的代入页。]
#speaker-note[先明确区分独立与同分布：本课切诺夫界要求各项相互独立，不要求各项分布相同。0/1变量的成功概率用p_i表示，第i项的概率可以与其他项不同，mu=sum p_i。例如三项成功概率为0.2、0.5、0.8时，mu=1.5，仍可使用此界。只有各p_i都等于同一个p时才把求和简写为np。mu是希腊字母μ，读作缪，表示总量期望；Pr是对括号内事件取概率的记号。一般[0,1]变量仍使用各项期望之和，不能把其期望当作恰好取到1的概率。上尾简式的分母3要求0＜delta≤1。]

== 拆解公式：单次概率与总量期望是什么关系？

#set text(size: 20pt)
#set par(leading: .4em)
以 *40 次独立公平抛掷* 为例：这是各次概率恰好相同的情形。
#table(columns: (1fr, 1.6fr, 1.8fr), inset: 8pt, stroke: .5pt + rgb("D6DFE5"),
  fill: (x,y) => if y==0 { pale } else { none },
  [*符号*], [*角色 / 含义*], [*抛硬币时的对应*],
  [$n$、$i$], [项数、其中一项的编号], [$n=40$，$i=1,dots,40$],
  [$X_i$], [一次随机贡献], [正面记 1，反面记 0],
  [$p_i=Pr(X_i=1)$], [第 $i$ 次取到 1 的概率], [本例各 $p_i=p=1/2$],
  [$X=sum_(i=1)^n X_i$], [所有贡献的总和], [40 次中的正面总次数],
  [$mu=EE[X]$], [总量的期望，读作“缪”], [$mu=n p=40 times 1/2=20$ 次],
)
#v(6pt)
#takeaway[0/1 变量有 $EE[X_i]=1 times p_i+0 times (1-p_i)=p_i$，所以 $mu=sum_(i=1)^n p_i$。]
#small[$p_i$ 是单次概率，$mu$ 是期望次数，$sum$ 表示求和。*同概率是本例的选择，不是定理的要求。*]
#speaker-note[按n、Xi、p_i、X、mu逐项解释。p_i的下标强调每次可有自己的成功概率，本例的公平抛掷恰好让所有p_i都等于1/2，因此mu=40×1/2=20。Xi描述一次抛掷，X描述整组抛掷；X和mu的单位都是次数，p_i是无单位概率。期望20次不表示每组实验必定出现20次。Pr用于指定事件，例如Pr(Xi=1)与Pr(X≥28)是不同事件。单项期望等于取1概率是0/1取值的性质；一般实值随机变量不作此简化。期望线性性本身不要求独立，独立性是本课切诺夫集中结论的条件。]

== 看见“尾部”：我们真正想控制的区域

仍是 *40 次独立公平抛掷*，$mu=20$；关注 $28=(1+0.4) times 20$，即 $delta=0.4$ 的上尾。
#align(center, image("chernoff/figures/concentration.svg"))
#takeaway[每根柱子对应一个次数的概率；右侧深色柱子*加起来*，就是 $Pr(X>=28)$。]
#speaker-note[用图把定理左侧的事件与尾部面积对应起来。柱高是精确二项概率质量，不是模拟。靠近中心的取值更常见；离中心较远的部分称尾部。不要要求学生先学二项分布公式，这里只需读懂图表达什么。]

== 读懂偏差与概率：把公式代入一次

#set text(size: 21pt)
#set par(leading: .4em)
#set list(spacing: .45em)
#show math.equation: set block(above: .4em, below: .4em)
把实验增加到 *1000 次独立公平抛掷*；正面总数 $X$ 的期望为 $mu=500$。
关心事件：正面 *至少出现 600 次*。

- 绝对偏差：$t=600-500=100$ 次。
- 相对偏差：$delta=t/mu=100/500=0.2$，即比平均多 *20%*。
- 因此 $600=(1+delta)mu$，且 $0<delta<=1$，可以代入。

#takeaway[$ Pr(X>=600) <= e^(-frac(500 times 0.2^2,3)) approx 0.00127 = 0.127%. $]
#small[右边是上界，不是实际概率；$delta$ 是相对偏差，不是概率，可以大于 1。]


== 双侧界：两侧相加后，还做了一次放宽

#set text(size: 20pt)
#set par(leading: .4em)
#show math.equation: set block(above: .4em, below: .4em)
设 $X$ 为独立 $[0,1]$ 变量之和，$mu=EE[X]>0$；本页取 $0<delta<1$。

#grid(columns: (1fr, 1fr), gutter: 18pt,
  [
    #tag[上尾的概率上界]
    $ Pr(X>=(1+delta)mu)<=e^(-frac(mu delta^2,3)) $
  ],
  [
    #tag[下尾的概率上界]
    $ Pr(X<=(1-delta)mu)<=e^(-frac(mu delta^2,2)) $
  ],
)

两侧事件互斥，先加真实概率，再分别代入上界：

$ Pr(abs(X-mu)>=delta mu)
    &= Pr(X>=(1+delta)mu) + Pr(X<=(1-delta)mu) \
    &<= e^(-frac(mu delta^2,3)) + e^(-frac(mu delta^2,2)) \
    &<= 2e^(-frac(mu delta^2,3)). $

#takeaway[因为 $e^(-frac(mu delta^2,2)) <= e^(-frac(mu delta^2,3))$，可把较小的下尾界放大。
  *最后一步是“至多”，不是“等于”；保留两个不同项相加，会得到更紧的界。*]
#speaker-note[此前“因子2来自两边上界相加”的表述省略了放宽步骤，容易让学生误以为两个指数项相加恰好等于2倍上尾界。真实双侧概率等于真实上尾概率与真实下尾概率之和，因为mu>0、delta>0时两事件互斥，不需要它们独立。第一次不等号分别用各自上界；第二次不等号将exp(−mu delta²/2)放宽为更大的exp(−mu delta²/3)。上界不同不代表真实上下尾概率一定不同，例如公平二项分布在对称阈值处两侧真实概率相等。上界超过1时可与1取最小值。]

== 证明思路：切诺夫界为什么成立？

#set text(size: 20pt)
#set par(leading: .35em)
#show math.equation: set block(above: .35em, below: .35em)

#small[沿用定理条件，取 $0<delta<=1$。令阈值 $a=(1+delta)mu$；$lambda>0$ 是可选择的辅助参数。]

*① 指数变换，再用马尔可夫：把概率转成期望的上界。*
$ Pr(X>=a) = Pr(e^(lambda X)>=e^(lambda a))
  <= e^(-lambda a) EE[e^(lambda X)]. $

*② 独立性使期望可以拆开；每项取值在 $[0,1]$，使乘积有上界。*
$ EE[e^(lambda X)]
  = EE[e^(lambda X_1)] times dots times EE[e^(lambda X_n)]
  <= e^(mu (e^lambda - 1)). $

*③ 选 $lambda=ln(1+delta)$，代回前两步，再放宽成常用简式。*
#takeaway[$ Pr(X>=(1+delta)mu)
  <= e^(-mu ((1+delta) ln(1+delta)-delta))
  <= e^(-frac(mu delta^2,3)). $]
#small[$ln$ 是自然对数。最后一步使用 $(1+delta) ln(1+delta)-delta>=delta^2/3$（$0<delta<=1$）；具体代数推导省略。]
#speaker-note[先交代本页定位：前面给出定理和代入方法，这里回答它凭什么成立，展示证明思路而非完整的逐行证明。沿用相互独立、每项在[0,1]、mu=E[X]>0的条件，本页讲上尾简式。第一步：lambda>0保证指数递增，变换前后是同一事件；再对非负变量e^(lambda X)使用马尔可夫。第二步的等号有两层原因：e^(lambda sum Xi)=product e^(lambda Xi)，而相互独立使乘积的期望等于期望的乘积。乘的是指数变量的期望，不是各个尾事件的概率。有界性通过指数函数的凸性使用：对0≤x≤1，e^(lambda x)≤1+x(e^lambda−1)；取期望，再用1+u≤e^u，得到E[e^(lambda Xi)]≤exp(E[Xi](e^lambda−1))。各项相乘，指数中的期望相加为mu，得到本页第二步的不等号。对0/1变量，上面的凸性界取期望前是等号，E[e^(lambda Xi)]=1+p_i(e^lambda−1)，不要求各p_i相同。合并前两步得到Pr(X≥a)≤exp(mu(e^lambda−1)−lambda a)。令a=(1+delta)mu，对lambda求导令mu e^lambda−a=0，得到lambda=ln(1+delta)>0，代回即第三步的第一个指数。最后对0＜delta≤1使用(1+delta)ln(1+delta)−delta≥delta²/3。例如可先用ln(1+t)≥2t/(2+t)≥2t/3（0≤t≤1），再在0到delta积分得到该不等式。讲授时只需指出这一代数放宽让分母变成常数3，不要求初学者当场掌握微积分。]

== 三种不等式：使用的信息不同，保证也不同

#set text(size: 20pt)
#set par(leading: .4em)
#table(columns: (.85fr, 1.35fr, 2fr), inset: 10pt, stroke: .5pt + rgb("D6DFE5"),
  fill: (x,y) => if y==0 { pale } else { none },
  [*工具*], [*适用条件 / 所用信息*], [*常用表达式*],
  [马尔可夫], [$X>=0$，有限期望；$a>0$], [$Pr(X>=a)<=mu/a$],
  [切比雪夫], [有限方差 $sigma^2$；$t>0$], [$Pr(abs(X-mu)>=t)<=sigma^2/t^2$],
  [切诺夫（本课版本）], [独立 $[0,1]$ 项之和；\
    $mu>0$，$0<delta<=1$], [$Pr(X>=(1+delta)mu)$ \
    $<=e^(-frac(mu delta^2,3))$],
)
#v(8pt)
#small[$mu=EE[X]$，$sigma^2=Var(X)=EE[(X-mu)^2]$ 衡量波动；$a$ 是阈值，$t=delta mu$ 是绝对偏差。]
#v(8pt)
#takeaway[切诺夫利用*独立、有界的求和结构*得到指数界；马尔可夫和切比雪夫不要求这种结构，适用范围更宽。]
#speaker-note[这是一张条件与信息的比较表，不是在声称任何情形下切诺夫界都更小。马尔可夫只需非负和有限期望，切比雪夫也允许负值，只要方差有限。表中前两式不要求X本身由独立项相加。切比雪夫写成双侧，下一页通过事件包含关系比较同一个上尾事件。一般切诺夫方法并不限于此处条件，本课讲授的是独立有界变量之和的版本。]

== 同一个问题，三种上界

独立抛 1000 次公平硬币：$mu=500$，$Var(X)=250$。
估计 *同一事件* $Pr(X >= 600)$，此时 $t=100$、$delta=0.2$。

#set text(size: 21pt)
#table(columns: (1.1fr, 2.5fr, 1.15fr), inset: 10pt, stroke: .5pt + rgb("D6DFE5"),
  fill: (x,y) => if y==0 { pale } else { none },
  [*工具*], [*代入计算*], [*概率上界*],
  [马尔可夫], [$EE[X]/600 = 500/600$], [$approx 0.8333$],
  [切比雪夫], [$Pr(X>=600) <= Pr(abs(X-500)>=100)$ \
    $<= 250/100^2$], [$0.025$],
  [切诺夫（上尾）], [$e^(-frac(500 times 0.2^2,3))$], [$approx 0.00127$],
)
#v(10pt)
#takeaway[本例中，更充分地使用独立、有界的结构，得到更小的上界。]
#speaker-note[这里比较的是上界，而非真实概率；不要说失败概率“等于0.00127”。切比雪夫通过双侧事件包含单侧事件，因而仍是合法的同事件比较。没有使用更强的单侧方差界，也不宣称三种界在所有参数下都按这个顺序排列。]

== 固定相对偏差：指数下降意味着什么？

#small[独立抛 $n$ 次公平硬币，比较“正面至少占 60%”的概率上界。]
#align(center, image("chernoff/figures/bounds.svg"))
#set text(size: 20pt)
#small[纵轴为 1、0.01、0.0001……；每向下一个刻度，概率上界小 100 倍。]

#small[三条界为 $5/6$、$25/n$、$e^(-n/150)$：常数、反比、指数下降。小 $n$ 时，简化切诺夫界不一定最紧。]
#speaker-note[纵轴是对数刻度。三条曲线分别来自前面数值例子的符号化结果，n取100到2000。固定0.2相对偏差时，均值随n线性增长，才得到随n指数下降。指出左端交叉，避免“切诺夫永远更强”的误解。]

== 动机：用可接受的风险，决定投入多少资源

#set text(size: 22pt)
“平均还不错”不足以决定是否采用一个算法：一次运行也可能明显偏离平均。

#grid(columns: (1fr, 1fr), gutter: 24pt,
  [
    #tag[正向评估]
    给定重复次数或容量，\
    估计失败概率有多大。
  ],
  [
    #tag[反向设计]
    先要求失败概率低于 1%，\
    再求需要多少次、多少容量。
  ],
)
#v(12pt)
#takeaway[切诺夫界直接给出*概率上界*；算法设计用它确定*重复次数、样本量和容量余量*。]
#small[上界小于目标，就得到一个充分保证；上界较大，只说明这次分析还不能保证达标。]
#speaker-note[回答“它只是算概率吗”：数学上确实是在界定概率，但计算的目的通常是资源设计、可靠性证明或比较方案。上界已经低于需求时，不必继续求精确概率；上界高于需求时，不能据此断言算法实际失败率很高。用固定输入上的随机性来理解这一保证。]

== 抽样估计：用风险要求反求样本量

#set text(size: 21pt)
要估计数据库中某类记录的比例 $p$；假设事先知道 $p>=0.2$。
独立、均匀、有放回地抽取 $n$ 条，$X$ 为命中数，样本比例为 $hat(p)=X/n$。

*目标：*相对误差达到 20% 的概率，不超过 1%。
$ Pr(abs(hat(p)-p)>=0.2p)
  <= 2e^(-frac(n p times 0.2^2,3)) <= 2e^(-n/375) $

#takeaway[令右边不超过 $0.01$，取 *$n=1987$* 即可。
  算法由此得到一个有保证的抽样规模。]
#small[这是充分样本量。若不知道 $p$ 的正下界，不能照搬这个数字；20% 相对误差也不等于 20 个百分点。]
#speaker-note[把比例误差转为次数误差：|X/n−p|≥0.2p等价于|X−np|≥0.2np。因此在双侧切诺夫界中mu=np、delta=0.2。由p≥0.2，指数不超过−n/375。解2exp(−n/375)≤0.01得n≥375ln200≈1986.869，向上取整为1987。n取1987时右边约0.0099965。若p=0.2，20%相对误差对应0.04，即4个百分点。该例明确依赖采样方式与先验下界。]

== 负载均衡：平均每台 100 项，该预留多少？

#set text(size: 20pt)
#set par(leading: .4em)
#show math.equation: set block(above: .45em, below: .45em)
把 *10 000 项任务独立、均匀*分到 100 台服务器，单台负载 $L$ 的期望为 $mu=100$。
每项占一个容量单位；保守地把“达到容量”就记为风险。

先界定单台风险，再相加，控制“任意一台达到容量”的风险：
$ Pr("至少一台达到容量") <= 100e^(-frac(100 delta^2,3)). $

#table(columns: (1fr, .7fr, 1.45fr), inset: 9pt, stroke: .5pt + rgb("D6DFE5"),
  fill: (x,y) => if y==0 { pale } else { none },
  [*每台容量*], [*相对余量 $delta$*], [*整体风险上界*],
  [150 项], [$0.5$], [$approx 2.40%$],
  [160 项], [$0.6$], [$approx 0.0614%$],
)
#v(6pt)
#takeaway[要求整体风险低于 *0.1%*：160 项容量能得到保证；150 项的这个界不足以保证达标。]
#speaker-note[对固定服务器，不同任务的分配指示变量独立。容量c=(1+delta)100，对100台服务器取并合界；并合界本身不要求服务器负载相互独立。150的界为100exp(−100×0.5²/3)≈0.0240369；160的界为100exp(−12)≈0.000614421。到达容量视为风险比实际溢出更保守。不能说150容量的真实风险就是2.40%，也不能说160是最小可行容量。保证针对这一批任务，不自动覆盖无限时间的到达过程。]

== 参考资料

#set text(size: 19pt)
+ Alistair Sinclair，Berkeley CS174，*Chernoff/Hoeffding Bounds & Randomized Routing*。
  #link("https://people.eecs.berkeley.edu/~sinclair/cs174/routing.pdf")[上下尾的标准形式、参数范围与应用]
+ Gautam Kamath，*CS761, Lecture 2*。
  #link("https://www.gautamkamath.com/CS761notes/lec2.pdf")[矩母函数与切诺夫界的推导思路]
+ Tim Roughgarden，Stanford CS261，*Lecture 18*。
  #link("https://theory.stanford.edu/~tim/w16/l/l18.pdf")[散列、并合界与随机舍入]

#v(10pt)
#small[课件采用独立 $[0,1]$ 变量之和的乘法型简式。数值例子中的概率值是上界，样本量和容量是充分条件。]
#speaker-note[伯克利讲义给出上尾exp(−delta²mu/(2+delta))（delta>0）及其分母3的简式（0＜delta≤1）；下尾为exp(−delta²mu/2)（0＜delta＜1）。双侧先把真实概率相加，再代入各自的界，最后统一指数得到较松的2倍形式。资料用于核验与备课，注意不同讲义可能采用不同参数或常数。]
