#import "lib.typ": blush-report, pink-note, pink-table, graph-row, graph-node, graph-arrow, variant-node

#show: blush-report.with(
  title: "Verified Union-Find in Why3",
  subtitle: "Academic report but make it pink",
  author: "Beatriz Morais Laranjinha",
  institution: "Your University",
  course: "Your Course",
  date: "November 2026",
)

// Labelled, centred graph row
#let labelled(label, ..nodes) = align(center)[
  #text(size: 8pt, weight: "bold")[#label]
  #v(4pt)
  #graph-row(..nodes)
  #v(10pt)
]

= Introduction

An academic layout in a pink palette: technical work that stays clear and readable, with a little more fun.

#pink-note(title: "Design")[
  Pink is used for structure and highlights; body text stays easy to read.
]

= Methodology

== Invariants

Type invariants describe properties that hold for every valid state:

```why3
invariant { length link = size /\ length rank = size }
invariant { forall x:int. 0 <= x < size -> 0 <= link[x] < size }
```

== Termination

A decreasing variant proves termination:

$ "variant" = "maxd" - "dst"(y) $

== Graph diagrams

Graphs are built directly in Typst, with no images or extra packages.

#labelled("Before path compression",
  graph-node(0), graph-arrow(), graph-node(2), graph-arrow(), graph-node(4))

#labelled("After path compression",
  graph-node(0), graph-arrow(), graph-node(4), graph-arrow(direction: "left"), graph-node(2))

#labelled([Variant decreasing (`maxd = 5`)],
  variant-node(1, 4), graph-arrow(), variant-node(3, 2), graph-arrow(), variant-node(5, 0))


#pagebreak()



= Results

#pink-table(
  (1.1fr, 2fr),
  [*Element*], [*Style*],
  [Headings], [Rose pink, clear hierarchy],
  [Code blocks], [Blush background, pastel border],
  [Notes and tables], [Coordinated pink accents],
)

= Conclusion

A reusable template for university reports, assignments, and project documentation. 🎀
