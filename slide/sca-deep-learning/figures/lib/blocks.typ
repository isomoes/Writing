#import "@preview/cetz:0.3.4"
#let node(name, pos, body, w: 190, h: 72, shade: 95%) = {
  cetz.draw.rect((rel: (-w/2, -h/2), to: pos), (rel: (w/2, h/2), to: pos),
    name: name, fill: luma(shade), stroke: 1pt + luma(35%), radius: 5pt)
  cetz.draw.content(pos, align(center, body))
}
#let arrow(..points) = cetz.draw.line(..points.pos(),
  stroke: 1.2pt + luma(30%), mark: (end: ">", fill: luma(30%), length: 9pt, width: 7pt))
