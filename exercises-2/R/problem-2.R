data(SaratogaHouses)
SaratogaHouses$waterfront <- ifelse(SaratogaHouses$waterfront == 'Yes', 1, 0)
SaratogaHouses$centralAir <- ifelse(SaratogaHouses$centralAir == 'Yes', 1, 0)
SaratogaHouses$newConstruction <- ifelse(SaratogaHouses$newConstruction == 'Yes', 1, 0)
SaratogaHouses$heating_electric <- ifelse(SaratogaHouses$heating == 'electric', 1, 0)
SaratogaHouses$heating_hotwater <- ifelse(SaratogaHouses$heating == 'hot water/steam', 1, 0)
SaratogaHouses$heating_hotair <- ifelse(SaratogaHouses$heating == 'hot air', 1, 0)
SaratogaHouses$fuel_electric <- ifelse(SaratogaHouses$fuel == 'electric', 1, 0)
SaratogaHouses$fuel_gas <- ifelse(SaratogaHouses$fuel == 'gas', 1, 0)
SaratogaHouses$fuel_oil <- ifelse(SaratogaHouses$fuel == 'oil', 1, 0)
SaratogaHouses$sewer_septic <- ifelse(SaratogaHouses$sewer == 'septic', 1, 0)
SaratogaHouses$sewer_public <- ifelse(SaratogaHouses$sewer == 'public/commercial', 1, 0)
SaratogaHouses$sewer_none <- ifelse(SaratogaHouses$sewer == 'none', 1, 0)

glimpse(SaratogaHouses)
view(SaratogaHouses)

saratoga_split = initial_split(SaratogaHouses, prop = 0.8)
saratoga_train = training(saratoga_split)
saratoga_test = testing(saratoga_split)

lm2 = lm(price ~ . - pctCollege - sewer - waterfront - landValue - newConstruction, data=saratoga_train)

lm = lm(price ~ (. -pctCollege - heating - heating_hotair - fuel - fuel_oil - sewer - sewer_none +(bedrooms*lotSize)), data=saratoga_train)

coef(lm) %>% round(0)

rmse(lm2, saratoga_test)
rmse(lm, saratoga_test) ## linear model outperforms medium model

K_folds = 10
SaratogaHouses = SaratogaHouses %>%
  mutate(fold_id = rep(1:K_folds, length=nrow(SaratogaHouses)) %>% sample)

head(SaratogaHouses)

lm_rmse_cv = foreach(fold = 1:K_folds, .combine='c') %do% {
  lm = lm(price ~ (. -pctCollege - heating - heating_hotair - fuel - fuel_oil - sewer - sewer_none +(bedrooms*lotSize)),
  data=filter(SaratogaHouses, fold_id != fold))
modelr::rmse(lm, data=filter(SaratogaHouses, fold_id == fold))
}

lm_rmse_cv
mean(lm_rmse_cv) 
sd(lm_rmse_cv)/sqrt(K_folds) 

########################
SaratogaHouses_standardized = SaratogaHouses %>%
  mutate(price_s = scale(price), 
         lotSize_s = scale(lotSize),
         age_s = scale(age),
         landValue_s = scale(landValue),
         livingArea_s = scale(livingArea),
         pctCollege_s = scale(pctCollege),
         bedrooms_s = scale(bedrooms),
         fireplaces_s = scale(fireplaces),
         bathrooms_s = scale(bathrooms),
         rooms_s = scale(rooms),
         waterfront_s = scale(waterfront),
         newConstruction_s = scale(newConstruction),
         centralAir_s = scale(centralAir),
         heating_electric_s = scale(heating_electric),
         heating_hotwater_s = scale(heating_hotwater),
         heating_hotair_s = scale(heating_hotair),
         fuel_electric_s = scale(fuel_electric),
         fuel_gas_s = scale(fuel_gas),
         fuel_oil_s = scale(fuel_oil),
         sewer_septic_s = scale(sewer_septic),
         sewer_public_s = scale(sewer_public),
         sewer_none_s = scale(sewer_none))
      
glimpse(SaratogaHouses_standardized)

saratoga_split_s = initial_split(SaratogaHouses_standardized, prop = 0.8)
saratoga_train_s = training(saratoga_split_s)
saratoga_test_s = testing(saratoga_split_s)

SaratogaHouses_standardized = SaratogaHouses_standardized %>%
  mutate(fold_id = rep(1:K_folds, length=nrow(SaratogaHouses_standardized)) %>% sample)

knn_rmse_cv = foreach(fold = 1:K_folds, .combine='c') %do% {
  knn100 = knnreg(price ~(. -pctCollege - heating_hotair - fuel_oil - sewer_none),
                  data=filter(SaratogaHouses_standardized, fold_id != fold), k=20)
  modelr::rmse(knn100, data=filter(SaratogaHouses_standardized, fold_id == fold))
}

knn_rmse_cv
mean(knn_rmse_cv)  
sd(knn_rmse_cv)/sqrt(K_folds)  


SaratogaHouses_standardized_folds = crossv_kfold(SaratogaHouses_standardized, k=K_folds)

k_grid = c(2, 4, 6, 8, 10, 15, 20, 25, 30, 35, 40, 45,
           50, 60, 70, 80, 90, 100, 125, 150, 175, 200, 250, 300)

knn_cv_grid = foreach(k = k_grid, .combine='rbind') %dopar% {
  models = map(SaratogaHouses_standardized_folds$train, ~ knnreg(price ~(. -pctCollege - heating_hotair - fuel_oil - sewer_none), k=k, data = ., use.all=FALSE))
  errs = map2_dbl(models, SaratogaHouses_standardized_folds$test, modelr::rmse)
  c(k=k, err = mean(errs), std_err = sd(errs)/sqrt(K_folds))
} %>% as.data.frame

knn_cv_grid_plot = ggplot(knn_cv_grid) + 
  geom_point(aes(x=k, y=err)) + 
  geom_errorbar(aes(x=k, ymin = err-std_err, ymax = err+std_err)) + 
  scale_x_log10()
knn_cv_grid_plot









