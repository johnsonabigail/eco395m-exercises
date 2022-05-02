# installs the librarian package if you don't have it
if (!("librarian" %in% rownames(utils::installed.packages()))) {
  utils::install.packages("librarian")
}

# put all of the packages that you import here
librarian::shelf( 
  cran_repo = "https://cran.microsoft.com/", # Dallas, TX
  ask = FALSE,
  stats, # https://stackoverflow.com/questions/26935095/r-dplyr-filter-not-masking-base-filter#answer-26935536
  here,
  kableExtra,
  rlang,
  ggthemes,
  tidyverse,
  janitor,
  magrittr,
  glue,
  lubridate,
  haven,
  snakecase,
  sandwich,
  lmtest,
  gganimate,
  gapminder,
  stargazer,
  snakecase,
  mosaicData,
  modelr,
  rsample,
  foreach,
  caret,
  parallel,
  purrr,
  pander,
  readr,
  xtable,
  gamlr,
  CVXR,
  pROC,
  ROCR,
  fastDummies, 
  randomForest, 
  gbm, 
  pdp,
  rpart,
  ggmap,
  devtools,
  usmap,
  splines,
  ggcorrplot,
  LICORS,
  arules,
  arulesViz,
  igraph,
  splitstackshape, 
  tidyr)

# tell here where we are so we can use it elsewhere
here::i_am("R/include.R")
