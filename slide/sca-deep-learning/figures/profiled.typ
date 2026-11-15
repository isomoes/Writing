#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "../notation.typ": Sbox
#import "lib/blocks.typ": node, arrow
#set page(width: auto, height: auto, margin: 4pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  node("known", (160, 25), [已知 $p_j="0x00"$\ 已知 $k_j="0x01"$], w: 300, h: 86)
  node("label", (645, 25), [$z_j^*=Sbox(p_j xor k_j)$\ $"0x7C"=124$], w: 340, h: 86)
  arrow("known.east", "label.west")
  content((400, 49), text(size: .8em)[公开运算])

  rect((10, -156), (310, -66), name: "wave",
    fill: luma(97%), stroke: 1pt + luma(35%), radius: 5pt)
  content((160, -88), [实测波形 $x_j$])
  // Schematic only: the label comes from known p and k, not from this curve.
  let points = range(81).map(n => {
    let u = n / 80
    (35 + 250*u, -130 + 13*calc.sin(19*u)*calc.exp(-calc.pow((u - .53)/.25, 2))
      + 3*calc.sin(71*u))
  })
  line(..points, stroke: 1.2pt + luma(25%))
  node("pair", (645, -111), [一条带标签样本\ $(x_j,124)$], w: 340, h: 90, shade: 88%)
  arrow("known.south", "wave.north")
  arrow("label.south", "pair.north")
  arrow("wave.east", "pair.west")
  content((400, -87), text(size: .8em)[配对保存])
})
