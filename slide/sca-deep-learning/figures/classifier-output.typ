#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "lib/blocks.typ": node, arrow
#set page(width: auto, height: auto, margin: 4pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  node("input", (90, 0), [波形 $x_j$\ $T$ 个采样值], w: 180, h: 86)
  node("mlp", (390, 53), [MLP · 全连接\ 加权组合 + 激活], w: 300, h: 76)
  node("cnn", (390, -53), [CNN · 卷积 / 池化\ 局部滤波 + 全连接], w: 300, h: 76)
  content((390, 118), [二选一；参数记为 $theta$])

  line("input.east", (210, 0), stroke: 1.2pt + luma(30%))
  circle((210, 0), radius: 2pt, fill: luma(30%), stroke: none)
  arrow((210, 0), (210, 53), "mlp.west")
  arrow((210, 0), (210, -53), "cnn.west")
  line("mlp.east", (575, 53), (575, 0), stroke: 1.2pt + luma(30%))
  line("cnn.east", (575, -53), (575, 0), stroke: 1.2pt + luma(30%))
  circle((575, 0), radius: 2pt, fill: luma(30%), stroke: none)

  rect((615, -91), (845, 91), name: "output",
    fill: luma(95%), stroke: 1pt + luma(35%), radius: 5pt)
  content((730, 63), [Softmax 概率])
  line((630, 38), (830, 38), stroke: .6pt + luma(65%))
  content((730, 15), [类 119：0.30])
  rect((625, -40), (835, -2), fill: luma(85%), stroke: none)
  content((730, -21), [类 124：0.15])
  content((730, -64), text(size: .8em)[其余 254 类合计 0.55])
  arrow((575, 0), "output.west")
})
