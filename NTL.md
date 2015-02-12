NTL: Numerical Translation Language
===================================

All Translation SHALL:
 * attempt create a notation to put into comments in the generated code
   such that the process can be reversed.

 * Use an Earley Parser similar to [Keshav](http://youtu.be/eeZ3URxd8Wc).
also used in the Grammar Spec the parser uses
 ⊤↔ 
 ⇓ 

* Use the following Language Agnostic Grammar, Boolean, & Set Logic Operands

|---|Venn Diagram|---|
|---|------------|---|
|α↓β|<object type="image/svg+xml" data="venn.svg?JointDenial=#666&ConverseNonimplication=#FFF&Nonimplication=#FFF&Conjuction=#FFF"></object>|α⇓β|
|α⇐β|<object type="image/svg+xml" data="venn.svg?JointDenial=#FFF&ConverseNonimplication=#666&Nonimplication=#FFF&Conjuction=#FFF"></object>|α←β|
|α⇒β|<object type="image/svg+xml" data="venn.svg?JointDenial=#FFF&ConverseNonimplication=#FFF&Nonimplication=#666&Conjuction=#FFF"></object>|α→β|
|α⇑β|<object type="image/svg+xml" data="venn.svg?JointDenial=#FFF&ConverseNonimplication=#FFF&Nonimplication=#FFF&Conjuction=#666"></object>|α↑β|
|α↔β|<object type="image/svg+xml" data="venn.svg?JointDenial=#666&ConverseNonimplication=#FFF&Nonimplication=#FFF&Conjuction=#666"></object>|α⇔β|
|α |<object type="image/svg+xml" data="venn.svg?JointDenial=#FFF&ConverseNonimplication=#FFF&Nonimplication=#666&Conjuction=#666"></object>|¬α |
|β |<object type="image/svg+xml" data="venn.svg?JointDenial=#FFF&ConverseNonimplication=#666&Nonimplication=#FFF&Conjuction=#666"></object>|¬β |
|⊤ |<object type="image/svg+xml" data="venn.svg?JointDenial=#666&ConverseNonimplication=#666&Nonimplication=#666&Conjuction=#666"></object>|⊥ |


|α↓β|α⇐β|α⇒β|α⇑β|---|Operator |---|Negation |
|---|---|---|---|---|-----------------------|---|---------------------|
|1 |0 |0 |0 |α↓β|Joint denial |α⇓β|Disjunction |
|0 |1 |0 |0 |α⇐β|Converse Nonimplication|α←β|Converse Implication |
|0 |0 |1 |0 |α⇒β|Nonimplication |α→β|Implication |
|0 |0 |0 |1 |α⇑β|Conjuction |α↑β|Alternative denial |
|0 |0 |1 |1 |α |Proposition α |¬α |Negation α |
|0 |1 |0 |1 |β |Proposition β |¬β |Negation β |
|1 |0 |0 |1 |α↔β|Biconditional |α⇔β|Exclusive Disjunction|
|1 |1 |1 |1 |⊤ |Tautology |⊥ |Contradiction |


"The TXL paradigm consists of parsing the input text into a structure tree,
transforming the tree to create a new structure tree, and unparsing the new tree
to a new output text"


