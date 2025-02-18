testthat::test_that(
  desc = "grouped_ggscatterstats works",
  code = {
    testthat::skip_on_cran()

    # expect error if no grouping variable is specified
    testthat::expect_error(
      grouped_ggscatterstats(
        data = iris,
        x = Sepal.Length,
        y = Petal.Width
      )
    )

    # without any labelling
    set.seed(123)
    testthat::expect_true(inherits(
      ggstatsplot::grouped_ggscatterstats(
        data = iris,
        x = Sepal.Length,
        y = Petal.Width,
        grouping.var = Species,
        results.subtitle = FALSE,
        marginal = FALSE,
        messages = FALSE
      ),
      what = "gg"
    ))

    # create a smaller dataset
    set.seed(123)
    df <- dplyr::sample_frac(tbl = ggstatsplot::movies_long, size = 0.25) %>%
      dplyr::filter(
        .data = ., mpaa %in% c("R", "PG-13"),
        genre %in% c("Drama", "Comedy")
      )

    # both quoted
    set.seed(123)
    testthat::expect_true(inherits(
      ggstatsplot::grouped_ggscatterstats(
        data = df,
        x = length,
        y = rating,
        label.expression = "length > 150",
        label.var = "title",
        grouping.var = mpaa,
        type = "bf",
        results.subtitle = FALSE,
        marginal = FALSE,
        messages = FALSE
      ),
      what = "gg"
    ))

    # both unquoted
    set.seed(123)
    testthat::expect_true(inherits(
      ggstatsplot::grouped_ggscatterstats(
        data = df,
        x = length,
        y = rating,
        label.expression = budget > 150,
        label.var = title,
        grouping.var = mpaa,
        results.subtitle = FALSE,
        marginal = FALSE,
        messages = FALSE
      ),
      what = "gg"
    ))

    # one quoted, one unquoted
    set.seed(123)
    testthat::expect_true(inherits(
      ggstatsplot::grouped_ggscatterstats(
        data = df,
        x = length,
        y = rating,
        label.expression = budget > 150,
        label.var = "title",
        grouping.var = mpaa,
        type = "p",
        results.subtitle = FALSE,
        marginal = FALSE,
        messages = FALSE
      ),
      what = "gg"
    ))

    set.seed(123)
    testthat::expect_true(inherits(
      ggstatsplot::grouped_ggscatterstats(
        data = df,
        x = "length",
        y = "rating",
        grouping.var = "mpaa",
        type = "r",
        label.expression = "budget > 150",
        label.var = title,
        results.subtitle = FALSE,
        messages = FALSE,
        marginal = FALSE
      ),
      what = "gg"
    ))

    # without point labelling
    set.seed(123)
    testthat::expect_true(inherits(
      ggstatsplot::grouped_ggscatterstats(
        data = df,
        x = "length",
        y = rating,
        grouping.var = mpaa,
        label.expression = "length > 150",
        type = "np",
        results.subtitle = FALSE,
        messages = FALSE,
        marginal = FALSE
      ),
      what = "gg"
    ))

    # labeling all points (without expression, i.e.)
    set.seed(123)
    testthat::expect_true(inherits(
      ggstatsplot::grouped_ggscatterstats(
        data = dplyr::sample_frac(tbl = df, size = 0.1),
        x = "length",
        y = rating,
        grouping.var = mpaa,
        label.var = title,
        label.expression = NULL,
        type = "np",
        results.subtitle = FALSE,
        messages = FALSE,
        marginal = FALSE
      ),
      what = "gg"
    ))

    # checking if ggplot component addition works
    set.seed(123)
    testthat::expect_true(inherits(
      ggstatsplot::grouped_ggscatterstats(
        data = ggplot2::msleep,
        x = sleep_total,
        y = bodywt,
        marginal = FALSE,
        results.subtitle = FALSE,
        grouping.var = "vore",
        xlab = "total sleep",
        ylab = "body weight",
        title = "mammalian sleep dataset",
        caption = "source: ggplot2 package",
        type = "bf",
        ggplot.component = scale_y_continuous(breaks = seq(0, 6000, 1000)),
        messages = FALSE
      ),
      what = "gg"
    ))
  }
)

# subtitle output --------------------------------------------------

testthat::test_that(
  desc = "subtitle output",
  code = {
    testthat::skip_on_cran()

    # data
    df <- dplyr::filter(.data = ggstatsplot::movies_long, genre %in% c("Action Drama"))

    set.seed(123)
    ls_results <-
      ggstatsplot::grouped_ggscatterstats(
        data = df,
        x = rating,
        y = length,
        k = 3,
        conf.level = 0.99,
        grouping.var = genre,
        output = "subtitle",
        messages = FALSE
      )

    set.seed(123)
    basic_results <-
      statsExpressions::expr_corr_test(
        data = df,
        x = rating,
        y = length,
        k = 3,
        conf.level = 0.99,
        output = "subtitle",
        messages = FALSE
      )

    # tests
    testthat::expect_equal(length(ls_results), 1L)
    testthat::expect_identical(ls_results$`Action Drama`, basic_results)
  }
)
