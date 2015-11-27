#!/usr/bin/scheme-r5rs -:s
;________________________________________________________________________LICENSE
;    Use of this software and  associated  documentation  files  (the
;    "Software"), is governed by the Creative Commons  Public  Domain
;    License(the "License"). You may obtain a copy of the License at:
;        https://creativecommons.org/licenses/publicdomain/
;_________________________________________________________R5RS SICP Compatiblity
;SICP-Book: goo.gl/gYF0pW SICP-Video-Lectures: goo.gl/3uwWXK R5RS: goo.gl/z6HMWx
(load "SICP.ss")
;_________________________________________________________________Query Language
;In SICP 1986 Lecture 8 Abelson gave a lecture on query languages, and went on a
;tangent as to the limitations of query languages, and how that the order of
;rules can vastly affect the time to resolve a match to a rule(sometimes infinite).
;Closed World Assumption- Truth vs Deducability

;https://youtu.be/R3uRidfSpc4?t=51m17s
;https://github.com/xavier/sicp-notes/blob/master/lecture_08b.md#limitations

;Bridge the gap between the imperative and the declaritive.

;Lecture 8 from the SICP-Video-Lectures decribes an entire language based upon
;(rule conclusion body);if the body is true, the conclusion is true
;(match rule ruleset);returns all matches of rule against a set of rules

;Subtle but big difference: what not means in this language is not deducible from the database, which is not the same as being not true.

;Closed world assumption: anything we don't know is considered false. This is a dangerous bias.

