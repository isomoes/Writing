#import "../typesetting/presentations/simple.typ": *

#set text(
  font: (
    "Source Han Serif",
  ),
)

#show heading: set text(font: "Source Han Sans", weight: "bold")
#show raw: set text(font: "Source Han Mono SC")

#show: simple-theme.with(aspect-ratio: "16-9", footer: [AI能帮我们做研究吗])

#title-slide[
  = AI能帮我们做研究吗
  #v(1.5em)
  including 选刊和修文
  #v(2em)
  isomoes
  #v(1.5em)
  #datetime.today().display()
]

= Q1: Who is isomoes

== 研究侧背景 researcher

- 研究方向：#strong[密码算法高性能实现]，覆盖软硬件协同优化
- 代表性论文：#strong[IEEE Transactions on Computers, 2025]、#strong[IEEE Computer Architecture Letters, 2025]、#strong[Computers and Electrical Engineering, 2024]
- 这意味着我今天，不是站在旁观者角度，而是站在一个正在写、投、改论文的人角度

== 开发侧背景 coder

#slide(composer: (1.2fr, 1fr))[
- 现在的 GitHub 用户名是 #strong[`isomoes`]
- 技术栈偏向 #strong[Python / Rust / C / Verilog /   Linux]
- 做过的项目包括：#strong[Claude Code Zed 扩展]、#strong[All-in-MCP]、#strong[AI Video Driver]、#strong[blivedm_rs]
][
  - 当前公开统计中可见：#strong[330 Stars]、#strong[6,192 次贡献]、#strong[140 个贡献仓库]
  - 也能看到过去两周仓库被浏览量为 #strong[818]
  - 这些数据至少说明一点：我平时确实持续在写代码，也持续在把 AI 放进开发流程里反复使用和验证
]

== 我也长期在做内容表达 UP 

- B 站用户名同样是 #strong[`isomoes`]
- 视频数据、专栏数据统计截至：#strong[2026-04-15]
- 累计播放量：#strong[128,697]，点赞：#strong[2,174]，收藏：#strong[3,830]，投币：#strong[770]
- 评论：#strong[860]，分享：#strong[247]，粉丝总数：#strong[1,164]
- 这部分经历让我很在意：#strong[信息表达是否清楚，输出是否真的能帮到别人]

= Q2: 为什么今天由我来讲这个话题

== researcher：我知道研究流程里真正卡人的地方

- 从选题、检索、实验、写作到投稿和修回，我都在一线反复经历过
- 所以我关心的不只是“AI 能不能用”，而是 #strong[它能不能切进研究流程里的具体环节]
- 也就是说，我会更关注：#strong[哪里真的省时间，哪里只是看起来很聪明]

== coder：我可以把想法做成真正可用的工具

- 如果研究中某个步骤反复出现，就有机会被 #strong[流程化、工具化、自动化]
- 这意味着我不只是在体验 AI 产品，也会自己去 #strong[构建、封装、集成] 一些工具
- 对我来说，AI 帮研究的关键不只是“会不会回答”，而是 #strong[能不能稳定接进实际工作流]

== UP：我希望把有效经验讲清楚，帮到更多人

- 我不想只停留在“我自己会用”，也希望把过程、边界和坑点讲明白
- 如果某些方法真的能帮助选刊、修文、整理思路，那就值得分享出来
- 所以今天这场分享的目标很直接：#strong[把我验证过的经验讲清楚，帮大家少走一些弯路]

= A1: AI 帮我们做研究

== 核心目标：不是替我们拍脑袋，而是帮我们找到 #strong[值得解决的问题]

- AI 在研究里的第一价值，不是直接生成“研究点子”，而是先帮我们 #strong[定位问题空间]
- 这个过程通常分两步：#strong[先找最新工作]，再 #strong[分析还有什么问题值得继续做]
- 只有建立在真实、最新、相关的文献上，后面的选题判断才更可靠

== 第一步：自动跟踪重要期刊 / 会议 / 数据库的新工作

- 先让 agent 去检索最近发表的论文，看这个方向 #strong[最新已经做到哪里]
- 这样可以避免我们还在重复别人已经做完的事情
- 也能更快把注意力放到 #strong[真正还有空间的问题] 上

== 第二步：基于相关 PDF 继续抽取“还值得做什么”

- 找到最相关论文后，再让 AI 继续读 PDF，分析作者已经解决了什么、限制还在哪里
- 最关键的输出不是摘要本身，而是 #strong[哪些问题仍未解决]、#strong[哪些问题值得继续投入]
- 所以这里的重点其实是：#strong[用 AI 帮我们发现真正需要被解决的问题]

== 一个更具体的例子：#strong[`apaper-mcp`]

- 细节可以看项目 README：#link("https://github.com/ai4paper/apaper-mcp")[`https://github.com/ai4paper/apaper-mcp`]
- 这个工具的思路不是“让大模型空想研究问题”，而是先让 agent #strong[自动检索已发表工作]
- 然后基于最相关论文的 #strong[PDF 内容] 去继续分析：作者解决了什么、还剩下什么、哪些问题还值得做
- 这样一来，AI 的作用就从“泛泛聊天”变成了 #strong[围绕真实文献去定位真正需要被解决的问题]

= A2: AI agent 帮我们并行执行实验

== 核心思路：把实验流程拆开，让多个 agent 并行跑

- 当研究问题已经比较明确后，下一步往往不是继续聊天，而是 #strong[执行计划、写实现、跑验证]
- 这时候更适合让 AI agent 按任务拆分后并行工作：#strong[plan / implement / verify]
- 也就是说，我们可以把实验流程从“单线程手工推进”变成 #strong[多 agent 协同推进]

== 一个更具体的例子：#strong[`ikanban`]

#slide(composer: (1.1fr, 1fr))[
- 项目地址：#link("https://github.com/isomoes/ikanban")[`https://github.com/isomoes/ikanban`]
- 详细介绍在 docs：#link("https://github.com/isomoes/ikanban/tree/main/docs")[`/docs`]
- 它本质上是一个 #strong[multi-agent coding workspace]
- 用来驱动、协调、审查多个 agent 在同一个项目里并行工作
][
  - #strong[Home board]：集中看当前 session 状态，适合追踪实验整体进度
  - #strong[Review flow]：直接查看改动和 diff，快速检查实现是否合理
  - #strong[Task graph]：看 parent / child agent 结构，知道每个 agent 在做什么
]

== 对实验流程的意义

- 一个 agent 负责拆计划，一个 agent 写脚本或实现，一个 agent 跑检查和验证
- 人不需要退出流程，只需要在关键节点 #strong[看板式地检查、筛选和接管]
- 所以它解决的不是“AI 会不会写代码”，而是 #strong[怎么让 AI agent 更稳定地并行推进实验]

= A3: AI 帮我们更快完成论文写作

== 核心目标：不是随便润色，而是按目标期刊风格去写

- 当实验结果已经出来后，真正耗时的往往是把内容整理成 #strong[期刊能接受的表达方式]
- 这里 AI 最有价值的地方，不只是改语法，而是帮助我们统一 #strong[句子风格、段落逻辑、章节结构]
- 也就是说，AI 可以把“会写”进一步推进到 #strong[更快写成能投的版本]

== 一个更具体的例子：#strong[`ieee-journal-writing`]

#slide(composer: (1.1fr, 1fr))[
- 仓库地址：#link("https://github.com/isomoes/skills")[`https://github.com/isomoes/skills`]
- 有一个面向 #strong[IEEE journal writing] 的专用写作 skill
- 目标不是凭空生成内容，而是在 #strong[不改变技术含义] 的前提下，把草稿改成更接近投稿的样子
][
  - #strong[Sentence style]：把表达改得更正式、紧凑、符合 IEEE 风格
  - #strong[Section structure]：帮助 abstract / introduction / methods / results / conclusion 更有层次
  - etc.
]

== 对写作流程的意义

- 研究者不必每一段都从零反复打磨，可以先把技术内容写出来，再交给 AI 做期刊风格对齐
- 这样可以明显加快从 #strong[实验结果] 到 #strong[论文初稿 / 可投稿版本] 的转换速度
- 所以它解决的不是“AI 会不会写论文”，而是 #strong[怎么让 AI 更快把已有内容整理成合格论文表达]

= How To Use: 现在怎么开始用

== 长期方向：做成一个统一入口 #strong[`ipaper`]

- 项目地址：#link("https://github.com/ai4paper/ipaper")[`https://github.com/ai4paper/ipaper`]
- 它会是我们规划中的一个 #strong[all-in-one software]，把研究、实验、写作这些阶段尽量串起来
- 而且它本身也会继续保持 #strong[open source]
- 不过目前它还在开发中，目标是逐步把各阶段的 #strong[AI-native tools] 集成进去

== 现在就能用的方式：先把现有工具组合起来

- 如果现在就想开始尝试，不一定要等 `ipaper` 完成
- 已经可以把我们自己做的工具先组合起来，形成一个可用的 AI research workflow
- 一个实用组合就是：#strong[`aiapi` + `opencode` + our open-source tools]

== 一个简洁工作流

#slide(composer: (1fr, 1fr))[
- #strong[`aiapi`]：#link("https://aiapi.isomoes.site/")[`https://aiapi.isomoes.site/`]
- 作为 AI API proxy website，先把模型调用入口整理好
- 这样在切模型、接不同服务时会更方便
][
  - #strong[`opencode`]：作为 agent runtime / coding interface
  - 再结合前面这些开源工具：`apaper-mcp`、`ikanban`、`ieee-journal-writing`
  - 就可以把 #strong[找问题、跑实验、写论文] 串成一条更完整的流程
]

== 这套组合的意义

- 它不一定一开始就非常完整，但已经足够把 AI 放进真实研究流程里
- 重点不是等一个“大而全”的系统，而是先用 #strong[能工作的组合] 把效率提起来
- 如果你愿意自己动手搭一下，现在就可以开始 #strong[加速自己的 AI research journey]

= Thanks

== 感谢大家的聆听

- 如果大家有问题，欢迎现在交流
- 也欢迎会后继续联系我

*Contact*

- GitHub: #link("https://github.com/isomoes/")[`https://github.com/isomoes/`]
- Bilibili: #link("https://space.bilibili.com/136606644/dynamic")[`https://space.bilibili.com/136606644/dynamic`]
- WeChat: #strong[`isomoes`]
