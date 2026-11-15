// Matrix shades illustrate indexing, not measured data or a claimed effect size.
#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "../notation.typ": Corr
#import "lib/blocks.typ": node, arrow
#set page(width: auto, height: auto, margin: 4pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  content((40, 105), [$h(z_(i)(k))$])
  content((325, 105), [$N$ 条轨迹，每条 $T$ 点])
  content((436, 76), [$t$])
  for i in range(4) {
    let y = 55 - 29*i
    rect((22, y - 25), (58, y), fill: luma((40+8*i)*1%), stroke: .6pt + white)
    for j in range(8) {
      rect((200+31*j, y - 25), (231+31*j, y),
        fill: luma((45+calc.rem(i*17+j*11,45))*1%), stroke: .6pt + white)
    }
  }
  rect((416, 57), (449, -59), fill: none, stroke: 2.4pt + luma(15%))
  arrow((-25, 53), (-25, -56))
  content((-43, 0), [$i$])
  content((40, -84), [预测列])
  content((325, -84), [每行 = 一次加密])
  node("corr", (665, 0), [$Corr_i$\ 比较两列], w: 180, h: 90, shade: 88%)
  arrow((449, -8), "corr.west")
  content((512, 36), [$x_(i)(t)$])
  arrow((58, -8), (105, -8), (105, -133), (665, -133), "corr.south")
  content((350, -133), box(fill: white, inset: 4pt)[固定 $k,t$，比较两列的变化])
})
