
# megatrees

<!-- badges: start -->
<!-- badges: end -->

The goal of `megatrees` is to provide a collection of subset of existing mega-phylogenies (mega-trees, hence the package name) for ecological studies. For common community ecology analyses, results derived from such phylogenies are robust (Li et al. 2019). This package will save us time to repeat the effort to download and randomly select a small subset of posterior phylogenies (for some taxonomic groups). Previous studies suggested that sampling 50-100 trees is sufficient to capture the uncertainty of phylogenetic spaces (Baiser et al. 2018; Li et al. 2019; Nakagawa et al. 2019). Therefore, for taxonomic groups with multiple posterior distribution of phylogenies, a randomly selected subset of 100 phylogenies were provided here, which can be relatively large in size (e.g., 45 Mb for the 100 phylogenies of 32k fishes). The larger than normal size made it hard to host this package on CRAN. 

## Installation

You can install the development version of megatrees like so (Note that it may take a while to install given its large data size (~115 Mb)):

``` r
if(!require("remotes")) install.packages("remotes")
remotes::install_github("daijiang/megatrees")
```

## List of phylogenies available

| Taxon                    | # of species | # of trees | R object                     | Reference            |
|--------------------------|--------------|------------|------------------------------|----------------------|
| Amphibian                | 7238         | 100        | `tree_amphibian_n100`        | Jetz and Pyron 2018  |
| Bee                      | 4651         | 1          | `tree_bee`                   | Henríquez-Piskulich et al. 2023 |
|                          | 4651         | 100        | `tree_bee_n100`              | Henríquez-Piskulich et al. 2023 |
| Butterfly                | 2244         | 1          | `tree_butterfly`             | Kawahara et al. 2023 |
| Bird                     | 9993         | 100        | `tree_bird_n100`             | Jetz et al. 2012     |
|                          | 11017        | 1          | `tree_bird_McTavish`         | McTavish et al. 2025     |
| Fish                     | 11638        | 1          | `tree_fish_12k`              | Rabosky et al. 2018  |
|                          | 31516        | 50         | `tree_fish_32k_n50`          | Rabosky et al. 2018  |
| Mammal                   | 5831         | 100        | `tree_mammal_n100_phylacine` | Faurby et al. 2018   |
|                          | 5911         | 100        | `tree_mammal_n100_vertlife`  | Upham et al. 2019    |
| Plant                    | 74531        | 1          | `tree_plant_otl`             | Smith and Brown 2018 |
| Reptile (Squamate)       | 9755         | 100        | `tree_reptile_n100`          | Tonini et al. 2016   |
| Shark, Ray, and Chimaera | 1192         | 100        | `tree_shark_ray_n100`        | Stein et al. 2018    |


## Contribution

Everyone is welcome to add new existing mega-trees here by sending a pull request. Or just open an issue to add links to the new mega-trees and I will add them here.


### References

Baiser, B., Valle, D., Zelazny, Z., & Burleigh, J. G. (2018). Non‐random patterns of invasion and extinction reduce phylogenetic diversity in island bird assemblages. Ecography, 41(2), 361-374.

Faurby, S., Davis, M., Pedersen, R. Ø., Schowanek, S. D., Antonelli, A., & Svenning, J. C. (2018). PHYLACINE 1.2: The phylogenetic atlas of mammal macroecology. Ecology, 99(11), 2626-2626.

Henríquez-Piskulich, P.; Hugall, A.F.; Stuart-Fox; D. (2023). A supermatrix phylogeny of the world’s bees (Hymenoptera: Anthophila). bioRxiv 2023.06.16.545281. doi.org/10.1101/2023.06.16.545281.

Jetz, W., & Pyron, R. A. (2018). The interplay of past diversification and evolutionary isolation with present imperilment across the amphibian tree of life. Nature ecology & evolution, 2(5), 850-858.

Jetz, W., Thomas, G. H., Joy, J. B., Hartmann, K., & Mooers, A. O. (2012). The global diversity of birds in space and time. Nature, 491(7424), 444.

Li, D., Monahan, W. B., & Baiser, B. (2018). Species richness and phylogenetic diversity of native and non‐native species respond differently to area and environmental factors. Diversity and Distributions, 24(6), 853-864.

Li, D., Trotta, L., Marx, H. E., Allen, J. M., Sun, M., Soltis, D. E., ... & Baiser, B. (2019). For common community phylogenetic analyses, go ahead and use synthesis phylogenies. Ecology, 100(9), e02788.

Nakagawa, S., & De Villemereuil, P. (2019). A general method for simultaneously accounting for phylogenetic and species sampling uncertainty via Rubin’s rules in comparative analysis. Systematic Biology, 68(4), 632-641.

Rabosky, D. L., Chang, J., Title, P. O., Cowman, P. F., Sallan, L., Friedman, M., ... & Alfaro, M. E. (2018). An inverse latitudinal gradient in speciation rate for marine fishes. Nature, 559(7714), 392.

Smith, S. A., & Brown, J. W. (2018). Constructing a broadly inclusive seed plant phylogeny. American Journal of Botany, 105(3), 302-314.

Stein, R. W., Mull, C. G., Kuhn, T. S., Aschliman, N. C., Davidson, L. N., Joy, J. B., ... & Mooers, A. O. (2018). Global priorities for conserving the evolutionary history of sharks, rays and chimaeras. Nature ecology & evolution, 2(2), 288-298.

Tonini, J. F. R., Beard, K. H., Ferreira, R. B., Jetz, W., & Pyron, R. A. (2016). Fully-sampled phylogenies of squamates reveal evolutionary patterns in threat status. Biological Conservation, 204, 23-31.

Upham, N. S., Esselstyn, J. A., & Jetz, W. (2019). Inferring the mammal tree: species-level sets of phylogenies for questions in ecology, evolution, and conservation. PLoS biology, 17(12), e3000494.

 
 
  



 
