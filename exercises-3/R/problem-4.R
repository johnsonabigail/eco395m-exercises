CAhousing_split = initial_split(CAhousing, prop = 0.8)
CAhousing_train = training(CAhousing_split)
CAhousing_train= na.omit(CAhousing_train)
CAhousing_test = testing(CAhousing_split)
CAhousing_test = na.omit(CAhousing_test)

# CART
CAhousing_tree = rpart(medianHouseValue ~ (. -households-population), data=CAhousing_train,
                            control = rpart.control(cp = 0.00001))
plotcp(CAhousing_tree)
printcp(CAhousing_tree)

cp_1se = function(my_tree) {
  out = as.data.frame(my_tree$cptable)
  thresh = min(out$xerror + out$xstd)
  cp_opt = max(out$CP[out$xerror <= thresh])
  cp_opt
}

cp_1se(CAhousing_tree)

prune_1se = function(my_tree) {
  out = as.data.frame(my_tree$cptable)
  thresh = min(out$xerror + out$xstd)
  cp_opt = max(out$CP[out$xerror <= thresh])
  prune(my_tree, cp=cp_opt)
}

CAhousing_tree_prune = prune_1se(CAhousing_tree)

CART_RMSE = rmse(CAhousing_tree_prune, CAhousing_test)

# Random forest

CAhousing_forest = randomForest(medianHouseValue~ (. -households-population), 
                                     data=CAhousing_train, importance = TRUE)

RandomForest_RMSE = modelr::rmse(CAhousing_forest, CAhousing_test) 
plot(CAhousing_forest)

# Gradient-boosted tree

CAhousing_boost = gbm(medianHouseValue~ (. -households-population), 
                           data = CAhousing_train,
                           interaction.depth=4, n.trees=500, shrinkage=.05)
gbm.perf(CAhousing_boost)
yhat_test_gbm = predict(CAhousing_boost, CAhousing_test, n.trees=350)

BoostedTree_RMSE = rmse(CAhousing_boost, CAhousing_test)

## RMSE Comparison 
CART_RMSE
RandomForest_RMSE
BoostedTree_RMSE


CAhousing = CAhousing %>%
  mutate(medianHouseValue_hat = predict(CAhousing_boost, CAhousing), medianHouseValue_residual = (medianHouseValue - medianHouseValue_hat))

plot1 = qmplot(longitude, latitude, data = CAhousing, maptype = "toner-background", color = medianHouseValue) +
  labs(title = "CA Median House Value by Geographic Location", colour = "Median House Value")
  
plot2 = qmplot(longitude, latitude, data = CAhousing, maptype = "toner-background", color = medianHouseValue_hat) +
  labs(title = "CA Predicted Median House Value by Geographic Location", colour = "Predicted Median House Value")

plot3 = qmplot(longitude, latitude, data = CAhousing, maptype = "toner-background", color = medianHouseValue_residual) +
  labs(title = "CA Median House Value Predicted Residuals by Geographic Location", colour = "Predicted Residual of Median House Value")
