#set document(
  title: [NeurIPS 2025: Reviews],
  keywords: ("neurips", "neurips2025"))
#set par(justify: true)

= CoTAn: Numerically Stable ...

== Summary

Authors propose a SVD-compression algorithm for large linear layers in neural
networks and LLMs in particular. The algorithm exploits calibration dataset,
i.e. input activations, to achieve better accuracy and compression ratio. Also,
authors address convergence peroperties as well as numerical stability issues
of proposed method.

== Strengths And Weaknesses

- *Convergence analysis* Authors do not provide error analysis for
  original problem (1) but instead of that they prove that a solution of
  perturbed problem (3) smoothly transforms to a solution of the original
  problem (1). This fact at least guarantees that solution of problem (3) is
  (almost) equivalent to a solution of (1).

  Theoretical analysis is undoubtedly important in general. However, it has
  limitted value in this context since we still do have error analysis neither
  for (1) nor for (3).

  Argument on limitted calibration data (data 179-185) is totally unrealistic.
  How is it possible that someone wants to compress a model for more efficient
  use (= it will be used frequently) but does not have (unlabeled) data. If
  there is very a little of data then, essentially, there is no context for the
  proposed method to be called context-aware.

- *Weak connection to compression works.* In last 2-3 years, a lot of progress
  has been made in development of LLM quantization method (quantization is a
  lossy compression too!). Prior to that, around 5-6 years ago, substantial
  work was done on quantizing computer vision models.

  For example, AdaRound (Nagel et al, 2020) proposed a math framework for
  development of quantization method (any compression method). This framework
  addresses the choice of optimization problem. However, this framework poses
  the objective in (1) without any justification. Also, it is unclear why the
  authors place so much emphasis on $L_2$ regularization later in (2). $L_2$
  regularization is widely-used and well-known for about 50 years trick.

  SmoothQuant (Xiao et al, 2023), SpinQuant (Liu et al, 2024), QUIP (Chee et
  al, 2024) essentially study outliers in input activations and proposed
  compressors (quantizers) which address this issue with auxilliary rotations.
  However, this work completely ignores a probability distribution of input
  activation while claiming to be context-aware. From this point of view, it
  becomes unclear why numerical stability matters in SVD or LL decomposition
  since loss of dynamic range of floating point in LL-decomposition does not
  hurt a lot OPTQ (Frantar et al, 2022). Also, it is unclear whether Q-factor
  of QR-decomposition smooth outliers as rotation matrices in prior works on
  quantization.

  On the other hand, QR-decomposition is a common preconditioning trick for
  improving numerical stability in numerical and computational linear algebra.
  In this sense, a work consisting of just two QR preconditioners and an $L_2$
  regularizer is unlikely to be accepted at an A conference.

- *Weak empirical evaluation.* Despite that propsed algorithm is evaluated on
  large models (7B and 8B). Evaluation protocol is not optimal for multiple
  reasons.

  - Compression algorithms are expected to be practical, meaning their
    inference lattency with respect to batch size and sequence length.
  - Inference of a model in fp16 while original weights are in bfloat16
    inevitable leads to performance degradation and inaccurate evaluation
    (Table 3).
  - Perplexity is not reported whilst it is one of the most important
    characteristic of LLM. It can be evaluated on WikiText-2 (Merity et al.,
    2016) or C4 (Raffel et al., 2020)).
  - The choice of models for evaluation is not optimal. It prevents from direct
    comparison with other works. For example, the concurrent work ASVD (Yuan et
    al, 2025) uses LLaMA-2 (not LLaMA-3). Works on LLM quantization also report
    metrics on OPT and LLaMA-2 (+ instruct finetune) of different sizes (see
    AWQ (Lin et al, 2024) or (Egiazarian et al, 2024)). It is important to
    consider models of different sizes (e.g. 7B, 13B, and 30B) since larger
    models tend to compress better, but they also experience a more significant
    drop in accuracy.
  - To ensure a fair assessment of compression algorithms, it is equally
    important to report the number of bits per parameter in addition to
    compression rate.
  - Unclear evaluation protocol and experimental setup. Do tables 1 and 2
    report model compression without finetuning?
  - No ablation study. Why does context-awareness give better scores? How to
    choose proper $mu$? What factor QR-decomsition or $mu$ give more impact on
    evaluation scores?
  - (Optional) Evaluation on computer vision models.

== Paper Formatting Concerns

- *Formatting issues* The bibliography appears to be formatted with some
  inconsistencies and would benefit from careful revision. For example, entries
  [38] and [39], [8] and [9], [14] and [15], and so on are duplicated.

#let tab-scores = table(
  columns: 3,
  stroke: none,
  align: (left, center, center),
  table.hline(stroke: 0.7pt),
  [],             [Value], [Score],
  table.hline(stroke: 0.4pt),
  [Quality],      [1], [poor],
  [Clarity],      [2], [fair],
  [Significance], [1], [poor],
  [Originality],  [1], [poor],
  table.hline(stroke: 0.4pt),
  [Overall],      [1], [strong reject],
  [Confidence],   [5], [---],
  table.hline(stroke: 0.7pt),
)

#figure(
  caption: [],
  tab-scores)
