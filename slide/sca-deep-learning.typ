// Build: python slide/sca-deep-learning/build.py
#import "@preview/touying:0.6.1": *
#import themes.simple: *
#import "sca-deep-learning/style.typ": *
#import "sca-deep-learning/notation.typ": *
#import "sca-deep-learning/sources.typ": source

#let visual(name) = align(center, image("sca-deep-learning/figures/" + name + ".svg"))
#let original(name, width: auto, height: auto) = image(
  "sca-deep-learning/paper-figures/" + name + ".png",
  width: width, height: height, fit: "contain")
#let cite(key, detail: none) = { v(1fr); source(key, detail: detail) }
#let footnote-line(body) = { v(1fr); text(size: 10.5pt, fill: muted, body) }
#let big-equation(body) = align(center, text(size: 30pt, body))
#let bridge(body) = block(below: 12pt, text(size: 20pt, fill: muted, body))

#show: simple-theme.with(
  aspect-ratio: "16-9",
  primary: accent,
  header: text(size: 10.5pt)[密钥区分器 · Oracle · 机器学习],
  header-right: text(size: 10.5pt)[功耗侧信道分析],
  footer: text(size: 10.5pt)[深度学习 · 侧信道分析 · 文献分享],
  subslide-preamble: block(below: 16pt,
    text(size: 30pt, weight: "bold", fill: ink,
      utils.display-current-heading(level: 2))),
  config-page(width: 960pt, height: 540pt, margin: (x: 42pt, y: 38pt)),
  config-common(show-notes-on-second-screen: none),
)
#set text(font: body-font, size: body-size, fill: ink, lang: "zh", region: "cn")
#set document(title: "从密钥区分器到学习型功耗分析", author: "向嘉豪",
  keywords: ("Oracle", "Distinguisher", "SCA", "CPA", "Deep Learning"))
#set par(leading: .4em)
#set list(spacing: .45em)
#set math.equation(block: true, supplement: none)
#show math.equation: set block(above: .4em, below: .4em)
#show raw: set text(font: "Source Han Mono SC")

#title-slide[
  #text(size: 17pt, fill: muted)[文献分享 · 从攻击框架理解论文]
  #v(28pt)
  #text(size: 44pt, weight: "bold", fill: accent)[从密钥区分器\ 到学习型功耗分析]
  #v(28pt)
  #text(size: 26pt)[Oracle 提供观测，机器学习怎样帮助区分密钥？]
  #v(32pt)
  #text(size: 18pt)[汇报人：向嘉豪]
  #v(10pt)
  #text(size: 12pt, fill: muted)[文献检索截至 2026-11-13]
]

== 哪个密钥候选更可信？

#bridge[$k$ 表示一个待检验的密钥猜测；先看“怎样比较猜测”。]
#visual("distinguisher")
#insight[密钥区分器利用观测，为候选密钥评分并排序。]
#footnote-line[条形长度为示意；具体观测与评分方法将在后面逐步给出。]
#speaker-note[从候选比较出发：假设已有若干密钥猜测，我们希望利用观测判断哪个更可信。给候选评分的规则称为密钥区分器，稍后记为D。图中的分数是示意，不表示真实实验结果，最高分也需要进一步验证。这里有两个相连的问题：候选究竟预测什么，观测又怎样支持它？下一页讨论观测从哪里来。]

== Oracle：给定输入，取得响应

#visual("oracle")
#insight[Oracle 描述可取得的观测；区分器描述如何利用观测。]
#footnote-line[$P,C$ 是完整明文块、密文块；$E$ 是加密算法；$K^*$ 是设备内的真实密钥。]
#speaker-note[Oracle就是把可访问的接口抽象成“送入输入、取得响应”。以普通加密设备为例：明文P进去，密文C出来，内部真实密钥K带星号表示真值。明文是算法的输入，不要求是自然语言。这里假设公开算法已知、密钥未知；可以选择输入或记录已知输入，具体条件由实验确定。单靠普通AES输入输出不能直接读出内部运算。接下来会增加一个观测通道：执行过程的电流变化。]

== 通用流程：查询 → 假设 → 打分 → 排名

#visual("attack-framework")
#insight[先固定一批观测，再在本地比较不同候选的预测。]
#footnote-line[以下逐步具体化两件事：测到什么，以及每个猜测能预测什么。]
#speaker-note[把实际测量与本地分析分开。上半部分对目标执行多次查询并保存数据；下半部分尝试候选并生成预测，再与同一批观测比较。因此不必为每个猜测给设备更换密钥。这里暂不引入假设中间值和评分公式，等有了具体AES例子再写。我们首先测一条波形，然后打开算法层面的黑盒，找到一个候选密钥能够预测的内部量。]

== 功耗侧信道：一次加密，还能测到执行波形

#bridge[第 $i$ 次加密：记录输入 $P_i$、输出 $C_i$，以及整段测量 $x_i$。]
#visual("measurement")
#align(center, text(size: 22pt)[$x_i=(x_(i)(1),dots,x_(i)(T))$：$T$ 个采样点；$t_0$ 是其中一个位置。])
#cite("dpa", detail: [功耗观测的经典起点；装置与波形均为示意])
#speaker-note[先读坐标：横轴是一次加密内部的采样位置t，纵轴是示波器测得的幅值。分流电阻把电流变化转成电压，后续分析把这类与功耗相关的采样统称为泄漏轨迹x。i数第几次加密，t数同一次加密里的第几个点，二者不能混淆；每条轨迹取T点。下一次换一个已知明文，密钥仍固定，就获得另一行数据。电磁探头也能产生时间序列，但测量通道不同，后面的ASCAD会明确标注。现在还不知道波形里哪一段与秘密有关，所以要先看看AES在内部算了什么。]

== S-box 查表：从汇编指令看到中间值

#bridge[
  8 位 AVR 示例：`r16` 存明文字节 $p_i="0x00"$，`r17` 存密钥字节 $k^*="0x01"$。\
  Flash 中存放 256 字节 S 盒，首址 `0x0200`；地址指针 `Z = r31:r30`。
]
#visual("aes-intermediate")
#insight[$z_i^*=Sbox(p_i xor k^*)="0x7C"$：就是写回 `r16` 的中间结果。]
#cite("avr", detail: [EOR / LDI / MOV / LPM；S盒：NIST FIPS 197, Table 4；未掩码查表示例，0x 为十六进制])
#speaker-note[这里把AES首轮的一个字节操作展开为一段具体的AVR查表实现。大写P是完整输入块，小写p是其中一个字节；r16和r17是8位寄存器，例中已经分别装入明文字节00与真实密钥字节01。EOR把异或结果01写回r16。假设256字节S盒从Flash字节地址0200开始；LDI将地址高字节r31设为02，MOV把索引01复制到低字节r30，组成Z=0201，此时r16仍为01。LPM按这个字节地址读取表项7C，并覆盖同一个寄存器r16。这个尚未成为密文的结果就是选定的中间值z_i星号。异或结果也敏感，这里只是选择S盒输出作为后续分析对象。S-box是算法映射，指令序列取决于具体实现；本例为手写说明片段，不是ASCAD固件反汇编。下一步直接从指令确定LPM写回前后的寄存器状态。]

== LPM 写回 r16：哪些位发生了翻转？

#bridge[`eor` 已让 `r16 = 0x01`；随后 `lpm r16, Z` 将它覆盖为 `0x7C`。]
#visual("register-hd")
#big-equation[$HD(r,z)=HD("0x01","0x7C")=6$]
#insight[汉明距离 HD 数翻转位；切换中的充放电会影响电流。]
#cite("cpa", detail: [§2；仅示意 r16 的状态变化，实际泄漏还涉及总线及其他电路活动])
#speaker-note[继续跟踪上一页LPM的目标寄存器r16。EOR已将01写入r16，随后的LDI与MOV不改它，因此LPM之前的旧值r确定为01，即00000001；LPM之后的新值为7C，即01111100。五个位由0变1，最低位由1变0，共翻转六位，因此HD为6。本例把S盒输入和输出复用在同一寄存器，所以旧值恰好是S盒输入；其他寄存器分配未必如此。电路表示0和1需要不同电压状态，切换伴随电容充放电并影响供电电流。HD把这一过程近似成翻转位数；实际测量还可能由数据总线、地址逻辑、存储器及其他活动主导。汇编给出状态变化的候选解释，具体主导泄漏仍需测量验证。下一页把参考状态取为零，得到只依赖新值的HW模型。]

== 从 HD 到 HW：把参考状态取为全零

#bridge[读出的字节仍为 $z="0x7C"$；零参考是模型假设，LPM 并不会先清零 r16。]
#visual("register-hw")
#align(center, text(size: 27pt)[$HD(0,z)=HW(z)=5, quad HD(r,z)=HW(r xor z)$])
#insight[HW 数新值中的 1；先用 $h(z)=HW(z)$ 预测，再由测量检验。]
#cite("cpa", detail: [§2–4；HW 是零参考特例，也常用作经验泄漏代理])
#speaker-note[新值仍是LPM读出的7C，即01111100；相对全零参考有五个位不同。HW只数一个字节中的1，所以等于5。HD需要旧、新两个值，先异或得到差异标记，再数1，因此HD(r,z)=HW(r异或z)。上一页指令给出的旧值01使HD=6，本页只是在模型中将参考状态改为零，得到HW=5；指令语义没有先清零r16这一操作。若相关数据通路有零参考，HW有直接的切换解释；在其他设备上，它也常作为有待验证的经验代理。后文选h(z)=HW(z)是为了得到只依赖候选新值的预测，并不声称上一页的寄存器真的只翻转了五位。真实信号还有比例、偏置和噪声。接下来的候选密钥都会预测同一处寄存器写入，再用模型把字节映射成可比较的量。]

== 真密钥未知，但每个猜测都能算出一个预测

#bridge[沿用 $p_i="0x00"$：每个候选 $k$ 都能预测 LPM 会向 `r16` 写入什么。]
#big-equation(byte-hypothesis)
#v(18pt)
#data-table(columns: (1fr, 1.1fr, 1.2fr, 1.2fr),
  [*候选 $k$*], [*$p_i xor k$*], [*假设值 $z_(i)(k)$*], [*预测 $HW$*],
  [0x01], [0x01], [0x7C], [5],
  [0x02], [0x02], [0x77], [6],
)
#caption[沿用 $p_i="0x00"$。表中只演示两个候选；一个字节共有 256 个候选。]
#v(10pt)
#insight[$z_i^*$ 是真实写入值；$z_(i)(k)$ 是候选 $k$ 预测的写入值。]
#cite("aes", detail: [Table 4；候选预测采用 HW 模型，统计比较见 Brier et al., 2004])
#speaker-note[此时才引入括号里的k。前面z带星号描述设备实际算出的未知值；现在z_i(k)表示攻击者在本地按候选k算出的假设值。对于同一个公开输入00，候选01给出7C、HW为5；候选02给出77、HW为6。若猜中，则假设中间值等于真值。不同中间值也可能有相同HW，单次带噪声的测量不足以可靠判断。256只对应目标字节，不是整个AES密钥空间；逐字节分析依赖这样的局部泄漏。下一页让明文变化、候选保持不变，看各个猜测产生的预测序列是否跟实际测量一起变化。]

== CPA：比较六次执行的变化趋势

#bridge[改变明文，固定时刻 $t_0$；合成观测 $x_(i)(t_0)=10+2 HW(z_i^*)+"小噪声"$。]
#text(size: 22pt)[
  #data-table(columns: (1fr, 1.3fr, 1.3fr, 1.5fr),
    [*公开字节 $p_i$*], [*$k="0x01"$*\ 预测 HW], [*$k="0x02"$*\ 预测 HW], [*观测 $x_(i)(t_0)$*],
    [0x00], [5], [6], [20.2],
    [0x10], [2], [4], [13.8],
    [0x20], [7], [4], [24.1],
    [0x30], [5], [3], [19.9],
    [0x40], [3], [3], [16.2],
    [0x50], [4], [0], [17.8],
  )
]
#v(13pt)
#align(center, text(size: 25pt)[与观测的相关系数：候选 0x01 ≈ *0.999*；候选 0x02 ≈ *0.221*。])
#cite("cpa", detail: [相关功耗分析（CPA）；本表为六条合成数据，幅值为任意单位，非实测结果])
#speaker-note[这里比较的是跨执行的两列数据。候选01在六次执行中预测HW为5、2、7、5、3、4；其变化与右列观测一致。观测有比例和偏置，不必等于5或2。这组合成数据按x=10+2×HW加微小噪声生成，真实目标字节设为01；噪声依次为0.2、−0.2、0.1、−0.1、0.2、−0.2。候选02的预测序列不同，相关系数较小。Pearson消除了整体偏置与正比例的影响，负比例则会产生负相关。这不是“六条即可攻破AES”的实验结论，只是在两个候选、一个时刻上说明评分如何计算。实际还要遍历256个候选与很多采样点。]

== 一条训练样本：实测波形 + 已知中间字节

#bridge[建模阶段用已知密钥采集 $N_p$ 条波形；$j$ 是样本编号。]
#visual("profiled")
#align(center, text(size: 22pt)[ID 标签：*124*（0–255，共 256 类）　｜　HW 标签：*5*（0–8，共 9 类）])
#insight[下面先用 ID 分类：输入是波形，已知字节 124 提供监督。]
#cite("maghrebi", detail: [经典①，SPACE 2016，§4–5；两阶段流程源于模板攻击；波形仅示意])
#speaker-note[先形成一条具体的训练样本。建模阶段可控制相同或相近实现的设备，知道本次的明文00和密钥01，离线按AES算出中间字节7C，即十进制124；同时采集这次执行的波形x_j，二者配对。这里j数建模样本，后面的i数未知密钥攻击样本。改变已知输入便能采集许多不同标签的样本，建模密钥可以固定也可以变化。ID保留字节值，标签共有0到255；HW只保留1的个数，7C对应第5类，共9类。下面先固定ID任务。输入网络的是波形；p_j和k_j在网络外用于计算监督标签。相比HW-CPA，这一路线需要已知密钥的建模数据，并要求建模与攻击的泄漏分布足够相近。]

== CNN / MLP：把一条波形变成 256 个类别概率

#bridge[MLP（多层感知机）与 CNN（卷积网络）都可完成同一个中间字节分类任务。]
#visual("classifier-output")
#align(center, text(size: 26pt)[$q_(theta)(c|x_j)=frac(exp(a_c),sum_(r=0)^255 exp(a_r)), quad c=0,dots,255$])
#v(4pt)
#caption(text(size: 18pt)[$a_c$ 是网络给第 $c$ 类的分数；Softmax 将全部分数转为概率，总和为 1。])
#insight[$theta$ 是可训练的权重与偏置；输出类别对应 S 盒字节。]
#cite("cagli", detail: [§2.3、§3.1，Eq. 3；结构为示意，概率为示例设定])
#speaker-note[一条波形是T个采样值，经过同一组参数theta得到256个实数分数a_c。MLP以全连接层组合输入，CNN以共享局部滤波器、池化及全连接层提取特征；两者都可以接相同的Softmax分类头。图中上下是二选一的结构，不是两网集成。Softmax对分数取指数再除以总和，因此输出是非负且和为1的概率向量。此例给119类0.30、真实124类0.15，其余254类合计0.55。输出第124项表示中间值等于124的预测概率；它不表示密钥字节为124的概率。theta收集网络权重和偏置，密钥不作为待训练参数。下一步需要用已知答案124判断这组输出的好坏。]

== 交叉熵：给真实类别的概率越低，损失越大

#bridge[真标签是 124；one-hot 表示 $y_(j)(c)$ 仅在 $c=124$ 时为 1，其余为 0。]
#table(
  columns: (2fr, 1fr, 1fr, 1.6fr), inset: (x: 12pt, y: 12pt),
  stroke: (bottom: .6pt + rule),
  fill: (x, y) => if x == 2 { pale } else { none },
  [*类别 $c$*], [119], [*124*], [其余 254 类],
  [目标 $y_(j)(c)$], [0], [*1*], [均为 0],
  [网络 $q_(theta)(c|x_j)$], [0.30], [*0.15*], [合计 0.55],
)
#v(12pt)
#align(center, text(size: 27pt)[$ell_j=-sum_(c=0)^255 y_(j)(c) log q_(theta)(c|x_j)=-log 0.15 approx 1.90$])
#v(8pt)
#caption(text(size: 18pt)[one-hot 让求和只剩真实类这一项；$ell_j$ 是单条样本的损失，$log$ 取自然对数。])
#insight[若给真实类的概率由 0.15 提高到 0.80，损失就由 1.90 降至 0.22。]
#cite("cagli", detail: [§2.4，Eq. 5–7；概率及损失为计算示例，非训练实验结果])
#speaker-note[交叉熵在这里比较目标分布y_j与网络预测分布q。真实标签124被写成256维one-hot：编号124这一项为1，其余为0，所以求和只剩负log q(124|x_j)。把上一页的0.15代入，损失约为1.897；若网络给真实类0.80，损失约为0.223。这里描述两种预测的损失，不声称一次更新就会从0.15跳到0.80。标签124是类别编号，损失不是预测数值与124的数值差；交叉熵关注给正确类别多少概率。虽然简式只显式读取一项，Softmax归一化使各类分数相互关联，错误类别的分数也会收到梯度。具体q减one-hot的推导和数值例子放在阅读指南。]

== 训练更新什么？沿损失梯度调整网络权重

#bridge[每次取一小批带标签波形，用它们的平均损失 $cal(L)_("CE")$ 更新参数。]
#visual("training-loop")
#align(center, text(size: 22pt)[$frac(∂ ell_j,∂ a_(124))=0.15-1=-0.85$：损失对真实类输出分数的梯度。])
#align(center, text(size: 29pt)[$theta <- theta-eta nabla_theta cal(L)_("CE")$])
#v(4pt)
#caption(text(size: 18pt)[反向传播求各参数的梯度；学习率 $eta$ 控制每次更新的幅度。])
#insight[反复更新同一组 $theta$；训练完成后冻结它，再对新波形做密钥评分。]
#cite("cagli", detail: [§2.4，Eq. 7；用普通梯度下降示意更新，具体优化器因论文而异])
#speaker-note[前向过程用当前theta把波形变成概率，再与已知标签计算损失；反向传播用链式法则算出每个权重和偏置对损失的导数。普通梯度下降沿负梯度方向更新，eta是步长。以单样本和最后一层分数为例，真实124类的导数是0.15减1，即负0.85；仅更新该类输出偏置时，减去这个负梯度会增大偏置。错误119类导数为0.30，偏置向下调整。完整训练同时更新各层参数，各样本通过小批平均共同决定更新，单个样本概率不保证每一步都提高。多条不同标签的数据迫使同一网络学习波形与标签的关联，训练效果通过独立验证集检查。建模数据总量记为N_p，一次更新用其中一小批；遍历训练集一次称一个epoch。训练完成后冻结参数：攻击阶段只做前向推理，再按候选取概率，不再拿未知真实标签计算训练损失，也不为256个候选重训256个网络。]

== 类别概率，怎样变成密钥候选的分数？

#bridge[冻结 $theta$；每条新波形只过一次网络，各候选查询自己预测的那一类。]
#text(size: 22pt)[
  #data-table(columns: (1fr, 1.7fr, 1.7fr),
    [*公开 $p_i$*], [*$k_A="0x01"$：类 → 概率*], [*$k_B="0x02"$：类 → 概率*],
    [0x00], [$124 -> 0.15$], [$119 -> 0.30$],
    [0x01], [$99 -> 0.25$], [$123 -> 0.10$],
    [0x02], [$123 -> 0.60$], [$99 -> 0.10$],
    [*概率乘积*], [*0.0225*], [*0.0030*],
  )
]
#v(8pt)
#align(center, text(size: 27pt, posterior-score))
#align(center, text(size: 18pt)[$cal(T)_N={(P_i,C_i,x_i)}_(i=1)^N$：收集到的 $N$ 次攻击观测。])
#insight[同一候选在多次观测中累积证据；取对数便于计算。]
#cite("cagli", detail: [§2.3；类别由 AES 计算，概率为示例设定；本例采用均匀 ID 标签先验])
#speaker-note[先只看第一行。明文00与候选01算出中间值7C，也就是十进制第124类，于是读取网络对第124类给出的0.15。候选02算出77，即第119类，读取同一个输出向量中的0.30。第二条波形对应新明文01，两个候选索引的类别都随之改变，但候选密钥本身不变。三条分别相乘后，候选A虽然第一条概率更低，累计却更高。为防止很多小概率相乘下溢，使用对数求和，排序等价。此表仅展示两个候选索引到的概率，类别编号为十进制。后验累计与似然排序的对应依赖先验、条件独立和域匹配等条件；HW分类还需把假设字节映射为HW类。本例用均匀ID标签先验说明累计过程。]

== 分类学会了，正确密钥就能排到前面吗？

#research-thread(1)
#bridge[实验者知道 $k^*$，每次用 $N$ 条攻击轨迹评分，记录正确字节的名次。]
#grid(columns: (1fr, 1fr), gutter: 26pt,
  panel([平均排名 GE · 越低越好], [
    $GE(N)=EE[rank(k^*;N)]$
    #v(13pt)
    #metric([1], [例：三次名次为 0、2、1])
  ]),
  panel([成功率 SR · 越高越好], [
    $SR(N)=Pr(rank(k^*;N)=0)$
    #v(13pt)
    #metric([1 / 3], [例：三次中有一次位于首位])
  ]),
)
#insight[排名从 0 开始编号；引用图沿用原论文的编号方式。]
#cite("ascad", detail: [密钥排名评价；数值为示例设定；另见 Masure et al., 2020])
#speaker-note[这里区分攻击者与实验者：攻击者不知道k星号，但评价论文的实验者知道设备预设密钥，所以能检查它的排名。给定攻击轨迹数N，多次抽样或重复实验，假设正确字节的名次为0、2、1，则平均排名GE为1，成功率SR为三分之一。增加N后重新评分，就能画出后面论文的GE曲线。分类准确率是单条波形的最大概率类别是否正确，不能替代多条概率累积后的密钥排名；CPA同样能用GE/SR评价。原文有时从1开始编号，因此读原图需保留其定义。到这里我们有了共同攻击目标，下一页把后面的阅读组织成逐层追问：能用、错位后能用、结构怎么选、学哪个环节。]

== 从可行性到学习接口：沿着四个问题推进

#bridge[沿用同一个攻击目标：让正确候选排到前面，再逐步检查成立的条件。]
#visual("problem-chain")
#footnote-line[箭头表示本次分享的追问顺序；各工作的实现、标签与数据预算在对应页给出。]
#speaker-note[这张图是后半段的阅读地图。第一步把前面讲过的训练与概率累计交给真实实验检验；可行后，运算位置变化会暴露泛化问题。卷积与增强提供办法，但核长、池化、层宽怎么选仍未解决，因此进一步诊断特征并选择结构。随后把“选什么网络”推进为“究竟让网络学习哪个未知环节”：回到CPA的手工泄漏预测，考虑只替换HW。最后通过不同实现上的简单回归基线检查模型匹配与复杂度的关系。NLM属于同一攻击框架中回到预测端的另一种接法。]

== 先验证可行性：类别概率能否形成密钥区分？

#research-thread(1)
#eyebrow[Maghrebi 2016｜DPA contest v2 · 第一 AES S 盒]
#grid(columns: (1.25fr, 1fr), gutter: 30pt,
  align(center, original("maghrebi-rank", height: 295pt)),
  [
    #v(10pt)
    #text(size: 25pt, weight: "bold")[把前面的概率累计\ 交给真实攻击数据检验]
    #v(16pt)
    #small[横轴：攻击查询数（对数轴）\ 纵轴：正确候选的平均排名\ 神经网络与模板、随机森林对照]
    #handoff(
      [该设置下，学习型分数能够区分正确候选。],
      [同一操作换了位置，概率还可靠吗？],
    )
  ],
)
#cite("maghrebi", detail: [Fig. 8，PDF p.16 · 原图裁剪，坐标与图例保留])
#speaker-note[先把这页当作前面计算链的实验检验：已知标签训练，冻结后累计概率，再看正确字节的排名。实验对象是硬件AES / DPA contest v2的第一S盒，结论对应这一设置。原文还研究软件和一阶掩码实现；网络之间的表现差异很大，例如这里LSTM并非最好。论文实验设置中每个敏感值有1000条建模轨迹，攻击集20000条分组评估。可行性并没有回答位置变化时网络是否仍读到相同模式；这正是下一步的问题。原图沿用论文的排名编号，前面的GE定义采用零起始排名。]

== 能区分还不够：同一操作换了位置怎么办？

#research-thread(2)
#bridge[沿用 $z=124$、$HW(z)=5$：操作推迟时，标签没变，波形的位置却变了。]
#visual("cnn")
#insight[卷积复用局部模式；训练还得覆盖这些位置变化。]
#cite("cagli", detail: [§3.1；波形与共享特征为示意，原文采用 HW 九分类])
#speaker-note[接住上一页的追问：相同操作可能发生在不同采样位置。这里仍用124和HW=5帮助理解；两条曲线是同一模式平移的示意，并非论文测量。卷积共享滤波器，模式移动时特征也随之移动；最终分类是否稳健还受池化、步长、边界和训练数据影响。Cagli随机延迟实验采用HW九分类，所以接前面的概率评分时，要先把z_i(k)映射为HW(z_i(k))，例如7C查第5类。论文采用四个卷积块、池化后BN、tanh及验证损失早停。结构提供了复用局部模式的能力，下一问是训练中如何让它实际见到足够的位置变化。]

== 把位置变化放进训练集，监督标签保持不变

#research-thread(2)
#eyebrow[Cagli 2017｜原文的两种训练扰动]
#align(center, original("cagli-augmentation", width: 840pt))
#v(12pt)
#grid(columns: (1fr, 1fr), gutter: 30pt,
  align(center)[*Shifting*\ 随机截取固定长度窗口],
  align(center)[*Add–Remove*\ 插入 / 删除采样点],
)
#v(10pt)
#align(center, text(size: 27pt)[$(x,HW(z)) mapsto (tau(x),HW(z))$])
#caption[贯穿例中的标签仍是 5；$tau$ 扰动时间轴，让同一监督覆盖不同位置。]
#cite("cagli", detail: [Fig. 3，PDF p.13 · 原图裁剪；原图 D、D′为轨迹长度，T 为增强范围])
#speaker-note[左图的 shifting 是从较长原始轨迹取随机偏移的固定长度窗口，目标泄漏应仍在窗口内；并非把短窗口任意补零就等价。右图插入邻近采样点的插值并删去同等数量的点，模拟局部时间变化。两种变换均试图保留目标标签，增强不增加独立物理观测。原图中 D 和 T 分别表示轨迹长度与增强范围；统一符号中的 D 表示区分器、T 表示采样点数，所以在图下注明对应关系。正文其余公式统一用 tau 表示增强。]

== 同一个 CNN：增强改变的是泛化能力

#research-thread(2)
#eyebrow[Cagli 2017｜同一 CNN · 随机延迟 · HW 九分类]
#align(center, original("cagli-learning", width: 840pt))
#v(12pt)
#grid(columns: (1fr, 1fr, 1fr), gutter: 18pt,
  metric([>1000], [无平移增强]),
  metric([101], [平移范围 100 点]),
  metric([7], [平移范围 500 点]),
)
#caption[左图训练准确率接近 100%，验证表现却很低；下方比较单字节稳定首位所需攻击轨迹数。]
#cite("cagli", detail: [Fig. 5 上排、Table 1，PDF p.15 · 原图裁剪与论文报告值；训练1000 / 验证700])
#speaker-note[先看原图，蓝色是训练准确率，绿色是验证准确率。无增强的训练曲线很快接近100%，验证却很低。三种条件的测试准确率分别为27.0%、31.8%、78.0%；不要把图中的验证准确率与测试值混为一谈。再看下方攻击条数，>1000、101、7对应原文Table1，正确候选的稳定首位标准沿用原文的一基GE。原始轨迹3996点，输入3496点，ATmega328P随机延迟实现，已有1000条建模轨迹。七条不是无训练成本的全密钥恢复结论。]

== 错位下能够区分了，网络结构该怎样选择？

#research-thread(2)
#eyebrow[Cagli 2017｜另一组 jitter 实验：较轻错位（左）、较重错位（右）]
#align(center, original("cagli-jitter-ge", width: 760pt))
#handoff(
  [在此错位条件下，CNN + 增强改善了密钥排名。],
  [卷积核、池化和层宽怎么定，必须把网络堆大吗？],
)
#cite("cagli", detail: [Fig. 7，PDF p.18 · 原图裁剪；与上一页随机延迟为不同实验])
#speaker-note[这里切换到论文的低jitter和高jitter实验，不能把上一页随机延迟实验中的“7条”套到这两幅图。原图比较未重对齐模板、重对齐模板与增强CNN，完整坐标和图例保留。共同指标是正确密钥排名。结果说明在这些条件下CNN与增强可以更有效地利用观测；下一步追问，这个网络是否一定要很大？]

== 先诊断特征，再决定该改哪一层

#research-thread(3)
#bridge[增强规定“应适应哪些变化”；结构还需决定“保留并组合哪些信息”。]
#visual("architecture-diagnosis")
#cite("zaid", detail: [§3–4，Fig. 2–3；特征诊断与结构选择的关系重绘])
#speaker-note[这一步把上一问具体化，而不是突然展示一个更小的网络。增强描述希望适应的位置变化，却没有给出核长、池化尺度和分类层宽度。Zaid先用热图观察卷积层保留的特征，并用与时间位置对应的权重可视化辅助判断哪些特征被分类层使用，再分析超参数怎样影响特征选择。图是这些诊断对象的关系概括，不是自动选型算法；可视化也不能单独证明物理因果。论文方法覆盖同步与失同步条件，下一页先选同步ASCAD的一组具体结构，再用排名和参数量检验这个选择。]

== 同步场景中，一组很小的结构就能工作

#research-thread(3)
#eyebrow[Zaid 2020｜同步 ASCAD：掩码 AES 电磁轨迹 · 700 点 · ID 256 类]
#visual("zaid-network")
#v(8pt)
#grid(columns: (1fr, 1fr, 1fr), gutter: 15pt,
  metric([16 960], [总参数（原文口径）]),
  metric([45k / 5k], [训练 / 验证]),
  metric([50], [epochs · batch 50]),
)
#cite("zaid", detail: [§5.2.3、Table 4；层配置核对作者 ASCAD/N0=0 代码；示意重绘])
#speaker-note[这是上一页结构选择问题的一个具体答案。ASCAD是公开数据基准，包含ATmega8515执行掩码AES时的电磁测量。布尔掩码把中间值表示成随机份额m与z异或m，网络需要利用联合泄漏。经典版本有50000条建模、10000条攻击，通常分析第三字节（零起始2），每条取700点。这里切换到同步版本，用原始中间字节的256类ID；与Cagli的HW九分类相比标签粒度变了，但训练后按候选查询概率的接口相同。核长1只逐位置变换，池化和Dense组合时刻。代码使用SeLU、BN、均值池化、Dense10/10/256、Adam和one-cycle，50epochs，batch50。总参数16960，含8个不参与梯度训练的BN移动统计量，可训练参数16952。论文失同步条件采用其他结构。]

== 结构匹配后，参数量与攻击条数可以同时下降

#research-thread(3)
#eyebrow[Zaid 2020｜同步 ASCAD · 单目标字节]
#grid(columns: (1.3fr, 1fr), gutter: 30pt,
  align(center, original("zaid-ge", width: 460pt, height: 245pt)),
  [
    #v(15pt)
    #metric([1146 → 191], [原 ASCAD CNN → Zaid CNN], detail: [稳定首位所需攻击轨迹])
    #v(16pt)
    #metric([66.7M → 17k], [参数规模（约数）])
  ],
)
#handoff(
  [减少参数仍能改善这个任务的排名，关键是结构匹配。],
  [学习一定要承担整个分类任务吗，还是只负责一个未知环节？],
)
#cite("zaid", detail: [Fig. 8(a) 原图裁剪；Table 4 的论文报告值，PDF p.19])
#speaker-note[左图是论文自己的同步ASCAD GE曲线，右侧数字来自同页Table4。原ASCAD CNN参数为66652444，新模型报告16960；所需轨迹分别1146与191，同步条件PCA加模板攻击为450条。图只展示新模型本身，右侧对照来自表，不是我们重新拟合或重跑的结果。原文错位50与100采用其他架构，不能把最小模型和那些结果拼接。我们已经从“是否能学”推进到“应当怎样设计学习任务”。再往攻击流程外看，AES候选计算和CPA的相关性评分本来就已知，未知的也可能只是中间值怎样产生泄漏；这引出下一种接口选择。这里并不由参数缩减推导NLM成本更低，下一步改变的是学习对象。]

== 若瓶颈在 HW，能否只学习泄漏预测？

#research-thread(4)
#bridge[前面在设计分类网络；现在回到 CPA，把学习放在未知的物理映射上。]
#visual("ml-routes")
#caption(text(size: 18pt)[同样的已知 $(z,x)$ 配对，交换输入与监督方向；候选计算与相关性仍可保留。])
#cite("nlm", detail: [§1、§4.1；ePrint 2025/1954 · 流程统一符号重绘])
#speaker-note[这里把结构匹配进一步推进到任务接口选择。回想前面的HW模型与CPA：若HW未能描述位权或非线性交互，失败的可能是预测映射h，而不是Pearson这个比较步骤。前面三项工作选择学习x到类别后验q；NLM选择学习z到泄漏g，保留已有的候选计算与相关性。三行是同一攻击框架中的两种接法以及HW基线，不是把前面的CNN接到NLM前面。NLM需要已知中间值的建模数据；改变学习职责并不自动意味着成本更低。下一页先看为什么这个替换值得做，再打开它的具体网络与训练。]

== HW 没有分开候选，问题可能在预测模型

#research-thread(4)
#eyebrow[NLM｜CHES2025 · Raspberry Pi 4B / Cortex-A72 · 功耗]
#grid(columns: (1fr, 1fr), gutter: 30pt,
  align(center)[
    *HW + CPA*
    #v(8pt)
    #original("nlm-ches-hw", height: 250pt)
  ],
  align(center)[
    *NLM + CPA*
    #v(8pt)
    #original("nlm-ches-nlm", height: 250pt)
  ],
)
#insight[同样计算相关性，更匹配的泄漏预测让正确候选显现。]
#cite("nlm", detail: [Fig. 6(a,e)，PDF p.15 · 灰线：错误候选；彩线：正确候选；NLM 需要建模数据])
#speaker-note[把这组现象放到网络细节之前，让学习接口的选择有具体动机。横轴为采样点，纵轴为绝对相关性；不是GE曲线或原始波形。相同CPA统计结构配HW时，正确候选难与错误候选区分；换成建模数据学到的NLM后，在相应时刻出现更明显的分离。因此弱HW相关不能直接解释为没有可用泄漏。目标为首轮首字节、7000点窗口，数据预算在后面的GE页一起报告。接下来要问的是：g_theta如何从一个字节产生这一段预测？]

== 同一对字节与波形：这次由字节预测泄漏

#research-thread(4)
#eyebrow[NLM｜输入中间值，监督目标是实测波形]
#grid(columns: (1.15fr, 1fr), gutter: 32pt,
  align(center, original("nlm-architecture", height: 285pt)),
  [
    #v(8pt)
    #text(size: 26pt, weight: "bold")[8 位 → MLP → $T$ 个实数]
    #v(18pt)
    $g_(theta)(z) approx EE[X|Z=z]$
    #v(18pt)
    #text(size: 20pt)[沿用 124 = 01111100：\ 这次输入它的 8 个比特，\ 用连续输出预测平均泄漏。]
    #v(18pt)
    #small[原图符号 → 统一符号\ $Y_K -> z$，$hat(Psi)_theta -> g_theta$\ 输出维数 $D -> T$]
  ],
)
#cite("nlm", detail: [Fig. 1，PDF p.7 · 原图裁剪；图中原符号保留])
#speaker-note[与前面分类训练的同一对已知对象作对照：分类训练把波形作为输入，用124提供类别监督；回归训练把124的8个比特作为输入，用实测波形作为连续监督。沿用的124是说明接口的例子。原图先二进制化，隐藏层学习位间交互，最后线性层输出T个实数，没有Softmax。平方损失的总体最优预测是条件均值，拟合的是可由中间值解释的泄漏部分，不是独立噪声。原图Psi_theta、D分别对应g_theta、T。这说明了单样本的预测方向，下一页把它接入训练与未知密钥攻击。]

== 冻结以后，候选只负责生成预测泄漏

#research-thread(4)
#visual("nlm")
#cite("nlm", detail: [Fig. 1、Eq. 7–8 与 CPA when using NLM；流程统一符号重绘])
#speaker-note[上排是建模阶段：已知标签 $z_j^*$ 输入网络，与对应的真实波形x_j计算回归损失。下排是攻击阶段：候选k产生z_i(k)，冻结网络生成每次执行的预测波形，然后沿不同执行比较预测与真实泄漏。在模型固定后，可以预先计算全部256个中间值的网络输出，攻击时查表。Oracle本身没有被神经网络替代，网络只替换分析端的预测环节。]

== 预测误差小，还必须通过密钥区分的检验

#research-thread(4)
#eyebrow[建模：已知 $z_j^*$，优化网络参数 $theta$]
#big-equation[$cal(L)_("MSE") = frac(1,N_p) sum_(j=1)^(N_p) norm(x_j-g_(theta)(z_j^*))^2$]
#v(20pt)
#eyebrow[攻击：在 CPA 公式中，把手工 $h(z)$ 换成网络在时刻 $t$ 的预测]
#align(center, text(size: 27pt)[$D_("CPA")(k;cal(T)_N)=max_t abs(Corr_(i)(g_(theta)(z_(i)(k))_t,x_(i)(t)))$])
#caption[沿不同执行 $i$ 计算 Pearson 相关；遍历采样位置 $t$，取绝对相关性的最大值。]
#insight[训练问“能否预测泄漏”；攻击问“能否把候选分开”。]
#cite("nlm", detail: [§4.1，Eq. 8；公式换为全篇统一符号])
#speaker-note[强调两种线性不能混淆。Pearson比较预测量与观测的线性相关性，但送入它的预测量可以是中间值的非线性函数。MSE是建模目标，相关性和密钥排名才是攻击检验；训练误差低并不自动意味着候选间可区分。模型输入的二进制化操作已吸收在g中。实际逼近条件均值的程度仍受样本、模型容量和优化影响。前面手工模型输出一个标量h(z)，这里可以为每个时刻输出不同预测。]

== 回到排名：更好的预测换来多少攻击数据？

#research-thread(4)
#eyebrow[NLM｜CHES2025 · 单字节目标]
#grid(columns: (1.2fr, 1fr), gutter: 32pt,
  align(center, original("nlm-ches-ge", height: 265pt)),
  [
    #v(16pt)
    #metric([7600], [NLM 稳定首位所需攻击轨迹])
    #v(24pt)
    #metric([45 000], [已知中间值的建模轨迹])
    #v(18pt)
    #small[列出的经典模型：10k 攻击预算内未成功]
  ],
)
#caption[图中 ID 是字节数值泄漏模型；S9 / S256 是回归基。下一问：换个实现，简单回归是否已足够？]
#cite("nlm", detail: [Fig. 7(a,b)，PDF p.15 · 原图裁剪与论文报告值；10 次重复，100 条步长])
#speaker-note[先辨认图例，避免同名术语跳跃：这里ID把字节数值z本身当泄漏预测，不是前面从波形输出类别概率的网络；HW数1；S9对八个位加偏置作线性回归；S256用完整单项式基回归；NLM用神经网络回归。GE随攻击条数变化，NLM在原文标准下需7600条达到稳定首位，其他列出模型在10000条预算内未成功。学习型模型用45000条建模数据，手工ID/HW无需这一阶段。CHES2025为树莓派4B上的未保护AES，首轮首字节、7000点窗口，乱序核使泄漏复杂。还包含每数据集100个MLP的搜索成本。下一页换到另一实现，检验简单回归是否也能拟合充分。]

== 换一个实现：简单回归可能已经足够

#research-thread(4)
#eyebrow[NLM｜AES_HD · FPGA · 末轮相关目标]
#grid(columns: (1.2fr, 1fr), gutter: 30pt,
  align(center, original("nlm-aeshd-ge", height: 245pt)),
  [
    #v(18pt)
    #metric([2700 / 2900], [S9 / NLM 的攻击轨迹数])
    #v(25pt)
    #text(size: 23pt)[S9：偏置 + 8 比特线性回归]
    #v(20pt)
    #small[相同 45k 建模预算\ NLM 另有网络搜索成本]
  ],
)
#insight[模型与实际泄漏的匹配程度，比网络复杂度本身更重要。]
#cite("nlm", detail: [Fig. 3(a,b)，PDF p.12 · 原图裁剪；模型搜索见 §5.1])
#speaker-note[这里HW为3500、S9为2700、S256为3900、NLM为2900，S9比NLM更省攻击轨迹。这呼应结构选择阶段的认识：匹配任务比复杂本身更重要。AES_HD窗口1250点，攻击预算5000，目标与CHES2025不同，不能跨数据集比较数字大小。每个数据集搜索100个随机超参数MLP、查看CPA图再挑成功模型，结果包含模型选择过程；独立复现应在验证集选型并锁定攻击集。NLM对掩码数据还先选点并构造二阶特征，见指南。以简单基线的比较结束文献讨论，随后进入交流。]

== 感谢聆听

#v(80pt)
#align(center)[
  #text(size: 48pt, weight: "bold", fill: accent)[谢谢大家！]
  #v(24pt)
  #text(size: 26pt, fill: muted)[欢迎交流与指正]
  #v(40pt)
  #text(size: 22pt)[汇报人：向嘉豪]
]
