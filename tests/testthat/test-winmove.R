context("winmove")

test_that("shei calculation is correct", {
  d <- winmove(cat_ls, 5, "rectangle", shei, lc_class = 1:4)
  expect_equal(d, wm_shei_dat)
})

test_that("mean calculation is correct", {
  d <- winmove(cont_ls, 2, "rectangle", mean)
  expect_equal(d, wm_mean_dat)
})

test_that("user defined function works", {
  user_fn <- function(x, lc_class, ...) {
    return(sum(x == lc_class))
  }
  d <- winmove(cat_ls, 4, "rectangle", user_fn, lc_class = 2)
  expect_equal(d, wm_user_dat)
})

test_that("prop calculation is correct when lc given does not exist", {
  d <- winmove(fine_dat = cat_ls, 
                   d = 5, 
                   type = "rectangle", 
                   win_fun = prop,
                   lc_class = 10)
  expect_true(all(na.omit(raster::values(d)) == 0))
})

test_that("output is raster of same resolution as input", {
  d <- winmove(cont_ls, 5, "rectangle", mean)
  expect_is(d, "RasterLayer")
  expect_true(raster::ncell(d) == raster::ncell(cont_ls))
})
