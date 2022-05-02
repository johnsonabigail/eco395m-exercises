wine <- read_csv(here("data/wine.csv"), col_names = TRUE)
view(wine)
wine$red = ifelse(wine$color == "red", 1, 0)

#how does the wine quality compare across color of wine
quality_color = wine %>% 
  group_by(red) %>%
  summarize(avg_quality = mean(quality))

ggplot(quality_color) + 
  geom_col(aes(x=red, y=avg_quality))
#white wine has a marginally higher average wine quality 

#how many of each color of wine
ggplot(wine) +
  geom_bar(aes(x=red))
#almost 3x more white wine than red wine in the data 

#average response for each color, for each question,
wine_results = wine %>%
  group_by(red) %>% 
  select(-color) %>%
  summarize_all(mean) %>%
  column_to_rownames(var="red")
view(wine_results)
# now we have a tidy matrix of shows by questions

# a few quick plots
ggplot(rownames_to_column(wine_results, "red")) + 
  geom_col(aes(x=reorder(red, -residual.sugar), y = residual.sugar)) + 
  coord_flip()

ggplot(rownames_to_column(wine_results, "red")) + 
  geom_col(aes(x=reorder(red, -fixed.acidity), y = fixed.acidity)) + 
  coord_flip()

# a look at the correlation matrix
cor(wine_results)

# a quick heatmap visualization
ggcorrplot::ggcorrplot(cor(wine_results))

# looks a mess -- reorder the variables by hierarchical clustering
ggcorrplot::ggcorrplot(cor(wine_results), hc.order = TRUE)


# Now look at PCA of the (average) survey responses.  
# This is a common way to treat survey data
PCAwine = prcomp(wine_results, scale=TRUE, rank=3)

## variance plot
plot(PCAwine)
summary(PCAwine)

# first few pcs
# try interpreting the loadings
# the question to ask is: "which variables does this load heavily on (positive and negatively)?"
round(PCAwine$rotation[,1:2],2) 

# create a tidy summary of the loadings
loadings_summary = PCAwine$rotation %>%
  as.data.frame() %>%
  rownames_to_column('Property')

# This seems to pick out characteristics of
# well-received dramas with positive loadings?
loadings_summary %>%
  select(Property, PC1) %>%
  arrange(desc(PC1))

# this just seems to load negatively on most things
# honestly not sure!
loadings_summary %>%
  select(Property, PC2) %>%
  arrange(desc(PC2))

color_PCA = data.frame(PCAwine$x[,1:2])
color_PCA <- tibble::rownames_to_column(color_PCA, "red")

# Let's make some plots of the shows themselves in 
# PC space, i.e. the space of summary variables we've created
wine = merge(wine, color_PCA)
view(wine)

# let's plot in PC1 space
# We might feel good calling PC1 the "???" PC
#ggplot(wine) + 
#  geom_col(aes(x=reorder(wine, PC1), y=PC1)) + 
#  coord_flip()

# looks like a "lighthearted vs serious" PC
#ggplot(wine) + 
#  geom_col(aes(x=reorder(wine, PC2), y=PC2)) + 
#  coord_flip()

# principal component regression: quality 
lm1 = lm(quality ~ PC1 + PC2, data=wine) %>% tidy()%>%
  kable(
    caption = "Coefficient-Level Estimates for a Model Fitted to Estimate Variation in Wine Quality.",
    col.names = c("Predictor", "B", "SE", "t", "p")
  )
summary(lm1)

# color of wine
lm2 = lm(red ~ PC1 + PC2, data=wine)%>% tidy()%>%
  kable(
    caption = "Coefficient-Level Estimates for a Model Fitted to Estimate Variation in Wine Color",
    col.names = c("Predictor", "B", "SE", "t", "p")
  )

# Conclusion: we can predict engagement and ratings
# with PCA summaries of the pilot survey.
# probably too much variance to regress on all survey questions!
# since the sample size isn't too large here.
view(wine)

quality_plot = ggplot(wine) + geom_point(aes(x=fitted(lm1),y=quality, color=red))
color_plot = ggplot(wine) + geom_point(aes(x=fitted(lm2),y=red, color=red))

#################################################
wine <- read_csv(here("data/wine.csv"), col_names = TRUE)
wine$red = ifelse(wine$color == "red", 1, 0)
wine = wine %>% select(-color)
view(wine)

# Center/scale the data
wine_scaled = scale(wine, center=TRUE, scale=TRUE) 

# Form a pairwise distance matrix using the dist function
wine_distance_matrix = dist(wine_scaled, method='euclidean')


# Now run hierarchical clustering
hier_wine = hclust(wine_distance_matrix, method='complete')


# Plot the dendrogram
plot(hier_wine, cex=0.8)

# Cut the tree into 5 clusters
cluster1 = cutree(hier_wine, k=2)
summary(factor(cluster1))

# Examine the cluster members
which(cluster1 == 1)
which(cluster1 == 2)
which(cluster1 == 3)


# Using max ("complete") linkage instead
hier_wine2 = hclust(wine_distance_matrix, method='complete')

# Plot the dendrogram
plot(hier_wine2, cex=0.8)
cluster2 = cutree(hier_wine2, k=5)
summary(factor(cluster2))

# Examine the cluster members
which(cluster2 == 1)
which(cluster2 == 2)
which(cluster2 == 3)

D = data.frame(X1 =wine$quality, z = cluster2)
view(D)
cluster_quality_plot = ggplot(D) + geom_bar(aes(x=X1, fill=factor(z))) +labs(x="Quality",y="Count", fill="Cluster")

D2 = data.frame(X1 =wine$red, z = cluster2)
cluster_color_plot = ggplot(D2) + geom_bar(aes(x=X1, fill=factor(z))) +labs(x="Color", y="Count",fill="Cluster")
