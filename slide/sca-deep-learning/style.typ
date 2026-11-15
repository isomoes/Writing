// Shared by slides and standalone CeTZ figures; include SVGs at natural size.
#let body-font = ("Source Han Sans", "New Computer Modern")
#let body-size = 24pt
#let ink = rgb("203348")
#let accent = rgb("145D73")
#let muted = rgb("617284")
#let pale = rgb("EDF4F6")
#let rule = rgb("CEDAE1")
#let warm = rgb("99642E")
#let small(body) = text(size: .78em, fill: muted, body)
#let tag(body) = block(below: 8pt, text(fill: accent, weight: "bold", body))
#let takeaway(body) = block(width: 100%, fill: pale, inset: 12pt, radius: 4pt, text(fill: accent, body))
#let panel(title, body) = block(width: 100%, inset: 14pt, stroke: .6pt + rule, radius: 4pt)[
  #tag(title)
  #body
]
#let data-table(columns: auto, ..cells) = table(
  columns: columns, inset: (x: 10pt, y: 9pt),
  stroke: (bottom: .6pt + rule),
  fill: (x, y) => if y == 0 { pale } else { none },
  ..cells,
)

// Sparse slide components: one main visual, one short conclusion.
#let eyebrow(body) = block(below: 12pt, text(size: 14pt, fill: muted, body))
#let caption(body) = block(above: 7pt, text(size: 14pt, fill: muted, body))
#let insight(body) = block(above: 14pt, below: 6pt,
  width: 100%, inset: (x: 12pt, y: 8pt), fill: pale, radius: 4pt,
  text(size: 24pt, weight: "medium", fill: accent, body))
#let metric(value, label, detail: none) = align(center, stack(
  dir: ttb, spacing: 8pt,
  text(size: 42pt, weight: "bold", fill: accent, value),
  text(size: 19pt, label),
  ..if detail == none { () } else { (text(size: 13pt, fill: muted, detail),) },
))
#let symbol-card(symbol, label) = block(width: 100%, inset: 18pt, fill: pale, radius: 4pt)[
  #text(size: 30pt, fill: accent, symbol)
  #v(8pt)
  #text(size: 19pt, label)
]

// Keep the current research question visible across changes of paper and dataset.
#let research-thread(active) = {
  let stages = ("① 能区分", "② 抗错位", "③ 选结构", "④ 定接口")
  block(below: 9pt, grid(
    columns: (1fr, 1fr, 1fr, 1fr), gutter: 6pt,
    ..stages.enumerate().map(((index, label)) => block(
      width: 100%, inset: (x: 6pt, y: 4pt), radius: 3pt,
      fill: if index + 1 == active { pale } else { none },
      align(center, text(size: 16pt,
        weight: if index + 1 == active { "bold" } else { "regular" },
        fill: if index + 1 == active { accent } else { muted },
        label)),
    )),
  ))
}

#let handoff(answer, question) = block(
  above: 10pt, below: 4pt, width: 100%,
  inset: (x: 12pt, y: 8pt), fill: pale, radius: 4pt,
)[
  #text(size: 20pt)[*得到：* #answer]
  #v(4pt)
  #text(size: 20pt, fill: accent)[*追问：* #question]
]
