#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "lib/bit-transition.typ": bit-transition
#set page(width: auto, height: auto, margin: 4pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  bit-transition([r16 旧值 $r$], (0, 0, 0, 0, 0, 0, 0, 1),
    new-label: [r16 新值 $z$], caption: [深色列：r16 写回时翻转的位])
})
