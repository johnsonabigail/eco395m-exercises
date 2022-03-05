german_credit <- read_csv(here("data/german_credit.csv"))
view(german_credit)

count_history = german_credit %>%
  group_by(history)%>%
  summarize(count=n())
count_history

count_history_plot = ggplot(count_history)+
  geom_col(aes(history, count))+
  labs(x="Credit History",
       y="Total Loans",
       title = "Total Loans by Credit History")
count_history_plot

count_default_history = german_credit %>%
  filter(Default==1)%>%
  group_by(history)%>%
  summarize(count=n())
count_default_history

count_default_history_plot = ggplot(count_default_history)+
  geom_col(aes(history, count))+
  labs(x="Credit History",
       y="Total Defaulted Loans",
       title = "Total Defaulted Loans by Credit History")
count_default_history_plot


default_by_history = german_credit %>%
  group_by(history)%>%
  summarize(prop_default = ( sum( Default == 1 ) / length( Default ) ))
default_by_history

prop_default_bar = ggplot(default_by_history) +
  geom_col(aes(x=history, y=prop_default))+
  labs( x="Credit History",
        y = "Probability of Default",
        title = "Default Probabilty by Credit History")
prop_default_bar

logit_default = glm(Default ~ duration + amount + installment + age + history + purpose + foreign, data=german_credit, family=binomial)
coef(logit_default) %>% round(2)

# terrible and poor credits have lower probalities of defaulting than those with good credit.
# we can see that the sampling of defaulting loans didn't account for the relative amount of each type of loan
