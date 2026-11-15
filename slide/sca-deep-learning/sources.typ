// Author-year identifiers are stable links, not hand-maintained citation numbers.
#let papers = (
  aes: (short: "NIST, FIPS 197 (2023 update)", authors: "National Institute of Standards and Technology", title: "Advanced Encryption Standard (AES)", venue: "FIPS 197 · editorial update 2023", url: "https://doi.org/10.6028/NIST.FIPS.197-upd1"),
  avr: (short: "Microchip, AVR Instruction Set Manual", authors: "Microchip Technology Inc.", title: "AVR Instruction Set Manual", venue: "DS40002198C · 2024 · §6.54, §6.69, §6.72, §6.75", url: "https://onlinedocs.microchip.com/oxy/GUID-0B644D8F-67E7-49E6-82C9-1B2B9ABE6A0D-en-US-23/index.html"),
  dpa: (short: "Kocher et al., 1999", authors: "Paul Kocher, Joshua Jaffe, Benjamin Jun", title: "Differential Power Analysis", venue: "CRYPTO 1999, pp. 388–397", url: "https://doi.org/10.1007/3-540-48405-1_25"),
  template: (short: "Chari et al., 2002", authors: "Suresh Chari, Josyula R. Rao, Pankaj Rohatgi", title: "Template Attacks", venue: "CHES 2002, proceedings 2003, pp. 13–28", url: "https://doi.org/10.1007/3-540-36400-5_3"),
  cpa: (short: "Brier et al., 2004", authors: "Eric Brier, Christophe Clavier, Francis Olivier", title: "Correlation Power Analysis with a Leakage Model", venue: "CHES 2004, pp. 16–29; earlier report 2003/152", url: "https://doi.org/10.1007/978-3-540-28632-5_2"),
  maghrebi: (short: "Maghrebi et al., 2016", authors: "Houssem Maghrebi, Thibault Portigliatti, Emmanuel Prouff", title: "Breaking Cryptographic Implementations Using Deep Learning Techniques", venue: "SPACE 2016, pp. 3–26 · ePrint 2016/921", url: "https://eprint.iacr.org/2016/921"),
  cagli: (short: "Cagli et al., 2017", authors: "Eleonora Cagli, Cécile Dumas, Emmanuel Prouff", title: "Convolutional Neural Networks with Data Augmentation against Jitter-Based Countermeasures — Profiling Attacks without Pre-Processing", venue: "CHES 2017, pp. 45–68 · ePrint 2017/740", url: "https://eprint.iacr.org/2017/740"),
  ascad: (short: "Benadjila et al., 2018/2020", authors: "Ryad Benadjila, Emmanuel Prouff, Rémi Strullu, Eleonora Cagli, Cécile Dumas", title: "Deep Learning for Side-Channel Analysis and Introduction to ASCAD Database", venue: "J. Cryptographic Engineering 10, 163–188 (2020) · initial ePrint 2018/053", url: "https://eprint.iacr.org/2018/053"),
  timon: (short: "Timon, 2018/2019", authors: "Benjamin Timon", title: "Non-Profiled Deep Learning-based Side-Channel Attacks with Sensitivity Analysis", venue: "TCHES 2019(2), 107–131 · earlier ePrint 2018/196", url: "https://doi.org/10.13154/tches.v2019.i2.107-131"),
  zaid: (short: "Zaid et al., 2019/2020", authors: "Gabriel Zaid, Lilian Bossuet, Amaury Habrard, Alexandre Venelli", title: "Methodology for Efficient CNN Architectures in Profiling Attacks", venue: "TCHES 2020(1), 1–36 · extended ePrint 2019/803", url: "https://eprint.iacr.org/2019/803"),
  masure: (short: "Masure et al., 2019/2020", authors: "Loïc Masure, Cécile Dumas, Emmanuel Prouff", title: "A Comprehensive Study of Deep Learning for Side-Channel Analysis", venue: "TCHES 2020(1), 348–375 · ePrint 2019/439", url: "https://eprint.iacr.org/2019/439"),
  scheme: (short: "Masure et al., 2022/2023", authors: "Loïc Masure, Valence Cristiani, Maxime Lecomte, François-Xavier Standaert", title: "Don’t Learn What You Already Know: Scheme-Aware Modeling for Profiling Side-Channel Analysis against Masking", venue: "TCHES 2023(1), 32–59 · ePrint 2022/493", url: "https://eprint.iacr.org/2022/493"),
  estranet: (short: "Hajra et al., 2023/2024", authors: "Suvadeep Hajra, Siddhartha Chowdhury, Debdeep Mukhopadhyay", title: "EstraNet: An Efficient Shift-Invariant Transformer Network for Side-Channel Analysis", venue: "TCHES 2024(1), 336–374 · ePrint 2023/1860", url: "https://eprint.iacr.org/2023/1860"),
  equiv: (short: "Perez et al., 2025", authors: "David Perez, Sengim Karayalcin, Stjepan Picek, Servio Paguada", title: "Enhancing Scale and Shift Invariance in Deep Learning-based Side-channel Attacks through Equivariant Convolutional Neural Networks", venue: "ePrint 2025/1379 · 预印本", url: "https://eprint.iacr.org/2025/1379"),
  nlm: (short: "Yap et al., 2025", authors: "Trevor Yap, Shivam Bhasin, Liu Zhang", title: "Neural Leakage Model: Correlation Power Analysis with Profiled Leakage Model using Deep Neural Networks", venue: "ePrint 2025/1954 · 预印本", url: "https://eprint.iacr.org/2025/1954"),
  generative: (short: "Boussam et al., 2026", authors: "Sana Boussam, Mathieu Carbone, Benoît Gérard, Guénaël Renault, Gabriel Zaid", title: "From Linear Regression to Generative Model for Explainable Non Profiled Side-Channel Attacks", venue: "ePrint 2026/274 · 预印本", url: "https://eprint.iacr.org/2026/274"),
  llm: (short: "Jimenez et al., 2026", authors: "Iris Dania Jimenez, Stjepan Picek, Michael Hutter", title: "The Tower of Babel: Large Language Models for Side-channel Analysis", venue: "ePrint 2026/2224 · 预印本", url: "https://eprint.iacr.org/2026/2224"),
)
#let source(key, detail: none) = {
  let p = papers.at(key)
  block(above: 7pt, below: 0pt, text(size: 10.5pt, fill: rgb("617284"))[
    #link(p.url)[#p.short]#if detail != none [ · #detail]
  ])
}
#let references(..keys) = {
  set text(size: 20pt)
  set par(leading: .4em)
  for key in keys.pos() {
    let p = papers.at(key)
    block(below: 24pt)[
      #text(weight: "bold")[#p.authors]
      #linebreak()
      #link(p.url)[#p.title]
      #linebreak()
      #text(size: .87em, fill: rgb("617284"))[#p.venue]
    ]
  }
}
