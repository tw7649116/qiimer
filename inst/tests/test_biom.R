# Example metadata for BIOM object
b_otu_ids <- c("denovo0", "denovo1", "denovo2", "denovo3", "denovo5")
b_sample_ids <- c("A.1", "A.2", "B.1", "B.2", "C.1")
b_taxonomy <- list(
  "Bacteria", 
  "Bacteria", 
  c("Bacteria", "Firmicutes"), 
  c("Bacteria", "Firmicutes", "Bacilli", "Lactobacillales", 
    "Leuconostocaceae", "Weissella"), 
  c("Bacteria", "Firmicutes", "Clostridia", "Clostridiales", 
    "Peptococcaceae"))

# Prototype BIOM object without data
b <- list(type = "OTU table", shape=c(5, 5))
b$rows <- mapply(
  function (x, y) list(id=x, metadata=list(taxonomy=y)),
  b_otu_ids, b_taxonomy, SIMPLIFY=FALSE, USE.NAMES=FALSE)
b$columns <- lapply(b_sample_ids, function (x) list(id=x, metadata=NULL))

# BIOM object in sparse format
b$matrix_type <- "sparse"
b$data <- list(
  c(0, 0, 5), c(0, 1, 10), c(0, 2, 2), c(0, 4, 3),
  c(1, 0, 76), c(1, 1, 23), c(1, 2, 28), c(1, 3, 43), c(1, 4, 56),
  c(2, 0, 2), c(2, 1, 1),
  c(3, 0, 637), c(3, 1, 61), c(3, 2, 63), c(3, 3, 77), c(3, 4, 34),
  c(4, 3, 1))

context('biom_taxonomy')

test_that("Taxonomy is correct", {
  expect_equal(biom_taxonomy(b)[[1]], "Bacteria")
})

test_that("Taxonomy list is labeled with OTU IDs", {
  expect_equal(biom_taxonomy(b)[["denovo2"]], c("Bacteria", "Firmicutes"))
})
