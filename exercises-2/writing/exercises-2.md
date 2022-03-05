<br>

### Exercises 2

#### Abby Johnson

#### 3/7/22

<br>

### 1) Data visualization: UT CapMetro Ridership

<br>

![](figures/capmetroplot1-1.png)

Give the figure an informative caption in which you explain what is
shown in the figure and address the following questions, citing evidence
from the figure. Does the hour of peak boardings change from day to day,
or is it broadly similar across days? Why do you think average boardings
on Mondays in September look lower, compared to other days and months?
Similarly, why do you think average boardings on Weds/Thurs/Fri in
November look lower?

<br>

![](figures/capmetroplot2-1.png)

When we hold hour of day and weekend status constant, does temperature
seem to have a noticeable effect on the number of UT students riding the
bus?

<br>

### 2) Saratoga House Prices

<br>

**Cross-validated RMSE for linear model:**

    ## [1] 58057.2

**Cross-validated RMSE for KNN model:**

    ## [1] 70153.26

Which model seems to do better at achieving lower out-of-sample
mean-squared error? Write a report on your findings as if you were
describing your price-modeling strategies for a local taxing authority,
who needs to form predicted market values for properties in order to
know how much to tax them. Keep the main focus on the conclusions and
model performance; any relevant technical details should be put in an
appendix.

<br>

### 3) Classification and retrospective sampling: German loan defaults

<br>

![](figures/credit_propplot-1.png)

<br>

<table>
<caption>
**Logit Model Estimates For Predicting Default Probability**
</caption>
<thead>
<tr>
<th style="text-align:left;">
Predictor
</th>
<th style="text-align:right;">
Coefficient
</th>
<th style="text-align:right;">
SE
</th>
<th style="text-align:right;">
Z
</th>
<th style="text-align:right;">
p
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Intercept
</td>
<td style="text-align:right;">
-0.71
</td>
<td style="text-align:right;">
0.47
</td>
<td style="text-align:right;">
-1.50
</td>
<td style="text-align:right;">
0.134
</td>
</tr>
<tr>
<td style="text-align:left;">
Duration
</td>
<td style="text-align:right;">
0.03
</td>
<td style="text-align:right;">
0.01
</td>
<td style="text-align:right;">
3.12
</td>
<td style="text-align:right;">
0.002
</td>
</tr>
<tr>
<td style="text-align:left;">
Amount
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
0.00
</td>
<td style="text-align:right;">
2.63
</td>
<td style="text-align:right;">
0.009
</td>
</tr>
<tr>
<td style="text-align:left;">
Installment
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
2.91
</td>
<td style="text-align:right;">
0.004
</td>
</tr>
<tr>
<td style="text-align:left;">
Age
</td>
<td style="text-align:right;">
-0.02
</td>
<td style="text-align:right;">
0.01
</td>
<td style="text-align:right;">
-2.79
</td>
<td style="text-align:right;">
0.005
</td>
</tr>
<tr>
<td style="text-align:left;">
Poor History
</td>
<td style="text-align:right;">
-1.11
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
-4.48
</td>
<td style="text-align:right;">
0.000
</td>
</tr>
<tr>
<td style="text-align:left;">
Terrible History
</td>
<td style="text-align:right;">
-1.88
</td>
<td style="text-align:right;">
0.28
</td>
<td style="text-align:right;">
-6.68
</td>
<td style="text-align:right;">
0.000
</td>
</tr>
<tr>
<td style="text-align:left;">
Education
</td>
<td style="text-align:right;">
0.72
</td>
<td style="text-align:right;">
0.37
</td>
<td style="text-align:right;">
1.95
</td>
<td style="text-align:right;">
0.051
</td>
</tr>
<tr>
<td style="text-align:left;">
Goods/Repair
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
0.683
</td>
</tr>
<tr>
<td style="text-align:left;">
New Car
</td>
<td style="text-align:right;">
0.85
</td>
<td style="text-align:right;">
0.28
</td>
<td style="text-align:right;">
3.08
</td>
<td style="text-align:right;">
0.002
</td>
</tr>
<tr>
<td style="text-align:left;">
Used Car
</td>
<td style="text-align:right;">
-0.80
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
-2.21
</td>
<td style="text-align:right;">
0.027
</td>
</tr>
<tr>
<td style="text-align:left;">
German
</td>
<td style="text-align:right;">
-1.26
</td>
<td style="text-align:right;">
0.58
</td>
<td style="text-align:right;">
-2.19
</td>
<td style="text-align:right;">
0.028
</td>
</tr>
</tbody>
</table>

What do you notice about the history variable vis-a-vis predicting
defaults? What do you think is going on here? In light of what you see
here, do you think this data set is appropriate for building a
predictive model of defaults, if the purpose of the model is to screen
prospective borrowers to classify them into “high” versus “low”
probability of default? Why or why not—and if not, would you recommend
any changes to the bank’s sampling scheme?

<br>

### 4) Model building and validation: Children and hotel reservations

<br>
