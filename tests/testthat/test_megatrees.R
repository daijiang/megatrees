
skip_on_cran()

# Download (or load from cache) all large multi-tree datasets once for the
# entire test file to avoid redundant network calls across test blocks.
amp   <- get_tree_amphibian_n100()
bee   <- get_tree_bee_n100()
bird  <- get_tree_bird_n100()
fish  <- get_tree_fish_32k_n50()
mam_p <- get_tree_mammal_n100_phylacine()
mam_v <- get_tree_mammal_n100_vertlife()
plant <- get_tree_plant_n100_Carruthers()
rept  <- get_tree_reptile_n100()
shark <- get_tree_shark_ray_n100()

test_that("All objects with more than one phylogeny should have a class of multiPhylo", {
  expect_true("multiPhylo" %in% class(amp))
  expect_true("multiPhylo" %in% class(bee))
  expect_true("multiPhylo" %in% class(bird))
  expect_true("multiPhylo" %in% class(fish))
  expect_true("multiPhylo" %in% class(mam_p))
  expect_true("multiPhylo" %in% class(mam_v))
  expect_true("multiPhylo" %in% class(plant))
  expect_true("multiPhylo" %in% class(rept))
  expect_true("multiPhylo" %in% class(shark))
})

get_genus <- function(x) {
  unique(stringr::str_extract(x, "^[^_]+"))
}

test_that("All genus in classification?", {
  expect_true(all(get_genus(amp[[sample(1:100, 1)]]$tip.label) %in%
    dplyr::filter(rtrees::classifications, taxon == "amphibian")$genus))

  expect_true(all(get_genus(amp[[sample(1:100, 1)]]$tip.label) %in%
    dplyr::filter(rtrees::classifications, taxon == "amphibian")$genus))

  expect_true(all(get_genus(amp[[sample(1:100, 1)]]$tip.label) %in%
    dplyr::filter(rtrees::classifications, taxon == "amphibian")$genus))

  expect_true(all(get_genus(bird[[sample(1:100, 1)]]$tip.label) %in%
    dplyr::filter(rtrees::classifications, taxon == "bird")$genus))

  expect_true(all(get_genus(tree_bird_McTavish$tip.label) %in%
    dplyr::filter(rtrees::classifications, taxon == "bird")$genus))

  expect_true(all(get_genus(fish[[sample(1:50, 1)]]$tip.label) %in%
    dplyr::filter(rtrees::classifications, taxon == "fish")$genus))

  expect_true(all(get_genus(mam_p[[sample(1:100, 1)]]$tip.label) %in%
    dplyr::filter(rtrees::classifications, taxon == "mammal")$genus))

  expect_true(all(get_genus(mam_v[[sample(1:100, 1)]]$tip.label) %in%
    dplyr::filter(rtrees::classifications, taxon == "mammal")$genus))

  expect_true(all(get_genus(tree_plant_otl$tip.label) %in%
    dplyr::filter(rtrees::classifications, taxon == "plant")$genus))

  expect_true(all(get_genus(rept[[sample(1:100, 1)]]$tip.label) %in%
    dplyr::filter(rtrees::classifications, taxon == "reptile")$genus))

  expect_true(all(get_genus(shark[[sample(1:100, 1)]]$tip.label) %in%
    dplyr::filter(rtrees::classifications, taxon == "shark_ray")$genus))
})


test_that("Each phylogeny should have node information added", {
  expect_true("genus_family_root" %in% names(amp[[sample(1:100, 1)]]))
  expect_true("genus_family_root" %in% names(bee[[sample(1:100, 1)]]))
  expect_true("genus_family_root" %in% names(bird[[sample(1:100, 1)]]))
  expect_true("genus_family_root" %in% names(tree_fish_12k))
  expect_true("genus_family_root" %in% names(fish[[sample(1:50, 1)]]))
  expect_true("genus_family_root" %in% names(mam_p[[sample(1:100, 1)]]))
  expect_true("genus_family_root" %in% names(mam_v[[sample(1:100, 1)]]))
  expect_true("genus_family_root" %in% names(tree_plant_otl))
  expect_true("genus_family_root" %in% names(plant[[sample(1:100, 1)]]))
  expect_true("genus_family_root" %in% names(rept[[sample(1:100, 1)]]))
  expect_true("genus_family_root" %in% names(shark[[sample(1:100, 1)]]))
})
