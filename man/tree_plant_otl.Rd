% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{tree_plant_otl}
\alias{tree_plant_otl}
\title{Mega-tree of Plants based on Open Tree of Life}
\format{
A phylogeny with class "phylo". It is also a list. Compare with a normal phylo object, it has another data frame `tree_plant_otl$genus_family_root`, which provides the root nodes information for every unique genus and family in the phylogeny. Such information can be used to insert new tips onto the phylogeny later.
}
\source{
https://github.com/jinyizju/V.PhyloMaker/tree/master/data
}
\usage{
tree_plant_otl
}
\description{
This tree was based on Smith and Brown (2018), which in turn was based on the Open Tree of Life.
It was copied from `V.PhyloMaker::GBOTB.extended`. After then, node labels were added for empty ones.
}
\references{
Smith, S. A., & Brown, J. W. (2018). Constructing a broadly inclusive seed plant phylogeny. American Journal of Botany, 105(3), 302-314.

Jin, Y., & Qian, H. (2019). V. PhyloMaker: an R package that can generate very large phylogenies for vascular plants. Ecography.
}
\keyword{datasets}
