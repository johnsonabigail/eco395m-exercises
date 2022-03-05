hotels_dev <- read_csv(here("data/hotels_dev.csv"))
hotels_val <- read_csv(here("data/hotels_val.csv"))


hotels_split = initial_split(hotels_dev, prop = 0.8)
hotels_train = training(hotels_split)
hotels_test = testing(hotels_split)

model1 = glm(children ~ market_segment + adults + customer_type + is_repeated_guest, data = hotels_train, family=binomial)
model2 = glm(children ~ (. - arrival_date), data=hotels_train, family=binomial)
model3 = glm(children ~ hotel + market_segment + adults + customer_type +stays_in_week_nights + (hotel)^2 + (market_segment)^2 + (adults)^2, data=hotels_train, family=binomial) # required_car_parking_spaces + (hotel*market_segment) + (hotel*required_car_parking_spaces)+ (adults*reserved_room_type) + (hotel^2), data = hotels_train, family=binomial)

rmse(model1, hotels_test)
rmse(model2, hotels_test)
rmse(model3, hotels_test)


