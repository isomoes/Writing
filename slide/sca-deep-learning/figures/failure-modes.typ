// Conceptual waveforms and failure modes; no experimental data.
#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#set page(width: auto, height: auto, margin: 4pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  for (j, label) in ([时间错位], [随机掩码], [模型失配]).enumerate() {
    let x = 285*j
    rect((x, -205), (x + 260, 70), radius: 5pt, fill: luma(97%), stroke: .8pt + luma(65%))
    content((x + 130, 40), label)
  }
  for (row, shift) in (0, 43).enumerate() {
    let y = -25 - row*65
    line((20, y), (238, y), stroke: .6pt + luma(65%))
    line(..range(110).map(j => {
      let t = 2*j
      (20 + t, y + 34*calc.exp(-calc.pow((t - 85 - shift)/17, 2)))
    }), stroke: 1.8pt + luma(25%))
  }
  line((105, 10), (105, -110), stroke: (paint: luma(45%), thickness: 1pt, dash: "dashed"))
  content((130, -160), [同一操作\ 落在不同采样点])
  content((415, -20), [引入均匀随机数 $m$])
  content((415, -72), [保存为 $m$ 与 $z xor m$])
  content((415, -152), [单份额被随机化\ 两者异或恢复 $z$])
  content((700, -22), [HW 把各位等权计数])
  content((700, -80), [实际：不同位权\ 或多位交互])
  content((700, -160), [相同 HW\ 泄漏仍可能不同])
})
