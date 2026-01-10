---
title: Standards
date: 2025-05-05T10:39:24-0700
tags:
  - standards
---

I am interested in how Standards shape the world we live in. Growing up in a globalization-dominated culture, from media to politics to business, has told me that true agreement is only possible when based on a lowest common denominator. That is, Standards are the World, and the World is Standards.

[Anushah Hossain](https://www.anushahhossain.org/) gave a wonderful talk titled "ISCII Imperialism" at [Face/Interface 2025](https://events.stanford.edu/event/faceinterface-2025-global-type-design-and-human-computer-interaction) that explored how Unicode's initial strategy of encoding the many scripts of the Indian Subcontinent had intrinsic flaws. The universality of Unicode resulted in these flaws realizing as group conflict and ideological clashes. Abstractly, Hossain's case study showed how a Standard has a lasting impact on its future self and the communities it directly and indirectly prescribes.

Standards are more than just a document. They are also the governing bodies, invested parties, and users. Some examples:
  - Unicode
      - CLDR
  - IEEE
      - 754: Floating-Point ([IEEE 754 Error Handling and Programming Languages, Nick Maclaren, March 2000](https://grouper.ieee.org/groups/1788/email/pdfmPSi1DgZZf.pdf)), 1003: POSIX
  - ANSI
  - ISO
      - 3166: Country Codes, 6346: Freight Container Identification
  - WHO
      - Family of International Classifications (FIC)
  - UN
  - SEC
      - NYSE, NASDAQ
  - Programming Languages (ISO/IEC C++, ANSI Common Lisp, source-as-reference (Rust))
  - Food Grading ([USDA Beef](https://www.ams.usda.gov/sites/default/files/media/CarcassBeefStandard.pdf))
  - Library of Congress MAchine-Readable Cataloging (MARC)
      - https://www.loc.gov/marc/faq.html#definition
      - https://www.loc.gov/marc/specifications/specchareacc/KoreanHangul.html

---

- [LangDev SE: What optimizations are possible with unsequenced operators?](https://langdev.stackexchange.com/questions/4300/what-optimizations-are-possible-with-unsequenced-operators) (emphasis my own)
    - Comment by Eric Lippert:
        - Also it is important to remember that often C leaves stuff underspecified not primarily to enable optimizations, but rather to **weaken the standard enough to ensure that many existing implementations of C can say that they conform!** Many incompatible implementations available before the standard is written is an unfortunate consequence of early adoption.
    - Comments by Steve:
        - @EricLippert, same with ANSI SQL transaction isolation levels - Oracle was allowed to treat "snapshot isolation" as "serializable", and the **standard was intentionally weakened** (and the then-current understanding of what "serializable" meant was deviated from) to allow this. It seems the **function of American standards is partly to limit further variation** (thereby privileging incumbent variations), rather than the traditional role to reduce (or at least codify the important distinctions of) extant variation and promote interchangeability. (1/2)
        - Another unfortunate consequence is that the **gaps and ambiguities introduced into language standards often end up exploited** in new ways by compiler writers for "optimisation". This is without regard to prior de-facto behaviour of incumbent compilers, the behaviour of which the gaps were formed to accomodate. And it is without regard to whether the language actually remains tractable by the programmer under the new interpretation of the language by that compiler-maker (i.e. it is without regard to one of the main concerns of a language designer - usability). (2/2)
    - Answer by André L F S Bacci:
        - I would also echo the excellent and eloquent points of Eric Lippert and Steve on the comments of the question (and encourage them to elaborate in answers), to point out that the history of C plays a very salient role here.
        - These details are underspecified on the standard of the language, not to enable unspecified future optimizations, but to **accommodate various divergent incompatible behaviours** in various compilers. Where in one vendor, compiler, or particular machine, one particular optimization is culturally acceptable, desirable and even necessary, in another it was not.
        - But by the time of language standardization, these **incompatibilities were not or could not be worked on**, so most of these historical ~~incompatibilities~~ optimizations were left intentionally unspecified.
- Comment by @caliraisin45 on[ElectroBOOM: AFCI Breaker Fights Electrical Fire!](https://www.youtube.com/watch?v=uz6xrE8WZHc&lc=UgxjdEdwLOXM33pVckt4AaABAg)
    -  In one of my previous careers I was an electrical engineer who worked on an AFCI circuit breaker design. AFCI falls under the UL 1699 standard (or for Canada CSA C22.2 NO. 270) which is interesting as it doesn’t specify how the AFCI should detect an arc, but instead lists a number of practical arcing tests that must be performed to demonstrate compliance. These tests would essentially boil down into 2 categories: series arcs and parallel arcs.
    - Series arc tests would simulate a small break/ gap in a conductor that carbonizes over time to form a high resistance current carrying path, and was tested at loads around and below the breaker rating. The thought is that if you were to turn on a high current load on such a circuit, the carbon could quickly heat up and create an ignition source, and the AFCI should trip before this happens. These tests were performed with either a carbon-carbon rod setup, where one rod is sharpened to a point (like a pencil) and placed in close proximity to the flat side of the other rod with an adjustable gap, or with a setup that would cut one of the conductors and apply a high voltage to carbonize the insulation at the break before applying a load.
    - Parallel arcs, on the other hand, simulate something that cuts the insulation and shorts across the conductors, line to neutral or line to ground, and involve currents above the breaker rating. The thought is that the breaker trip curve might not be fast enough to prevent an ignition source, so the AFCI should trip the breaker faster. These tests were performed with a guillotine setup using a razor blade to cut across the conductors.
    - In these tests, a variety of loads are used on the circuit while the arc is created, including resistors, light bulbs, power supplies, vacuum cleaners, and air compressors. In all cases, the minimum load on the circuit is 5A and go up to the breaker rating.
    - The AFCI manufacturers each use different circuit designs and algorithms to detect arcing, mainly due to numerous patents in this space. However, arc detection is generally accomplished by looking for shoulders in the current waveform (the current will drop to zero near the voltage zero crossing due to insufficient voltage to ionize the air) and high frequency noise (when the arc extinguishes and reignites this produces RF). Ground fault is another method that helps with line to ground arc detection, which you have demonstrated.
- Game Theory Economist Rick Harbaugh:
    - [Label Confusion: The Groucho Effect of Uncertain Standards](https://host.kelley.iu.edu/riharbau/Groucho.pdf)
    - [Coarse Grades: Informing the Public by Withholding Information](https://host.kelley.iu.edu/riharbau/coarsegrades.pdf)
- (De-facto standard) Stock Market Indices like Dow Jones (DJI) and S&P 500 being used as economic indicators
    - This is toeing into data methodology, but what are people thinking when they reference these indices in analyses?
    - How are the ways these indices are constructed related to resultant analyses and behavioral reactions (of traders)?
    - See [@dutermeEngineeringStockMarket2023]
