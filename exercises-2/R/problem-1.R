capmetro_UT <- read_csv(here("data/capmetro_UT.csv"))

capmetro_UT = mutate(capmetro_UT,
                     day_of_week = factor(day_of_week,
                                          levels=c("Mon", "Tue", "Wed","Thu", "Fri", "Sat", "Sun")),
                     month = factor(month,
                                    levels=c("Sep", "Oct","Nov")))

mean_boardings = capmetro_UT %>%
  group_by(hour_of_day, day_of_week, month)%>%
  summarize(mean_boardings = mean(boarding))

mean_boardings_line = ggplot(mean_boardings) +
  geom_line(aes(x=hour_of_day, y=mean_boardings, color=month))+
  facet_wrap(~day_of_week)+
  labs(x="Hour",
       y="Average Boardings",
       title= "Average Boardings by Time",
       colour="Month")
mean_boardings_line

capmetro_UT = mutate(capmetro_UT, minute = minute(timestamp))

boardings_per_hour = capmetro_UT %>%
  group_by(minute, hour_of_day, weekend, temperature)%>%
  summarize(boardings = sum(boarding))
boardings_per_hour       

boardings_per_hour_scatter = ggplot(boardings_per_hour) +
  geom_point(aes(temperature, boardings, color=weekend))+
  facet_wrap(~hour_of_day)+
  labs(x="Temperature",
       y="Boardings",
       title = "Boardings by Time and Temperature",
       colour="Weekend")
boardings_per_hour_scatter
