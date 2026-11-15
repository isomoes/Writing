#import "@preview/cetz:0.3.4"
#import "../style.typ": body-font, body-size
#import "lib/blocks.typ": node, arrow
#set page(width: auto, height: auto, margin: 4pt)
#set text(font: body-font, size: body-size, fill: luma(18%))
#cetz.canvas(length: 1pt, {
  import cetz.draw: *
  node("input", (80, 0), [波形 $x$], w: 160, h: 82)
  node("features", (380, 0), [卷积 / 池化\ 选取时间特征], w: 250, h: 82, shade: 88%)
  node("classifier", (730, 0), [全连接层\ 组合特征、分类], w: 250, h: 82)
  arrow("input.east", "features.west")
  arrow("features.east", "classifier.west")
  node("heatmaps", (380, -119), [热图\ 保留了哪些模式？], w: 250, h: 76)
  node("weights", (730, -119), [权重可视化\ 哪些位置被使用？], w: 250, h: 76)
  arrow("features.south", "heatmaps.north")
  arrow("classifier.south", "weights.north")
  node("revise", (505, -219),
    [调整结构 → 重看特征 → 检验排名与成本],
    w: 700, h: 54, shade: 88%)
  arrow("heatmaps.south", (380, -178), (450, -178), (450, -192))
  arrow("weights.south", (730, -178), (650, -178), (650, -192))
})
