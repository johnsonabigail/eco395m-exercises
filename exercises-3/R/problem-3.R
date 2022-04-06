greenbuildings = greenbuildings %>%
  mutate(rent = Rent * leasing_rate/100)
greenbuildings_split = initial_split(greenbuildings, prop = 0.8)
greenbuildings_train = training(greenbuildings_split)
greenbuildings_train= na.omit(greenbuildings_train)
greenbuildings_test = testing(greenbuildings_split)
greenbuildings_test = na.omit(greenbuildings_test)

# CART
greenbuildings_tree = rpart(rent~ (. -Rent -leasing_rate -LEED -Energystar), data=greenbuildings_train,
                            control = rpart.control(cp = 0.00001))

plotcp(greenbuildings_tree).
printcp(greenbuildings_tree)

cp_1se = function(my_tree) {
  out = as.data.frame(my_tree$cptable)
  thresh = min(out$xerror + out$xstd)
  cp_opt = max(out$CP[out$xerror <= thresh])
  cp_opt
}

cp_1se(greenbuildings_tree)

prune_1se = function(my_tree) {
  out = as.data.frame(my_tree$cptable)
  thresh = min(out$xerror + out$xstd)
  cp_opt = max(out$CP[out$xerror <= thresh])
  prune(my_tree, cp=cp_opt)
}

greenbuildings_tree_prune = prune_1se(greenbuildings_tree)

#out-of-sample performance
CART_RMSE = rmse(greenbuildings_tree_prune, greenbuildings_test)

# Random Forest
greenbuildings_forest = randomForest(rent~ (. -Rent -leasing_rate -LEED -Energystar), 
                                     data=greenbuildings_train, importance = TRUE)

RandomForest_RMSE = modelr::rmse(greenbuildings_forest, greenbuildings_test)  # a lot lower!
plot(greenbuildings_forest)

# Gradient-boosted tree
greenbuildings_boost = gbm(rent~ (. -Rent -leasing_rate -LEED -Energystar), 
                           data = greenbuildings_train,
                           interaction.depth=4, n.trees=500, shrinkage=.05)

=yhat_test_gbm = predict(greenbuildings_boost, greenbuildings_test, n.trees=350)
BoostedTree_RMSE = rmse(greenbuildings_boost, greenbuildings_test)

## RMSE Comparison
CART_RMSE
RandomForest_RMSE
BoostedTree_RMSE

# plots 
pdp_greenrating = partial(greenbuildings_forest, pred.var = "green_rating", plot=TRUE, plot.engine = "ggplot2")+ labs(x="Green Rating",y="PredictRent Revenue", title="Partial Dependence on Green Rating")





