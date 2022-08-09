
test_that("All objects with more than one phylogeny should have a class of multiPhylo", {
  expect_true("multiPhylo" %in% class(tree_amphibian_n100))
  expect_true("multiPhylo" %in% class(tree_bird_n100))
  expect_true("multiPhylo" %in% class(tree_fish_32k_n100))
  expect_true("multiPhylo" %in% class(tree_mammal_n100_phylacine))
  expect_true("multiPhylo" %in% class(tree_mammal_n100_vertlife))
  expect_true("multiPhylo" %in% class(tree_reptile_n100))
  expect_true("multiPhylo" %in% class(tree_shark_ray_n100))
})

get_genus = function(x){
  unique(stringr::str_extract(x, "^[^_]+"))
}

test_that("All genus in classification?", {
  expect_true(all(get_genus(tree_amphibian_n100[[sample(1:100, 1)]]$tip.label) %in%
    dplyr::filter(rtrees::classifications, taxon == "amphibian")$genus))

  expect_true(all(get_genus(tree_amphibian_n100[[sample(1:100, 1)]]$tip.label) %in%
                    dplyr::filter(rtrees::classifications, taxon == "amphibian")$genus))

  expect_true(all(get_genus(tree_amphibian_n100[[sample(1:100, 1)]]$tip.label) %in%
                    dplyr::filter(rtrees::classifications, taxon == "amphibian")$genus))

  expect_true(all(get_genus(tree_bird_n100[[sample(1:100, 1)]]$tip.label) %in%
                    dplyr::filter(rtrees::classifications, taxon == "bird")$genus))

  expect_true(all(get_genus(tree_fish_32k_n100[[sample(1:100, 1)]]$tip.label) %in%
                    dplyr::filter(rtrees::classifications, taxon == "fish")$genus))

  expect_true(all(get_genus(tree_mammal_n100_phylacine[[sample(1:100, 1)]]$tip.label) %in%
                    dplyr::filter(rtrees::classifications, taxon == "mammal")$genus))

  expect_true(all(get_genus(tree_mammal_n100_vertlife[[sample(1:100, 1)]]$tip.label) %in%
                    dplyr::filter(rtrees::classifications, taxon == "mammal")$genus))

  expect_true(all(get_genus(tree_plant_otl$tip.label) %in%
                    dplyr::filter(rtrees::classifications, taxon == "plant")$genus))

  expect_true(all(get_genus(tree_reptile_n100[[sample(1:100, 1)]]$tip.label) %in%
                    dplyr::filter(rtrees::classifications, taxon == "reptile")$genus))

  expect_true(all(get_genus(tree_shark_ray_n100[[sample(1:100, 1)]]$tip.label) %in%
                    dplyr::filter(rtrees::classifications, taxon == "shark_ray")$genus))
})


test_that("Each phylogeny should have node information added", {
  expect_true("genus_family_root" %in% names(tree_amphibian_n100[[sample(1:100, 1)]]))
  expect_true("genus_family_root" %in% names(tree_bird_n100[[sample(1:100, 1)]]))
  expect_true("genus_family_root" %in% names(tree_fish_12k))
  expect_true("genus_family_root" %in% names(tree_fish_32k_n100[[sample(1:100, 1)]]))
  expect_true("genus_family_root" %in% names(tree_mammal_n100_phylacine[[sample(1:100, 1)]]))
  expect_true("genus_family_root" %in% names(tree_mammal_n100_vertlife[[sample(1:100, 1)]]))
  expect_true("genus_family_root" %in% names(tree_plant_otl))
  expect_true("genus_family_root" %in% names(tree_reptile_n100[[sample(1:100, 1)]]))
  expect_true("genus_family_root" %in% names(tree_shark_ray_n100[[sample(1:100, 1)]]))
})



