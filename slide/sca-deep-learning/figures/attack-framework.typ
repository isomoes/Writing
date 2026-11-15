#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "lib/blocks.typ": node, arrow
#set page(width: auto, height: auto, margin: 4pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  content((0, 85), [① 查询目标], anchor: "west")
  node("query", (95, 20), [多次输入], w: 190)
  node("oracle", (380, 20), [目标设备 / 接口], w: 225, shade: 88%)
  node("records", (685, 20), [保存观测], w: 190)
  arrow("query.east", "oracle.west")
  arrow("oracle.east", "records.west")
  content((0, -90), [② 本地检验], anchor: "west")
  node("guess", (95, -160), [提出候选 $k$\ 计算它的预测], w: 190, h: 80)
  node("d", (380, -160), [预测与观测比较\ 给候选打分], w: 225, h: 80, shade: 88%)
  node("rank", (685, -160), [排序\ 选分数最高者], w: 190, h: 80)
  arrow("guess.east", "d.west")
  arrow("d.east", "rank.west")
  arrow("records.south", (685, -70), (380, -70), "d.north")
})
