#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.5" as fletcher: edge, node
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

// Set Chinese fonts for the presentation
// If the fonts are not installed, you can find new fonts to replace them. by the `typst fonts`.
#set text(
  font: (
    "Source Han Serif", // Alternative Chinese serif font
  ),
  // lang: "zh",
  // region: "cn",
)

// Color shorthand functions
#let redt(content) = text(fill: red, content)
#let bluet(content) = text(fill: blue, content)
#let greent(content) = text(fill: green, content)
#let yellowt(content) = text(fill: yellow, content)
#let oranget(content) = text(fill: orange, content)
#let purplet(content) = text(fill: purple, content)
#let greyt(content) = text(fill: gray, content)
#let grayt(content) = text(fill: gray, content)

// Additional font customization options:
#show heading: set text(font: "Source Han Sans", weight: "bold")
#show raw: set text(font: "Source Han Mono SC")
// Use monospace font for emphasis since Chinese fonts don't have italic
#show emph: set text(font: "Source Han Mono SC")

#set heading(numbering: numbly("{1}.", default: "1.1"))

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [回望三年硕士],
    subtitle: [得与失],
    author: [isomo],
    date: datetime.today(),
    institution: [Hengyang normal university],
    // logo: emoji.school,
  ),
)

// Set up bibliography
#set bibliography(style: "apa")

// Customize footnote appearance for citations
// #show footnote.entry: set text(size: 8pt)
#show footnote: super

#title-slide()

== Outline <touying:hidden>

#components.adaptive-columns(outline(title: none, indent: 1em))

= 前言

== Why wiritng this Slide?

+ 2025-11-01 17:13 👀了一篇数学大佬的生平 #footnote[#link("https://www.ee.cityu.edu.hk/~gchen/pdf/MyStory(2025).pdf")] ，感触蛮多，从文革中保持对数学的*热爱与坚持*，到美国求学，再到回国任教，一路走来，充满了坎坷与挑战，但最终取得了巨大的成就。
+ 致使突然想写点东西，再者之前一直有个idea，想回顾一下三年的_得与失_，刻画一下自己的状态，方便plan一下之后的事项。
+ 再者希望我们的反思，能对他人有点启示，在离开学校前，起于研一的学术沙龙分享，望于离开之前在讲一次，也算是*有始有终*。

== 内容地图🗺

- 首先应该是基础的背景信息💬回顾（论文写的思维固化了）
- 再着就是对三年自己时间的分配的回顾，简而言之，*做了啥*
- 重点来了，对自己的得与失，进行_分析_
- 最后总结展望一下↓

= 背景回顾

#pagebreak()
ss

= 做了什么

= 做的何如
 
= 总结展望


#show: appendix

= Appendix

== References

#bibliography("references.bib", title: none)

