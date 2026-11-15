#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "lib/blocks.typ": node, arrow
#set page(width: auto, height: auto, margin: 4pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#show raw: set text(font: "Source Han Mono SC", size: body-size)
// Hand-written AVR example: r16=p, r17=k; the 256-byte S-box starts
// at Flash byte address 0x0200. LPM uses Z=r31:r30 as a byte address.
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  content((168, 52), [执行的 AVR 指令])
  content((600, 52), [执行后的状态])
  node("xor", (168, 0), [`eor r16, r17`], w: 300, h: 48)
  node("index", (600, 0), [$"r16" = "0x00" xor "0x01" = "0x01"$], w: 430, h: 48)
  node("address", (168, -76), [`ldi r31, 0x02`\ `mov r30, r16`], w: 300, h: 80)
  node("pointer", (600, -76), [表首址 + 索引\ $Z = "0x0200" + "0x01"$], w: 430, h: 80)
  node("load", (168, -152), [`lpm r16, Z`], w: 300, h: 48, shade: 88%)
  node("value", (600, -152), [读出 `0x7C` → 写回 `r16`], w: 430, h: 48, shade: 88%)
  arrow("xor.south", "address.north")
  arrow("address.south", "load.north")
  arrow("xor.east", "index.west")
  arrow("address.east", "pointer.west")
  arrow("load.east", "value.west")
})
