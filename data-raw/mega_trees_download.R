library(tidyverse)
library(ape)

# plant Smith & Brown 2018 ----
load(rawConnection(RCurl::getBinaryURL("https://raw.githubusercontent.com/jinyizju/V.PhyloMaker/master/data/GBOTB.extended.rda")))

## takes a while, commented out
# tree_plant_otl = rtrees::add_root_info(tree = GBOTB.extended, classification = dplyr::filter(rtrees::classifications, taxon == "plant"))
# usethis::use_data(tree_plant_otl, overwrite = T, compress = "xz")
# tools::checkRdaFiles("data/tree_plant_otl.rda")

# fish tree of life ----
# time tree
fishurl = "https://fishtreeoflife.org/downloads/actinopt_12k_treePL.tre.xz"
tempf = tempfile()
download.file(fishurl, tempf)
fish_tree_12k = ape::read.tree(tempf) # 11638 species, no node labels
unlink(tempf)
fish_tree_12k$node.label = paste0("N", 1:Nnode(fish_tree_12k))

ggtree::ggtree(fish_tree_12k, layout = "circular")
# find roots for fish tree
tree_fish_12k = rtrees::add_root_info(fish_tree_12k, dplyr::filter(rtrees::classifications, taxon == "fish"))
usethis::use_data(tree_fish_12k, overwrite = T, compress = "xz")

# fish full tree with missing species inserted as death-birth process ----
fishurl2 = "https://fishtreeoflife.org/downloads/actinopt_full.trees.xz"
tempf = tempfile()
download.file(fishurl2, tempf)
tree_fish_32k_n100 = ape::read.tree(tempf)
unlink(tempf)
str(tree_fish_32k_n100) # 100 phylogenies
tree_fish_32k_n100[[1]] # 31516 species each
Nnode(tree_fish_32k_n100[[1]])
Nnode(tree_fish_32k_n100[[2]])
ggtree::ggtree(tree_fish_32k_n100[[1]], layout = "circular")
# unlink(tempf)
setdiff(unique(str_extract(tree_fish_32k_n100[[1]]$tip.label, "^[^_]+")),
        dplyr::filter(rtrees::classifications, taxon == "fish")$genus)
# take a while
tree_fish_32k_n100 = parallel::mclapply(tree_fish_32k_n100, function(x){
  rtrees::add_root_info(x, dplyr::filter(rtrees::classifications, taxon == "fish"))
}, mc.cores = 50)
tree_fish_32k_n100[[2]]$genus_family_root
class(tree_fish_32k_n100) = c(class(tree_fish_32k_n100), "multiPhylo")

# too large to host megatrees online, reduce to 50 trees?
set.seed(123)
n_keep = sample(x = 1:length(tree_fish_32k_n100), size = 50, replace = FALSE)
tree_fish_32k_n50 = tree_fish_32k_n100[n_keep]
# usethis::use_data(tree_fish_32k_n100, overwrite = T, compress = "xz")
usethis::use_data(tree_fish_32k_n50, overwrite = T, compress = "xz")


# birds vertlife ----
dir.create("bird_trees")
for(i in paste0("https://data.vertlife.org/birdtree/Stage2/",
                c("EricsonStage2_0001_1000.zip", "EricsonStage2_1001_2000.zip",
                  "EricsonStage2_2001_3000.zip", "EricsonStage2_3001_4000.zip",
                  "EricsonStage2_4001_5000.zip", "EricsonStage2_5001_6000.zip",
                  "EricsonStage2_6001_7000.zip", "EricsonStage2_7001_8000.zip",
                  "EricsonStage2_8001_9000.zip", "EricsonStage2_9001_10000.zip",
                  "HackettStage2_0001_1000.zip",  "HackettStage2_1001_2000.zip",
                  "HackettStage2_2001_3000.zip", "HackettStage2_3001_4000.zip",
                  "HackettStage2_4001_5000.zip", "HackettStage2_5001_6000.zip",
                  "HackettStage2_6001_7000.zip", "HackettStage2_7001_8000.zip",
                  "HackettStage2_8001_9000.zip", "HackettStage2_9001_10000.zip"))){
  xfun::download_file(i, output = paste0("bird_trees/", xfun::url_filename(i)))
}

bird_tree_files = list.files("bird_trees", full.names = T)
bird_subtrees = vector("list", length =  length(bird_tree_files))
names(bird_subtrees) = basename(bird_tree_files)
# unzip, and then extract 5 random trees from each zip file
# 50 total random trees from each backbone
for(i in 1:length(bird_tree_files)){
  x = bird_tree_files[i]
  unzip(x, file = unzip(x, list = T)$Name[1], exdir = "trees", junkpaths = T)
  tree = ape::read.tree(paste0("trees/", basename(unzip(x, list = T)$Name[1])))
  set.seed(i)
  bird_subtrees[[i]] = tree[sample(length(tree), 5)]
  cat("i = ", i, " done \n")
}

tree_bird_n100 = unlist(bird_subtrees, recursive = FALSE)
rm(bird_subtrees)

tree_bird_n100 = parallel::mclapply(tree_bird_100, function(x){
  rtrees::add_root_info(x, dplyr::filter(rtrees::classifications, taxon == "bird"))
}, mc.cores = 50)
class(tree_bird_n100) = c(class(tree_bird_n100), "multiPhylo")
# remove the trees
system("rm -R bird_trees")

usethis::use_data(tree_bird_n100, overwrite = T, compress = "xz")

# mammal vertlife ----
xfun::download_file("https://data.vertlife.org/mammaltree/Completed_5911sp_topoCons_FBDasZhouEtAl.zip",
                    output = "mammal_Completed_5911sp_topoCons_FBDasZhouEtAl.zip")
xfun::download_file("https://data.vertlife.org/mammaltree/Completed_5911sp_topoCons_NDexp.zip",
                    output = "Completed_5911sp_topoCons_NDexp.zip")

x = "mammal_Completed_5911sp_topoCons_NDexp.zip"
# randomly select 50 trees with Node Dating Exponential backbones
set.seed(2022)
unzip(x, file = sample(unzip(x, list = T)$Name[-1], 50), exdir = "trees/mammal", junkpaths = T)
file.remove(x)
# randomly select 50 trees with Fossil Birth Death Zhou et al. backbones
x = "vertlife_trees/mammal_Completed_5911sp_topoCons_FBDasZhouEtAl.zip"
set.seed(202208)
unzip(x, file = sample(unzip(x, list = T)$Name[-1], 50), exdir = "trees/mammal", junkpaths = T)
file.remove(x)
list.files("trees/mammal/")

tree_mammal_n100_vertlife = vector("list", length = 100)
names(tree_mammal_n100_vertlife) = list.files("trees/mammal/")
for(i in seq_along(tt <- list.files("trees/mammal/", full.names = T))){
  tree_mammal_n100_vertlife[[i]] = ape::read.tree(tt[i])
}

grep("X_", tree_mammal_n100_vertlife[[1]]$tip.label, value = T) # fossil
tree_mammal_n100_vertlife = lapply(tree_mammal_n100_vertlife, function(x){
  ape::drop.tip(x, grep("X_", tree_mammal_n100_vertlife[[1]]$tip.label, value = T))
})

tree_mammal_n100_vertlife = parallel::mclapply(tree_mammal_n100_vertlife, function(x){
  rtrees::add_root_info(x, dplyr::filter(rtrees::classifications, taxon == "mammal"))
}, mc.cores = 50)

class(tree_mammal_n100_vertlife) = c(class(tree_mammal_n100_vertlife), "multiPhylo")

system("rm -R trees/mammal")

usethis::use_data(tree_mammal_n100_vertlife, overwrite = T, compress = "xz")

# mammal PHYLACINE_1.2 ----
m_url = "https://media.githubusercontent.com/media/MegaPast2Future/PHYLACINE_1.2/master/Data/Phylogenies/Complete_phylogeny.nex"
# read mammal tree, 1000 trees
tree_mammal = ape::read.nexus(m_url)
class(tree_mammal)

set.seed(123)
nnw = sample(1:1000, 100) # 288
tree_mammal_n100_phylacine = tree_mammal[nnw]
tree_mammal_n100_phylacine = lapply(tree_mammal_n100_phylacine, rtrees::add_root_info,
                               classification = dplyr::filter(rtrees::classifications, taxon == "mammal"))
names(tree_mammal_n100_phylacine) = paste0("tree_", nnw)
class(tree_mammal_n100_phylacine) = c(class(tree_mammal_n100_phylacine), "multiPhylo")
usethis::use_data(tree_mammal_n100_phylacine, overwrite = T, compress = "xz")

# amphibian vertlife ----
xfun::download_file("https://data.vertlife.org/amphibiantree/download/amph_shl_new_Posterior_7238.1000-10000.trees.zip")
x = "amph_shl_new_Posterior_7238.1000-10000.trees.zip"

unzip(x, list = T)$Name[-c(2:3)] # .MacOS stuff
unzip(x, file = unzip(x, list = T)$Name[-c(2:3)], exdir = "trees/amphibian", junkpaths = T)

amph_tree_files = list.files("trees/amphibian", full.names = T)

tree_amphibian_n100 = vector("list", length =  length(amph_tree_files))
names(tree_amphibian_n100) = basename(amph_tree_files)

for(i in 1:length(amph_tree_files)){
  x = amph_tree_files[i]
  tree = ape::read.tree(x)
  if(grepl("Consensus", amph_tree_files[i])){
    tree_amphibian_n100[[i]]  = tree
  } else {
    set.seed(i)
    tree_amphibian_n100[[i]] = tree[sample(1:length(tree), 10)]
  }
  cat("i = ", i, " done \n")
}

tree_amphibian_n100 = unlist(tree_amphibian_n100, recursive = FALSE)
tree_amphibian_n100 = tree_amphibian_n100[-101]

tree_amphibian_n100 = lapply(tree_amphibian_n100, function(x){
  ape::drop.tip(x, "Homo_sapiens") # outgroup
})

all(unique(stringr::str_extract(tree_amphibian_n100[[1]]$tip.label, "^[^_]+")) %in%
  dplyr::filter(rtrees::classifications, taxon == "amphibian")$genus)

tree_amphibian_n100 = parallel::mclapply(tree_amphibian_n100, function(x){
  rtrees::add_root_info(x, dplyr::filter(rtrees::classifications, taxon == "amphibian"))
}, mc.cores = 50)
class(tree_amphibian_n100) = c(class(tree_amphibian_n100), "multiPhylo")
tree_amphibian_n100[[1]]$genus_family_root

usethis::use_data(tree_amphibian_n100, overwrite = T, compress = "xz")

system("rm -R trees/amphibian")

# scaled reptile (squamate) vertlife ----
xfun::download_file("https://data.vertlife.org/squamatetree/squam_shl_new_Posterior_9755.1000-10000.trees.zip")
x = "squam_shl_new_Posterior_9755.1000-10000.trees.zip"
unzip(x, list = T)
unzip(x, file = unzip(x, list = T)$Name, exdir = "trees/reptile", junkpaths = T)
file.remove(x)

rept_tree_files = list.files("trees/reptile", full.names = T)

tree_reptile_n100 = vector("list", length =  length(rept_tree_files))
names(tree_reptile_n100) = basename(rept_tree_files)

for(i in 1:length(rept_tree_files)){
  x = rept_tree_files[i]
  tree = ape::read.tree(x)
  # randomly select 10 trees from each 1000 posterior trees
  set.seed(i)
  tree_reptile_n100[[i]] = tree[sample(length(tree), 10)]
  cat("i = ", i, " done \n")
}

tree_reptile_n100 = unlist(tree_reptile_n100, recursive = FALSE)

tree_reptile_n100 = parallel::mclapply(tree_reptile_n100, function(x){
  rtrees::add_root_info(x, dplyr::filter(rtrees::classifications, taxon == "reptile"))
}, mc.cores = 50)
class(tree_reptile_n100) = c(class(tree_reptile_n100), "multiPhylo")
tree_reptile_n100[[1]]$genus_family_root

usethis::use_data(tree_reptile_n100, overwrite = T, compress = "xz")

system("rm -R trees/reptile")

# shark & ray vertlife ----
xfun::download_file("https://data.vertlife.org/sharktree/10.cal.tree.nex", output = "shark_10.cal.tree.nex")
tree_shark_ray_n100 = ape::read.nexus("shark_10.cal.tree.nex")
set.seed(2022)
tree_shark_ray_n100 = tree_shark_ray_n100[sample(1:length(tree_shark_ray_n100), 100)]
tree_shark_ray_n100 = parallel::mclapply(tree_shark_ray_n100, function(x){
  rtrees::add_root_info(x, dplyr::filter(rtrees::classifications, taxon == "shark_ray"))
}, mc.cores = 50)
class(tree_shark_ray_n100) = c(class(tree_shark_ray_n100), "multiPhylo")
tree_shark_ray_n100[[1]]$genus_family_root

usethis::use_data(tree_shark_ray_n100, overwrite = T, compress = "xz")
file.remove("shark_10.cal.tree.nex")


# butterfly ----
# https://www.nature.com/articles/s41559-023-02041-9#MOESM1
# download its supplementary data
# https://springernature.figshare.com/articles/dataset/A_global_phylogeny_of_butterflies_reveals_their_evolutionary_history_ancestral_host_plants_and_biogeographic_origins/21774899?file=39124943

x = read.nexus("~/Downloads/Data.S24.RevBayes_Papilionoidea_BDS_rates_MAP2.tre")
x
plot(x, show.tip.label = F)
x$tip.label[1:100]

x_= str_count(x$tip.label, "_")
table(x_)
x$tip.label[which(x_ == 9)]
x$tip.label[which(x_ == 8)]
xx = x$tip.label[which(x_ == 7)]

x$tip.label = str_replace(x$tip.label, "__", "_")
x$tip.label = str_replace(x$tip.label, "_mulinzii_mulinzii", "_mulinzii")
x$tip.label = str_remove_all(x$tip.label, "'")
x$tip.label = str_remove_all(x$tip.label, "[.]$")
x$tip.label = str_remove(x$tip.label, "_X_ME$|_ME$")

xx = tibble(xx = x$tip.label) |>
  separate(xx, c("x1", "x2", "family", "subfamily", "tribe", "genus", "species", "subspecies"),
           remove = F)

drop_na(xx, subspecies) # |> View()

xx = mutate(xx,
            species = ifelse(species == "c", paste(species, subspecies, sep = "-"), species),
            sp = paste(genus, species, sep = "_"))
n_distinct(xx$sp)
spd = xx$sp[which(duplicated(xx$sp))]
filter(xx, sp %in% spd) # |> View()
# remove some of the duplicated tips
spd2 = filter(xx, sp %in% spd)
tip_to_rm = group_by(spd2, sp) |>
  slice_head(n = 1) |>
  pull(xx)
x = drop.tip(x, tip_to_rm)

x$tip.label = left_join(tibble(xx = x$tip.label), xx, by = "xx")$sp
any(duplicated(x$tip.label))
plot(x, show.tip.label = F, type = "fan")

classification_butterfly = dplyr::select(xx, genus, family) |>
  distinct()

x2 = rtrees::add_root_info(x, classification = classification_butterfly)
x2$genus_family_root
tree_butterfly = x2

usethis::use_data(tree_butterfly, overwrite = T, compress = "xz")

# bees -----
"http://beetreeoflife.org/downloads/files/BEE_IQTufbs_mat6b_tplo_1001bin.zip"
"http://beetreeoflife.org/downloads/files/BEE_taxonomic_database.xlsx"

bees = read.tree("~/Downloads/BEE_IQTufbs_mat6b_tplo_1001bin.nwk")
plot(bees[[1]], type = "fan", show.tip.label = F)
tree_bee = bees[[1]]

bees_class = filter(rtrees::classifications, taxon == "bee")

all(unique(str_extract(tree_bee$tip.label, "^[^_]*")) %in% bees_class$genus)

tree_bee = rtrees::add_root_info(tree_bee, bees_class)
usethis::use_data(tree_bee, overwrite = T, compress = "xz")

set.seed(2022)
tree_bee_n100 = bees[sample(2:length(bees), 100)]
tree_bee_n100 = parallel::mclapply(tree_bee_n100, function(x){
  rtrees::add_root_info(x, bees_class)
}, mc.cores = 10)
class(tree_bee_n100) = c(class(tree_bee_n100), "multiPhylo")
tree_bee_n100[[1]]$genus_family_root

usethis::use_data(tree_bee_n100, overwrite = T, compress = "xz")

