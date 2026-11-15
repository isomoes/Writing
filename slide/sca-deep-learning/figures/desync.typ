// Deterministic conceptual waveforms: no experimental data or performance claim.
#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#set page(width: auto, height: auto, margin: 3pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  set-style(stroke: 1pt + luma(35%))
  content((175, 58), [同步采样])
  content((590, 58), [随机平移后])
  for (panel, shifts) in ((0, (0, 0, 0)), (415, (0, 42, -38))) {
    for (row, shift) in shifts.enumerate() {
      let base = -row * 62
      line((panel, base), (panel + 350, base), stroke: .6pt + luma(75%))
      let points = range(176).map(j => {
        let t = 2*j
        let v = 31*calc.exp(-calc.pow((t - 145 - shift)/15, 2)) - 17*calc.exp(-calc.pow((t - 170 - shift)/12, 2)) + 2*calc.sin(t*0.25 + row)
        (panel+t, base+v)
      })
      line(..points, stroke: 1.8pt + luma(22%))
    }
    line((panel+145, 27), (panel+145, -148), stroke: (paint: luma(50%), thickness: 1pt, dash: "dashed"))
    content((panel+175, -179), text(size: .8em)[时间采样点 $t$])
  }
  content((382, -220), [同一运算的位置移动；固定时刻的相关性被稀释])
})
