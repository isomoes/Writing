#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "lib/blocks.typ": node, arrow
#set page(width: auto, height: auto, margin: 4pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  node("analyst", (115, 0), [攻击者\ 选择 / 记录输入], w: 230, h: 150)
  node("oracle", (640, 0), [加密设备\ 内部密钥 $K^*$], w: 250, h: 150, shade: 88%)
  arrow((230, 35), (515, 35))
  content((372, 62), [送入明文 $P$])
  arrow((515, -35), (230, -35))
  content((372, -64), [取得密文 $C$])
  content((382, -137), [普通加密接口：$C=E_(K^*)(P)$])
  content((382, 130), [Oracle：用输入与响应描述可访问的接口])
})
