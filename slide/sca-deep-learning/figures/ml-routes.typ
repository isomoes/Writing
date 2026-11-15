#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "../notation.typ": HW
#import "lib/blocks.typ": node, arrow
#set page(width: auto, height: auto, margin: 4pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  let rows = (
    ([前面的分类], [$x$], [$q_(theta)(z|x)$\ 学习类别概率], [概率累计\ $D_("NN")$], 88%),
    ([最初的 CPA], [$z$], [$h(z)=HW(z)$\ 手工泄漏预测], [相关性\ $D_("CPA")$], 96%),
    ([现在：NLM], [$z$], [$g_(theta)(z)$\ 学习泄漏预测], [相关性\ $D_("CPA")$], 88%),
  )
  for (j, row) in rows.enumerate() {
    let y = -96*j
    content((0, y), row.at(0), anchor: "west")
    node("input"+str(j), (225, y), row.at(1), w: 80, h: 64)
    node("model"+str(j), (440, y), row.at(2), w: 240, h: 76, shade: row.at(4))
    node("stat"+str(j), (725, y), row.at(3), w: 210, h: 76)
    arrow("input"+str(j)+".east", "model"+str(j)+".west")
    arrow("model"+str(j)+".east", "stat"+str(j)+".west")
  }
})
