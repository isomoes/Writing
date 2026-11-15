#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "../notation.typ": Sbox
#import "lib/blocks.typ": node, arrow
#set page(width: auto, height: auto, margin: 4pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  node("p", (95, 70), [明文字节 $p_i$], w: 190)
  node("k", (95, -70), [候选字节 $k$], w: 190, shade: 88%)
  circle((285, 0), radius: 27, name: "xor", fill: luma(96%), stroke: 1.2pt + luma(35%))
  content((285, 0), text(size: 1.25em)[$xor$])
  arrow("p.east", (285, 70), "xor.north")
  arrow("k.east", (285, -70), "xor.south")
  node("sbox", (465, 0), [$Sbox$\ 公开查表], w: 190, h: 88)
  node("z", (725, 0), [$z_(i)(k)$\ 假设中间值], w: 190, h: 88, shade: 88%)
  arrow("xor.east", "sbox.west")
  arrow("sbox.east", "z.west")
  content((410, -145), [$k in {0,dots,255}$：每个猜测都给出一组可检验的预测])
})
