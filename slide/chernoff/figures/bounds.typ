#import "@preview/cetz:0.3.4"
#import "../style.typ": *
#set page(width: auto, height: auto, margin: 3pt)
#set text(font: body-font, size: body-size, lang: "zh")

// Same event throughout: X ~ Bin(n, 1/2), Pr[X >= 0.6n].
// Log-scale y coordinate; curves are analytical bounds, not simulations.
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  let x(n) = 45 + (n - 100) / 1900 * 470
  let y(p) = 120 + 20 * calc.log(p, base: 10)
  for j in range(0, 7, step: 2) {
    let yy = 120 - 20 * j
    line((45, yy), (515, yy), stroke: .5pt + luma(85%))
    content((35, yy), $10^#(-j)$, anchor: "east")
  }
  for n in (100, 1000, 2000) {
    line((x(n), 0), (x(n), -5), stroke: 1pt)
    content((x(n), -22), str(n))
  }
  line((45, 0), (530, 0), mark: (end: ">"), stroke: 1pt)
  line((45, 0), (45, 138), mark: (end: ">"), stroke: 1pt)
  let ns = range(100, 2001, step: 10)
  line(..ns.map(n => (x(n), y(5/6))), stroke: (paint: luma(45%), thickness: 2pt, dash: "dashed"))
  line(..ns.map(n => (x(n), y(25/n))), stroke: (paint: luma(25%), thickness: 2pt, dash: "dotted"))
  line(..ns.map(n => (x(n), y(calc.exp(-n/150)))) , stroke: 2.5pt + luma(5%))
  content((530, y(5/6)), text(size: .8em)[马尔可夫], anchor: "west")
  content((530, y(25/2000)), text(size: .8em)[切比雪夫], anchor: "west")
  content((530, y(calc.exp(-2000/150))), text(size: .8em)[切诺夫], anchor: "west")
  content((280, -48), [试验次数 $n$])
  content((45, 155), text(size: .8em)[概率上界（对数刻度）], anchor: "west")
})
