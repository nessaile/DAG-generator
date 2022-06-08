# Sampling methods for Directed Acyclic Graphs (DAGs)

A directed acyclic graph, or DAG, over a set of nodes $\mathcal{X}=\\{1,\cdots,n\\}$ is a digraph over $\mathcal{X}$ with no cylces. This is, all of its edges are directed and no path forms a closed loop. DAGs are relevant in probabilistic modeling and causal inference, as they can economically encode the set of conditional independence statements among the random variables in a Bayesian network [^1]. In particular, DAGs can be used to facilitate quantitative predictions of the effect of external interventions on such networks [^2].

The number of different DAGs with $n$ labelled nodes, $a_n$, grows super-exponentially with $n$ [^3]. Its assymptotic behavior is:

$$ a_n \sim (1.741..)\cdot n!\cdot 2^{n(n-1)/2}\cdot (1.488..)^{-n} $$

This implies that, enumerating all DAGs might be impractical, even unfeasible, for relative small number of nodes. 

- For $n=11$, $a_n\approx 10^{7.7} > 10^{7.5} =$ the number of seconds in a year
- For $n=21$, $a_n\approx 10^{19} > 10^{18.9} =$ computational limit of a 64-bit CPU
- For $n=31$, $a_n\approx 10^{31} > 10^{30.6} =$ the number of bacterial cells on Earth [^4]

The sequence $\\{a_n\\}$ is registered in the _On-Line Encyclopedia of Integer Sequences_ as [A003024](https://oeis.org/A003024).

[^1]: Koller, D., Friedman, N. (2009). [_Probabilistic Graphical Models: Principles and Techniques_](https://mitpress.mit.edu/books/probabilistic-graphical-models). MIT Press. ISBN: 9780262013192
[^2]: Pearl, J. (1993). [_Aspects Of Graphical Models Connected With Causality_](https://escholarship.org/content/qt9zx0h8k6/qt9zx0h8k6.pdf). In Proceedings of the 49th Session of the International Statistical Institute.
[^3]: McKay, B., Royle, G., Wanless, I., Oggier, F., Sloane, N., Wilf, H. (2004), [_Acyclic digraphs and eigenvalues of (0,1)-matrices_](https://cs.uwaterloo.ca/journals/JIS/VOL7/Sloane/sloane15.html), Journal of Integer Sequences, 7: 33, 
[^4]:  Flemming, H., Wuertz, S. (2019). [_Bacteria and archaea on Earth and their abundance in biofilms_](https://www.nature.com/articles/s41579-019-0158-9). Nature Reviews. Microbiology. 17 (4): 247–260. doi:10.1038/s41579-019-0158-9. PMID 30760902. S2CID 61155774
