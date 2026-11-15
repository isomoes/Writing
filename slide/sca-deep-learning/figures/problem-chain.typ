#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "lib/blocks.typ": node, arrow
#set page(width: auto, height: auto, margin: 4pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  content((125, 39), text(size: .8em)[沿同一攻击流程继续追问])
  content((590, 39), text(size: .8em)[代表性回答])
  let rows = (
    ([① 能否区分？], [学习类别证据　#text(size: .75em)[Maghrebi 2016]]),
    ([② 错位后呢？], [卷积 + 数据增强　#text(size: .75em)[Cagli 2017]]),
    ([③ 结构怎么选？], [特征诊断与结构选择　#text(size: .75em)[Zaid 2020]]),
    ([④ 学哪一环？], [学习泄漏，接回 CPA　#text(size: .75em)[NLM 2025]]),
  )
  for (index, row) in rows.enumerate() {
    let name = "question" + str(index)
    let response = "response" + str(index)
    let y = -72 * index
    node(name, (125, y), row.at(0), w: 250, h: 44, shade: 93%)
    node(response, (590, y), row.at(1), w: 520, h: 44, shade: 98%)
    arrow(name + ".east", response + ".west")
    if index > 0 {
      arrow("question" + str(index - 1) + ".south", name + ".north")
    }
  }
})
