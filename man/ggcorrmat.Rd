% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ggcorrmat.R
\name{ggcorrmat}
\alias{ggcorrmat}
\title{Visualization of a correlation matrix}
\usage{
ggcorrmat(
  data,
  cor.vars = NULL,
  cor.vars.names = NULL,
  output = "plot",
  matrix.type = "full",
  method = "square",
  type = "parametric",
  beta = 0.1,
  k = 2,
  sig.level = 0.05,
  conf.level = 0.95,
  bf.prior = 0.707,
  p.adjust.method = "none",
  pch = 4,
  ggcorrplot.args = list(outline.color = "black"),
  package = "RColorBrewer",
  palette = "Dark2",
  direction = 1,
  colors = c("#E69F00", "white", "#009E73"),
  ggtheme = ggplot2::theme_bw(),
  ggstatsplot.layer = TRUE,
  title = NULL,
  subtitle = NULL,
  caption = NULL,
  messages = TRUE,
  ...
)
}
\arguments{
\item{data}{Dataframe from which variables specified are preferentially to be
taken.}

\item{cor.vars}{List of variables for which the correlation matrix is to be
computed and visualized. If \code{NULL} (default), all numeric variables from
\code{data} will be used.}

\item{cor.vars.names}{Optional list of names to be used for \code{cor.vars}. The
names should be entered in the same order.}

\item{output}{Character that decides expected output from this function. If
\code{"plot"}, the visualization matrix will be returned. If \code{"dataframe"} (or
literally anything other than \code{"plot"}), a dataframe containing all details
from statistical analyses (e.g., correlation coefficients, statistic
values, \emph{p}-values, no. of observations, etc.) will be returned.}

\item{matrix.type}{Character, \code{"full"} (default), \code{"upper"} or \code{"lower"},
display full matrix, lower triangular or upper triangular matrix.}

\item{method}{Smoothing method (function) to use, accepts either
\code{NULL} or a character vector, e.g. \code{"lm"}, \code{"glm"}, \code{"gam"}, \code{"loess"}
or a function, e.g. \code{MASS::rlm} or \code{mgcv::gam}, \code{stats::lm}, or \code{stats::loess}.
\code{"auto"} is also accepted for backwards compatibility.  It is equivalent to
\code{NULL}.

For \code{method = NULL} the smoothing method is chosen based on the
size of the largest group (across all panels). \code{\link[stats:loess]{stats::loess()}} is
used for less than 1,000 observations; otherwise \code{\link[mgcv:gam]{mgcv::gam()}} is
used with \code{formula = y ~ s(x, bs = "cs")} with \code{method = "REML"}. Somewhat anecdotally,
\code{loess} gives a better appearance, but is \eqn{O(N^{2})}{O(N^2)} in memory,
so does not work for larger datasets.

If you have fewer than 1,000 observations but want to use the same \code{gam()}
model that \code{method = NULL} would use, then set
\verb{method = "gam", formula = y ~ s(x, bs = "cs")}.}

\item{type}{A character string indicating which correlation coefficient is to
be computed: \code{"pearson"} (Pearson's \emph{r}), \code{"spearman"} (Spearman's \emph{rho}),
\code{"robust"} (percentage bend correlation (see \code{?WRS2::pball})) or \code{"bayes"},
which would compute Bayes Factor for Pearson's \emph{r}.
Abbreviations will also work: \code{"p"} (for parametric), \code{"np"}
(nonparametric), \code{"r"} (robust), \code{"bf"} (Bayes Factor).}

\item{beta}{A numeric bending constant for percentage bend robust correlation
coefficient (Default: \code{0.1}).}

\item{k}{Number of digits after decimal point (should be an integer)
(Default: \code{k = 2}).}

\item{sig.level}{Significance level (Default: \code{0.05}). If the \emph{p}-value in
\emph{p}-value matrix is bigger than \code{sig.level}, then the corresponding
correlation coefficient is regarded as insignificant and flagged as such in
the plot. Relevant only when \code{output = "plot"}.}

\item{conf.level}{Scalar between 0 and 1. If unspecified, the defaults return
\verb{95\%} lower and upper confidence intervals (\code{0.95}).}

\item{bf.prior}{A number between \code{0.5} and \code{2} (default \code{0.707}), the prior
width to use in calculating Bayes factors.}

\item{p.adjust.method}{What adjustment for multiple tests should be used?
(\code{"holm"}, \code{"hochberg"}, \code{"hommel"}, \code{"bonferroni"}, \code{"BH"}, \code{"BY"},
\code{"fdr"}, \code{"none"}). See \code{stats::p.adjust} for details about why to use
\code{"holm"} rather than \code{"bonferroni"}). Default is \code{"none"}. If adjusted
\emph{p}-values are displayed in the visualization of correlation matrix, the
\strong{adjusted} \emph{p}-values will be used for the \strong{upper} triangle, while
\strong{unadjusted} \emph{p}-values will be used for the \strong{lower} triangle of the
matrix.}

\item{pch}{Decides the glyphs (read point shapes) to be used for
insignificant correlation coefficients (only valid when \code{insig = "pch"}).
Default value is \code{pch = 4}.}

\item{ggcorrplot.args}{A list of additional (mostly aesthetic) arguments that
will be passed to \code{ggcorrplot::ggcorrplot} function. The list should avoid
any of the following arguments since they are already internally being used
by \code{ggstatsplot}: \code{corr}, \code{method}, \code{p.mat}, \code{sig.level}, \code{ggtheme},
\code{colors}, \code{matrix.type}, \code{lab}, \code{pch}, \code{legend.title}, \code{digits}.}

\item{package}{Name of package from which the palette is desired as string
or symbol.}

\item{palette}{Name of palette as string or symbol.}

\item{direction}{Either \code{1} or \code{-1}. If \code{-1} the palette will be reversed.}

\item{colors}{A vector of 3 colors for low, mid, and high correlation values.
If set to \code{NULL}, manual specification of colors will be turned off and 3
colors from the specified \code{palette} from \code{package} will be selected.}

\item{ggtheme}{A function, \code{ggplot2} theme name. Default value is
\code{ggplot2::theme_bw()}. Any of the \code{ggplot2} themes, or themes from
extension packages are allowed (e.g., \code{ggthemes::theme_fivethirtyeight()},
\code{hrbrthemes::theme_ipsum_ps()}, etc.).}

\item{ggstatsplot.layer}{Logical that decides whether \code{theme_ggstatsplot}
theme elements are to be displayed along with the selected \code{ggtheme}
(Default: \code{TRUE}). \code{theme_ggstatsplot} is an opinionated theme layer that
override some aspects of the selected \code{ggtheme}.}

\item{title}{The text for the plot title.}

\item{subtitle}{The text for the plot subtitle. Will work only if
\code{results.subtitle = FALSE}.}

\item{caption}{The text for the plot caption. If \code{NULL}, a default caption
will be shown.}

\item{messages}{Decides whether messages references, notes, and warnings are
to be displayed (Default: \code{TRUE}).}

\item{...}{Currently ignored.}
}
\value{
Correlation matrix plot or a dataframe containing results from
pairwise correlation tests. The package internally uses
\code{ggcorrplot::ggcorrplot} for creating the visualization matrix, while the
correlation analysis is carried out using the \code{correlation::correlation}
function.
}
\description{
Visualization of a correlation matrix
}
\examples{
\donttest{
# for reproducibility
set.seed(123)

# if `cor.vars` not specified, all numeric variables used
ggstatsplot::ggcorrmat(iris)

# to get the correlalogram
# note that the function will run even if the vector with variable names is
# not of same length as the number of variables
ggstatsplot::ggcorrmat(
  data = ggplot2::msleep,
  type = "robust",
  cor.vars = sleep_total:bodywt,
  cor.vars.names = c("total sleep", "REM sleep"),
  matrix.type = "lower"
)

# to get the correlation analyses results in a dataframe
ggstatsplot::ggcorrmat(
  data = ggplot2::msleep,
  cor.vars = sleep_total:bodywt,
  output = "dataframe"
)
}
}
\references{
\url{https://indrajeetpatil.github.io/ggstatsplot/articles/web_only/ggcorrmat.html}
}
\seealso{
\code{\link{grouped_ggcorrmat}} \code{\link{ggscatterstats}}
\code{\link{grouped_ggscatterstats}}
}
