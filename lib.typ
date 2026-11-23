// Blush Report — a pink, playful, academic Typst template.
// Inspired by a pastel-pink Why3 / Software Verification report.

// All theme colours are defined here for easy customisation.
#let blush = rgb("#FFF0F6")
#let blush-light = rgb("#FFF8FB")
#let rose = rgb("#C94F83")
#let rose-dark = rgb("#793653")
#let rose-border = rgb("#E8BDD2")
#let ink = rgb("#302A30")
#let muted = rgb("#745E6A")

// Small pink label that can be reused throughout the report.
#let pink-tag(body) = box(
  fill: rgb("#FADDEB"),
  radius: 20pt,
  inset: (x: 9pt, y: 4pt),
)[
  #text(size: 8pt, weight: "bold", fill: rose-dark)[#body]
]

// Reusable highlighted note / definition / observation.
#let pink-note(body, title: "Note") = block(
  width: 100%,
  fill: blush-light,
  stroke: (paint: rose-border, thickness: 0.8pt),
  radius: 6pt,
  inset: 11pt,
  breakable: true,
)[
  #text(fill: rose, weight: "bold", size: 9.5pt)[#title]
  #v(5pt)
  #body
]

// Pink table with a coloured header row.
#let pink-table(columns, ..cells) = table(
  columns: columns,
  fill: (x, y) => if y == 0 { blush } else { white },
  stroke: (paint: rose-border, thickness: 0.7pt),
  inset: 8pt,
  ..cells,
)

// --- Pretty little graph diagrams, based on the original Why3 report. ---
// Each node is a pastel circle; graph-arrow draws an arrow between nodes.
#let graph-node(label) = box(
  width: 28pt,
  height: 28pt,
  radius: 50%,
  fill: blush,
  stroke: (paint: rose-border, thickness: 1pt),
  inset: 0pt,
)[
  #align(center + horizon)[
    #text(size: 9pt, weight: "bold", fill: ink)[#label]
  ]
]

// Use direction: "left", "right", "up", or "down".
#let graph-arrow(direction: "right") = {
  let symbol = if direction == "left" { "←" }
    else if direction == "up" { "↑" }
    else if direction == "down" { "↓" }
    else { "→" }
  text(size: 12pt, fill: rose-dark)[#symbol]
}

// Arrange arbitrary nodes and arrows on one centred line.
// Example: #graph-row(graph-node(0), graph-arrow(), graph-node(1))
#let graph-row(..elements) = {
  let cells = elements.pos()
  align(center)[
    #grid(
      columns: cells.len(),
      gutter: 10pt,
      align: center + horizon,
      ..cells,
    )
  ]
}

// A second node style for step-by-step proofs / termination variants.
#let variant-node(dst, value) = stack(
  dir: ttb,
  spacing: 3pt,
  circle(
    radius: 19pt,
    fill: blush,
    stroke: (paint: rose-border, thickness: 1pt),
  )[
    #align(center + horizon)[
      #text(size: 9pt, weight: "bold", fill: ink)[#value]
    ]
  ],
  align(center)[#text(size: 7pt, fill: muted)[dst = #dst]],
)

// Main wrapper. Used with: #show: blush-report.with(...)
#let blush-report(
  body,
  title: "Untitled report",
  subtitle: none,
  author: "Your Name",
  institution: "Your University",
  course: "Your Course",
  date: "2026",
  language: "en",
) = {
  set document(title: title, author: author)
  set page(
    paper: "a4",
    margin: (top: 2.4cm, bottom: 2.2cm, left: 2.5cm, right: 2.5cm),
    footer: context align(center)[
      #text(size: 8pt, fill: rose)[— #counter(page).display() —]
    ],
  )
  set text(font: "New Computer Modern", size: 10pt, fill: ink, lang: language)
  set par(justify: true, leading: 0.56em)
  set heading(numbering: "1.")
  show heading.where(level: 1): set text(size: 14pt, weight: "bold", fill: rose)
  show heading.where(level: 2): set text(size: 11.5pt, weight: "bold", fill: rose-dark)
  show heading.where(level: 1): set block(above: 20pt, below: 8pt)
  show heading.where(level: 2): set block(above: 12pt, below: 6pt)
  show raw: set text(size: 8.4pt)
  show raw.where(block: true): it => block(
    width: 100%,
    fill: blush,
    stroke: (paint: rose-border, thickness: 0.8pt),
    inset: 10pt,
    radius: 6pt,
    breakable: true,
  )[#it]

  [
    // Simple, centred title header, based on the original Why3 report.
    // Keep the pink styling for code, headings, notes and tables — not the title.
    #align(center)[
      #text(size: 17pt, weight: "bold", fill: ink)[#title]
      #if subtitle != none {
        v(0.25em)
        text(size: 9.5pt, fill: muted)[#subtitle]
      }
      #v(0.25em)
      #text(size: 10pt)[#course · #institution]
      #v(0.15em)
      #text(size: 9.4pt)[#date]
      #v(0.15em)
      #text(size: 9pt)[#author]
    ]
    #v(0.6em)
    #body
  ]
}
