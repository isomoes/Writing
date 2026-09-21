#import "@preview/cetz:0.3.4"
#import "../style.typ": *
#set page(width: auto, height: auto, margin: 3pt)
#set text(font: body-font, size: body-size, lang: "zh")

// Exact binomial mass function, not a Gaussian approximation.
#let choose(n, k) = {
  let c = 1.0
  for j in range(1, k + 1) { c = c * (n - j + 1) / j }
  c
}
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  let x(k) = 25 + k * 14
  let y(k) = choose(40, k) * calc.pow(0.5, 40) * 900
  for k in range(41) {
    rect((x(k) - 5, 0), (x(k) + 5, y(k)),
      fill: if k >= 28 { luma(15%) } else { luma(72%) }, stroke: none)
  }
  line((15, 0), (605, 0), stroke: 1pt, mark: (end: ">"))
  for k in (0, 10, 20, 28, 40) {
    line((x(k), 0), (x(k), -5), stroke: 1pt)
    content((x(k), -20), str(k))
  }
  line((x(20), 0), (x(20), 132), stroke: (paint: luma(40%), dash: "dashed", thickness: 1pt))
  content((x(20), 151), $mu = 20$)
  content((x(30), 85), [右尾：$X >= 28$])
  line((x(30), 63), (x(29), 12), stroke: 1pt, mark: (end: ">"))
  content((15, 148), text(size: .8em)[概率质量], anchor: "west")
  content((605, -20), $X$, anchor: "west")
})
