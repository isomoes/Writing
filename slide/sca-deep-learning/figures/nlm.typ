#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "../notation.typ": Sbox
#set page(width: auto, height: auto, margin: 3pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  set-style(stroke: 1pt + luma(30%), mark: (fill: luma(30%), length: 8pt, width: 6pt))
  let node(name, p, body, w: 200, h: 76) = {
    rect((rel: (-w/2, -h/2), to: p), (rel: (w/2, h/2), to: p), name: name, fill: luma(94%), radius: 4pt)
    content(p, align(center, body))
  }
  content((0, 70), [① 学习泄漏模型：中间值 → 预测波形], anchor: "west")
  node("bits", (100, 0), [已知 $z_j^*$\ 8 位二进制])
  node("mlp", (385, 0), [MLP\ 线性输出层])
  node("pred", (670, 0), [$g_(theta)(z_j^*)$\ $T$ 个实数])
  line("bits.east", "mlp.west", mark: (end: ">"))
  line("mlp.east", "pred.west", mark: (end: ">"))
  content((385, -76), [MSE：与建模轨迹 $x_j$ 比较])
  content((0, -135), [② 攻击：把学到的模型接回 CPA], anchor: "west")
  node("guess", (100, -200), [候选 $k$\ 生成 $z_(i)(k)$])
  node("leak", (385, -200), [$g_(theta)(z_(i)(k))$\ 预测泄漏])
  node("cpa", (670, -200), [与真实 $x_i$ 比较\ $D_("CPA")$])
  line("guess.east", "leak.west", mark: (end: ">"))
  line("leak.east", "cpa.west", mark: (end: ">"))
})
