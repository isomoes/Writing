#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "lib/blocks.typ": node, arrow
#set page(width: auto, height: auto, margin: 4pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  set-style(stroke: 1pt + luma(30%), mark: (fill: luma(30%), length: 8pt, width: 6pt))
  let wave(t) = (5 * calc.sin(t / 12 * 1rad) +
    29 * calc.exp(-calc.pow((t - 135) / 12, 2)) -
    17 * calc.exp(-calc.pow((t - 153) / 10, 2)))
  for (index, offset) in (0, 62).enumerate() {
    let y = 58 - 116 * index
    content((18, y + 22), if index == 0 { $x$ } else { $tau(x)$ })
    line((45, y - 25), (298, y - 25), stroke: .7pt + luma(65%))
    line(..range(46, 297, step: 3).map(t => (t, y + wave(t - offset))),
      stroke: 1.6pt + luma(25%))
    rect((121 + offset, y - 23), (166 + offset, y + 35),
      stroke: (paint: luma(50%), thickness: .8pt, dash: "dashed"))
  }
  node("conv", (473, 0), [同一组卷积核\ 在各位置复用], w: 246, h: 100, shade: 88%)
  node("readout", (738, 0), [池化 + 分类\ HW 类别概率], w: 220, h: 100)
  line((300, 58), (326, 58), (326, -58), (300, -58))
  arrow((326, 0), "conv.west")
  arrow("conv.east", "readout.west")
  content((438, -128), [同一局部模式移位；目标字节与标签保持不变])
})
