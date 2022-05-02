groceries_raw <- read_csv(here("data/groceries.txt"), col_names = FALSE)

groceries = cSplit(groceries_raw,"X4",",")
groceries <- tibble::rownames_to_column(groceries, "shopper")
groceries = groceries%>%
  pivot_longer(!shopper,names_to = "item count", values_to = "item" , values_drop_na = TRUE) %>% select(-"item count")

view(groceries)

dev.off() 

itemcounts = groceries %>%
  group_by(item) %>%
  summarize(count = n()) %>%
  arrange(desc(count))

itemcounts_plot = head(itemcounts, 20) %>%
  ggplot() +
  geom_col(aes(x=reorder(item, count), y=count)) + 
  coord_flip() + labs(x="Grocery Item", y="Count", title="Top 20 Most Bought Grocery Items")


####
# Data pre-preprocessing
####

# Turn shopper into a factor
groceries$shopper = factor(groceries$shopper)
view(groceries)
# First create a list of baskets: vectors of items by consumer

# apriori algorithm expects a list of baskets in a special format.
# it's a bit finicky!
# In this case, one "basket" of items per user
# First split data into a list of items for each shopper
groceries_split = split(x=groceries$item, f=groceries$shopper)

# the first users's basket, the second user's etc
# note the [[ ]] indexing, this is how you extract
# numbered elements of a list in R
groceries_split[[1]]  # first user's playlist
groceries_split[[2]]  # second user's playlist

## Remove duplicates ("de-dupe")
# lapply says "apply a function to every element in a list"
# unique says "extract the unique elements" (i.e. remove duplicates)
groceries_split = lapply(groceries_split, unique)

## Cast this resulting list of baskets as a special arules "transactions" class.
baskettrans = as(groceries_split, "transactions")
summary(baskettrans)

# Now run the 'apriori' algorithm
# Look at rules with support > .01 & confidence >.1 & length (# artists) <= 5
groceryrules = apriori(baskettrans, 
                     parameter=list(support=.01, confidence=.1, maxlen=2))

# Look at the output... so many rules!
inspect(groceryrules)

## Choose a subset
inspect(subset(groceryrules, lift > 2))
inspect(subset(groceryrules, confidence > 0.4))
inspect(subset(groceryrules, lift > 1.7 & confidence > 0.3))

# plot all the rules in (support, confidence) space
# notice that high lift rules tend to have low support
plot(groceryrules)

# can swap the axes and color scales
plot(groceryrules, measure = c("support", "lift"), shading = "confidence")

# "two key" plot: coloring is by size (order) of item set
twokey_plot =plot(groceryrules, method='two-key plot')

# can now look at subsets driven by the plot
inspect(subset(groceryrules, support > 0.025))
inspect(subset(groceryrules, confidence > 0.25))


# graph-based visualization
sub1 = subset(groceryrules, subset=confidence > 0.1 & support > 0.02)
summary(sub1)
plot(sub1, method='graph')

sub1_plot = plot(head(sub1, 100, by='lift'), method='graph')

# export a graph
#sub1 = subset(groceryrules, subset=confidence > 0.25 & support > 0.005)
#subset_plot = plot(head(sub1, 100, by='lift'), method='graph') #use this plot in write-up!
#saveAsGraph(sub1, file = "groceryrules.graphml")
