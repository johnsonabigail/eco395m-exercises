
dengue <- read_csv(here("data/dengue.csv"), col_names =TRUE)

dengue = unlist(dummy_cols(dengue))
dengue_split = initial_split(dengue, prop = 0.8)
dengue_train = training(dengue_split)
dengue_train= na.omit(dengue_train)
dengue_test = testing(dengue_split)
dengue_test = na.omit(dengue_test)

cases_dist = ggplot(dengue)+
  geom_histogram(aes(x=total_cases))+labs(x="Total Dengue Cases", y="Count", title="Distribution of Total Dengue Cases")

logcases_dist = ggplot(dengue)+
  geom_histogram(aes(x=log_cases), bins=40)+labs(x="Log Dengue Cases", y="Count", title="Distribution of log Dengue Cases")

#CART
dengue_tree = rpart(total_cases~city_iq + city_sj + season_fall + season_spring + season_summer + season_winter + specific_humidity + avg_temp_k + precipitation_amt, data=dengue_train,
                   control = rpart.control(cp = 0.00001))

plotcp(dengue_tree)
printcp(dengue_tree)

#pick smallest function whose CV is within 1 se
cp_1se = function(my_tree) {
  out = as.data.frame(my_tree$cptable)
  thresh = min(out$xerror + out$xstd)
  cp_opt = max(out$CP[out$xerror <= thresh])
  cp_opt
}

cp_1se(dengue_tree)

# prune tree to 1se
prune_1se = function(my_tree) {
  out = as.data.frame(my_tree$cptable)
  thresh = min(out$xerror + out$xstd)
  cp_opt = max(out$CP[out$xerror <= thresh])
  prune(my_tree, cp=cp_opt)
}

dengue_tree_prune = prune_1se(dengue_tree)

#out-of-sample performance
CART_RMSE = rmse(dengue_tree_prune, dengue_test)

#Random Forest

dengue_forest = randomForest(total_cases~city_iq + city_sj + season_fall + season_spring + season_summer + season_winter + specific_humidity + avg_temp_k + precipitation_amt,
                           data=dengue_train, importance = TRUE)

RandomForest_RMSE = modelr::rmse(dengue_forest, dengue_test) 


#Gradient-boosted tree

dengue_boost = gbm(total_cases~city_iq + city_sj + season_fall + season_spring + season_summer + season_winter + specific_humidity + avg_temp_k + precipitation_amt, 
             data = dengue_train,
             interaction.depth=4, n.trees=500, shrinkage=.05)

gbm.perf(dengue_boost)

yhat_test_gbm = predict(dengue_boost, dengue_test, n.trees=350)

BoostedTree_RMSE = rmse(dengue_boost, dengue_test)

#RMSE Comparison 
CART_RMSE
RandomForest_RMSE
BoostedTree_RMSE

# Partial dependence plots 
pdp_humidity = partial(dengue_forest, pred.var = "specific_humidity", plot=TRUE, plot.engine = "ggplot2")+ labs(x="Specific Humidity",y="Predicted Cases", title="Partial Dependence on Specific Humidity")
pdp_precip = partial(dengue_forest, pred.var = "precipitation_amt", plot=TRUE, plot.engine = "ggplot2")+ labs(x="Precipitation Amount",y="Predicted Cases", title="Partial Dependence on Precipitation Amount")
pdp_temp = partial(dengue_forest, pred.var = "avg_temp_k", plot=TRUE, plot.engine = "ggplot2")+ labs(x="Average Temperature",y="Predicted Cases", title="Partial Dependence on Average Temperature")






