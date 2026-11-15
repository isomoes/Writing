#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "lib/blocks.typ": node, arrow
#set page(width: auto, height: auto, margin: 3pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  set-style(stroke: 1pt + luma(30%), mark: (fill: luma(30%), length: 8pt, width: 6pt))
  node("p", (95, 0), [明文块 $P_i$], w: 190)
  node("dut", (400, 0), [AES 设备\ 固定密钥 $K^*$], w: 220, h: 82, shade: 85%)
  node("c", (715, 0), [密文块 $C_i$], w: 190)
  arrow("p.east", "dut.west")
  arrow("dut.east", "c.west")
  node("scope", (140, -160), [分流电阻\ + 示波器], w: 220, h: 85)
  arrow("dut.south", (400, -68), (140, -68), "scope.north")
  content((230, -91), [电流变化])
  arrow("scope.east", (320, -160))
  arrow((350, -220), (815, -220))
  arrow((350, -220), (350, -101))
  content((575, -91), [测量幅值 $x_(i)(t)$])
  let wave(t) = 20 + 45*calc.exp(-calc.pow((t - 100)/26, 2)) + 62*calc.exp(-calc.pow((t - 245)/19, 2)) + 4*calc.sin(t*0.16)
  line(..range(221).map(j => (350 + 2*j, -220 + wave(2*j))), stroke: 1.8pt + luma(25%))
  line((595, -220), (595, -115), stroke: (paint: luma(50%), thickness: 1pt, dash: "dashed"))
  circle((595, -220 + wave(245)), radius: 3pt, fill: luma(20%), stroke: none)
  content((595, -245), [$t_0$])
  content((750, -245), [采样点 $t$])
})
