hotels_dev <- read_csv(here("data/hotels_dev.csv"))
hotels_dev = dummy_cols(hotels_dev) %>%
  mutate(reserved_room_type_I=0)%>%
  mutate(reserved_room_type_J=0)%>%
  mutate(reserved_room_type_K=0)%>%
  mutate(reserved_room_type_L=0)%>%
  mutate(assigned_room_type_J=0)%>%
  mutate(assigned_room_type_L=0)%>%
  select(-c(assigned_room_type, reserved_room_type, hotel, meal, market_segment, distribution_channel, deposit_type, customer_type, required_car_parking_spaces))

hotels_val <- read_csv(here("data/hotels_val.csv"))
hotels_val = dummy_cols(hotels_val) %>%
  mutate(reserved_room_type_I=0)%>%
  mutate(reserved_room_type_J=0)%>%
  mutate(reserved_room_type_K=0)%>%
  mutate(reserved_room_type_L=0)%>%
  mutate(assigned_room_type_J=0)%>%
  mutate(assigned_room_type_L=0)%>%
  select(-c(assigned_room_type, reserved_room_type, hotel, meal, market_segment, distribution_channel, deposit_type, customer_type, required_car_parking_spaces))

#m1_x= model.matrix(children ~ market_segment + adults + customer_type + is_repeated_guest, data=hotels_dev)
m2_x= model.matrix(children ~ (. - arrival_date -1), data=hotels_dev)
#m3_x= model.matrix(children ~ (. -arrival_date - 1 + (hotel^2) + (market_segment)^2 + (customer_type)^2 + (adults*reserved_room_type) + (market_segment*customer_type)), data=hotels_dev)
y = hotels_dev$children

#m1_lasso = cv.gamlr(m1_x, y, nfold=10, family="binomial")
#m1_plot = plot(m1_lasso, bty="n")
#log(m1_lasso$lambda.min)

m2_lasso = cv.gamlr(m2_x, y, nfold=10, family="binomial")
plot(m2_lasso, bty="n")
log(m2_lasso$lambda.min)

#m3_lasso = cv.gamlr(m3_x, y, nfold=10, family="binomial") # Best linear model based out-of-sample deviance
#plot(m3_lasso, bty="n") 
#log(m3_lasso$lambda.min)

#########################

val_x= model.matrix(children ~ (. - arrival_date -1), data=hotels_val)

lasso_pred = predict(m2_lasso, val_x, select= "min")
pred = predict(m2_lasso, val_x, type= "response")

yhat_val = ifelse(pred >= 0.5, 1, 0)

conf = table(y=hotels_val$children, yhat=yhat_val)
conf[2,2] / (conf[2,1] + conf[2,2]) #TPR
conf[1,2] / (conf[1,1] + conf[1,2]) #FPR

TPR = 139/(263+139)
TPR

FPR = 57/(4540+57)
FPR

roc_curve = plot(roc(hotels_val$children, pred))

#########################

K_folds = 20
hotels_val = hotels_val%>%
  mutate(fold_id = rep(1:K_folds, length=nrow(hotels_val)) %>% sample)

folds_lasso = foreach(fold = 1:K_folds, .combine='c') %do% {
  in_fold_data = filter(hotels_val, fold_id == fold)
  out_fold_data = filter(hotels_val, fold_id != fold)
  x=model.matrix(children ~ (. -arrival_date - 1 ), data=out_fold_data)
  y=out_fold_data$children
  lasso = cv.gamlr(x, y,nfold=5, family="binomial")
  xval=model.matrix(children ~ (. -arrival_date - 1), data=in_fold_data)
  pred = predict(lasso, xval, type= "response")
  yhat_val = ifelse(pred >= 0.5, 1, 0)
  table = table(y=in_fold_data$children, yhat=yhat_val)
  TPR = table[2,2] / (table[2,1] + table[2,2]) #TPR
}


folds_lasso = data.frame(folds_lasso)
colnames(folds_lasso)=c("TPR")
folds_lasso$folds = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20)
folds_lasso

TPR_fold_comparison = ggplot(folds_lasso)+
  geom_col(aes(x=folds, y=TPR))+labs(
    x="Fold",
    y="TPR",
    title = "TPR by Fold")
TPR_fold_comparison

mean_TPR = folds_lasso %>%
  summarize(meanTPR = mean(TPR))
