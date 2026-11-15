#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "lib/bit-transition.typ": bit-transition
#set page(width: auto, height: auto, margin: 4pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  bit-transition([参考状态 $0$], (0, 0, 0, 0, 0, 0, 0, 0),
    new-label: [读出的新值 $z$], marker-label: [差异标记],
    caption: [深色列：相对全零参考不同的位])
})
