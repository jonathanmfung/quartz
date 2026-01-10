---
title: Anki
date: 2025-08-25T15:48:57-0700
tags:
  - anki
---

> [!note]Resources
> [@wozniakEffectiveLearningTwenty1999],[@nielsenAugmentingLongtermMemory2018], [@nielsenUsingSpacedRepetition2019]

# Tips for Creating Notes #
## Atomicity ##
The front question should have just-enough context and be unambigious. The answer should be "obvious" if you can recall it.

Related to the _Minimum Information Principle_. Cards should be straight-forward. It is better to have many simple items over few complex items.

## Extract Literature with Clozes ##
Suppose a resource contains the sentence: "Cloze deletion is the process of hiding one or more words in a sentence". This can be converted into the cloze note:

> Cloze {{c1::deletion}} is the process of hiding {{c2::one or more words}} in a sentence

This note results in two cards:
> Cloze [...] is the process of hiding one or more words in a sentence

> Cloze deletion is the process of hiding [...] in a sentence

## Learn List and Enumerations with Cloze Overlapper ##
I use [michalrus' anki-simple-cloze-overlapper](https://github.com/michalrus/anki-simple-cloze-overlapper) to help memorize enumerations. Each note should still be a manageable length, ~6 or fewer items. Taking note from [@wozniakEffectiveLearningTwenty1999]'s Step 9, try to split up larger lists into semantic chunks.

Cloze overlapping is usually used to show the preceding cloze and hide everything else, e.g.:
> ```text title="Card 1"
> 1. [..]
> 2. -
> 3. -
> ```
> ```text title="Card 2"
> 1. foo
> 2. [..]
> 3. -
> ```
> ```text title="Card 3"
> 1. -
> 2. bar
> 3. [..]
> ```

## Read and Understand the material beforehand ##
- If you blindly create Anki notes from a resource, the knowledge has no context in your mental modeling system.
- Skimming and briefly understanding the material allows you to:
    - figure out which facts are important to remember
    - put the facts into context and see how they connect to each other and prior knowledge

# Tips for Consistency #
- Split up sessions throughout the day, e.g. 30 min in the morning + 30 min at night.
- Use text-to-speech feature and a bluetooth remote (controller) so that you can anki while walking or riding an exercise bike
