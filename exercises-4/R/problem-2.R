social_marketing <- read_csv(here("data/social_marketing.csv"), col_names = TRUE)
view(social_marketing)

adult_bots = social_marketing %>%
  filter(adult>0)%>%
  summarize(count=n())

spam_bots = social_marketing %>%
  filter(spam>0)%>%
  summarize(count=n())

both_bots = social_marketing %>%
  filter(spam>0 & adult>0)%>%
  summarize(count=n())

total_bots = adult_bots + spam_bots - both_bots #573 total bots 

social_marketing = social_marketing %>%
  filter(spam==0 & adult==0) %>% 
  select(-spam)%>% select(-adult) %>% select(-...1) #filter out bot users (573) 
view(social_marketing)

mean_uncategorized = social_marketing %>%
  filter(uncategorized>0)%>%
  summarize(mean=mean(uncategorized)) #of users who post more than zero uncategorized posts,
# their average amount of uncategorized posts = 1.47

uncategorized_users = social_marketing %>%
  filter(uncategorized>2)%>%
  summarize(count=n()) #407 users with more than average number of uncategorized posts 

social_marketing = social_marketing %>%
  filter(uncategorized<=2) #filter out uncategorized users
view(social_marketing)

mean_chatter = social_marketing %>%
  filter(chatter>0)%>%
  summarize(mean=mean(chatter))

chatter_users = social_marketing %>%
  filter(chatter>5)%>%
  summarize(count=n())

social_marketing = social_marketing %>%
  filter(chatter<=5) #filter out chatter users
view(social_marketing)

###### Clustering #######

# Center/scale the data
social_marketing_scaled = scale(social_marketing, center=TRUE, scale=TRUE) 

# Form a pairwise distance matrix using the dist function
social_marketing_distance_matrix = dist(social_marketing_scaled, method='euclidean')

# Using max ("complete") linkage instead
hier_social_marketing2 = hclust(social_marketing_distance_matrix, method='complete')

# Plot the dendrogram
plot(hier_social_marketing2, cex=0.8)
cluster2 = cutree(hier_social_marketing2, k=4)
summary(factor(cluster2))

# Examine the cluster members
clust1users = data.frame(social_marketing[which(cluster2 == 1),]) 
clust2users = data.frame(social_marketing[which(cluster2 == 2),]) 
clust3users = data.frame(social_marketing[which(cluster2 == 3),]) 
clust4users = data.frame(social_marketing[which(cluster2 == 4),]) 

clust1_cat = clust1users %>%
  summarize_all(mean) 
clust1_cat = sort(clust1_cat, decreasing=TRUE) #health_nutrition, chatter
clust1_cat = data.frame(t(clust1_cat))
clust1_cat = rownames_to_column(clust1_cat, "category")
clust1_cat = clust1_cat %>% 
  rename(average_count=t.clust1_cat.)
clust1_plot = ggplot(head(clust1_cat)) + geom_col(aes(x=category, y=average_count))+labs(x="Category",y="Average Count", title="Top Categories: Cluster 1")

clust2_cat = clust2users %>%
  summarize_all(mean)
clust2_cat = sort(clust2_cat, decreasing=TRUE) #sports_fandom, religion, food, parenting, school
clust2_cat = data.frame(t(clust2_cat))
clust2_cat = rownames_to_column(clust2_cat, "category")
clust2_cat = clust2_cat %>% 
  rename(average_count=t.clust2_cat.)
clust2_plot = ggplot(head(clust2_cat)) + geom_col(aes(x=category, y=average_count))+labs(x="Category",y="Average Count", title="Top Categories: Cluster 2")

clust3_cat = clust3users %>%
  summarize_all(mean)
clust3_cat = sort(clust3_cat, decreasing=TRUE) #politics, travel, computers
clust3_cat = data.frame(t(clust3_cat))
clust3_cat = rownames_to_column(clust3_cat, "category")
clust3_cat = clust3_cat %>% 
  rename(average_count=t.clust3_cat.)
clust3_plot = ggplot(head(clust3_cat)) + geom_col(aes(x=category, y=average_count))+labs(x="Category",y="Average Count", title="Top Categories: Cluster 3")

clust4_cat = clust4users %>%
  summarize_all(mean)
clust4_cat = sort(clust4_cat, decreasing=TRUE) # cooking, fashion, phot_sharing, beauty
clust4_cat = data.frame(t(clust4_cat))
clust4_cat = rownames_to_column(clust4_cat, "category")
clust4_cat = clust4_cat %>% 
  rename(average_count=t.clust4_cat.)
clust4_plot = ggplot(head(clust4_cat)) + geom_col(aes(x=category, y=average_count)) +labs(x="Category",y="Average Count", title="Top Categories: Cluster 4")
