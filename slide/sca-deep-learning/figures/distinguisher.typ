// Illustrative scores only; these bars are not experimental measurements.
#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "lib/blocks.typ": node, arrow
#set page(width: auto, height: auto, margin: 4pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  node("keys", (80, 0), [候选密钥\ $k_A, k_B, k_C, dots$], w: 170, h: 98)
  node("score", (350, 0), [区分器\ 按观测给候选评分], w: 225, h: 98, shade: 88%)
  node("data", (350, 125), [已有观测], w: 225, h: 56)
  arrow("keys.east", "score.west")
  arrow("data.south", "score.north")
  arrow("score.east", (515, 0))
  content((660, 122), [候选排序])
  for (j, entry) in (([$k_B$], 180), ([$k_A$], 110), ([$k_C$], 55)).enumerate() {
    let y = 65 - 67*j
    content((550, y), entry.at(0))
    rect((582, y - 13), (582+entry.at(1), y+13), fill: if j == 0 { luma(35%) } else { luma(76%) }, stroke: none)
  }
  content((660, -127), [分数越大，越可信])
})
