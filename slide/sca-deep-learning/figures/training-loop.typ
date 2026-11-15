#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "lib/blocks.typ": node, arrow
#set page(width: auto, height: auto, margin: 4pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  node("input", (80, 0), [波形 $x_j$], w: 160, h: 64)
  node("network", (300, 0), [网络 $theta$], w: 190, h: 64, shade: 88%)
  node("probability", (525, 0), [类别概率], w: 170, h: 64)
  node("loss", (750, 0), [损失 $ell_j$], w: 170, h: 64)
  node("label", (750, 72), [标签 124], w: 170, h: 48)
  arrow("input.east", "network.west")
  arrow("network.east", "probability.west")
  arrow("probability.east", "loss.west")
  arrow("label.south", "loss.north")
  content((300, 67), [① 前向：算出预测与损失])

  line("loss.south", (750, -60), (300, -60), "network.south",
    stroke: (paint: luma(30%), thickness: 1.2pt, dash: "dashed"),
    mark: (end: ">", fill: luma(30%), length: 9pt, width: 7pt))
  content((525, -90), [② 反向：求梯度，更新权重])
})
