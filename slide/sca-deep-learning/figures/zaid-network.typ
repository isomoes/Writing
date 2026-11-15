#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "lib/blocks.typ": node, arrow
#set page(width: auto, height: auto, margin: 4pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  node("x", (65, 0), [输入\ $700 times 1$], w: 130, h: 115)
  node("conv", (270, 0), [Conv + BN\ 4 个核 · 核长 1\ $700 times 4$], w: 210, h: 115, shade: 88%)
  node("pool", (520, 0), [平均池化\ 窗口 / 步长 2\ $350 times 4$], w: 210, h: 115)
  node("dense", (760, 0), [Dense\ $10 -> 10 -> 256$\ Softmax], w: 210, h: 115, shade: 88%)
  arrow("x.east", "conv.west")
  arrow("conv.east", "pool.west")
  arrow("pool.east", "dense.west")
  content((520, -90), [Flatten：$350 times 4 = 1400$])
  content((270, 82), [SeLU 激活])
  content((760, 82), [256 类 ID 概率])
})
