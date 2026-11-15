#import "@preview/cetz:0.3.4"

// The same new byte, 0x7C = 01111100, is used for both HD and HW examples.
#let bit-transition(old-label, old-bits, new-label: [新值 $z$],
  marker-label: [翻转标记], caption: [深色列：写入时发生变化的位]) = {
  import cetz.draw: *
  let new-bits = (0, 1, 1, 1, 1, 1, 0, 0)
  let changed = old-bits.zip(new-bits).map(pair => calc.abs(pair.at(0) - pair.at(1)))
  for (row, entry) in ((old-label, old-bits), (new-label, new-bits), (marker-label, changed)).enumerate() {
    let y = 70 - 78*row
    content((0, y), entry.at(0), anchor: "west")
    for (col, bit) in entry.at(1).enumerate() {
      let x = 270 + 52*col
      rect((x - 22, y - 22), (x + 22, y + 22),
        fill: if changed.at(col) == 1 { luma(82%) } else { luma(97%) },
        stroke: if changed.at(col) == 1 { 1.5pt + luma(25%) } else { .6pt + luma(70%) })
      content((x, y), str(bit))
    }
  }
  content((440, -145), caption)
}
