<br>

### 1) Data visualization: flights at ABIA

<br>

**Does average airline departure delay vary by day of the week? Or maybe
by time of the year?**

After averaging departure delays by day of week and month, we can
understand how airline departure delays may vary. <br>

<br> ![ExpressJet, Jetstream Intl, Mesa, and Jetblue are the four
airline carriers with the longest average departure delays, while
Endeavor Air, Northwest, Frontier, and Puerto Rico Intl have the
shortest delays. Moreover, most carriers experience their longest delays
at the beginning of the week or the weekend. Meanwhile, the day with
shortest delays typically is Tuesday or
Wednesday.](Figs/ABIA%20plot1-1.png)

<br> <br> <br> ![Compared to the average daily delays, the same four
airlines have the longest delays and the same four airlines have the
shortest delays throughout the year. However, across most airlines we
see the lowest delays around the fall. This makes sense when we consider
weather and travel patterns throughout the
year.](Figs/ABIA%20plot2-1.png)

<br>

**From these results, we can conclude that traveling early-mid week in
the fall on Endeavor Air, Frontier, Puerto Rico Intl, or Northwest
airlines will most likely result in the shortest departure delays out of
Austin.** <br> <br>

### 2) Wrangling the Billboard Top 100

<br> The Billboard Top 100 helps us understand what artists and songs
are popular throughout musical history. From Billboard Top 100 data, we
can better understand top songs, musical diversity, and long-run hits.

<br>

#### Part A

<br>

#### Top 10 Songs on Billboard Top 100 by Total Number of Weeks

<table>
<thead>
<tr class="header">
<th><strong>Performer</strong></th>
<th><strong>Song</strong></th>
<th><strong>Count</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Imagine Dragons</td>
<td>Radioactive</td>
<td>87</td>
</tr>
<tr class="even">
<td>AWOLNATION</td>
<td>Sail</td>
<td>79</td>
</tr>
<tr class="odd">
<td>Jason Mraz</td>
<td>Im Yours</td>
<td>76</td>
</tr>
<tr class="even">
<td>The Weeknd</td>
<td>Blinding Lights</td>
<td>76</td>
</tr>
<tr class="odd">
<td>LeAnn Rimes</td>
<td>How Do I Live</td>
<td>69</td>
</tr>
<tr class="even">
<td>LMFAO Featuring Lauren Bennett &amp; GoonRock</td>
<td>Party Rock Anthem</td>
<td>68</td>
</tr>
<tr class="odd">
<td>OneRepublic</td>
<td>Counting Stars</td>
<td>68</td>
</tr>
<tr class="even">
<td>Adele</td>
<td>Rolling In The Deep</td>
<td>65</td>
</tr>
<tr class="odd">
<td>Jewel</td>
<td>Foolish Games/You Were Meant For Me</td>
<td>65</td>
</tr>
<tr class="even">
<td>Carrie Underwood</td>
<td>Before He Cheats</td>
<td>64</td>
</tr>
</tbody>
</table>

<br> The number one song is Radioactive by Imagine Dragons with 87 total
weeks spent on the Billboard Top 100. Coming in at number ten is Before
He Cheats by Carrie Underwood, with 64 weeks on the Billbaord Top 100.
<br> <br>

#### Part B

<br> ![The musical diversity (or number of unique songs) of the
Billboard Top 100 was highest in the 1960s and around 2020. From about
1980 to 2010, there was less musical diversity on the Billboard Top 100,
which suggests that listeners preferred a less diverse collection of
msuic during this time.](Figs/musical%20diversity-1.png)

<br> <br>

#### Part C

<br> ![Only 19 aritsts had at least 30 songs on the Billboard Top 100
for at 10 weeks or longer. Of these 19 artists, we can see that the top
three artists are: Elton John with 52 hits, Madonna with 44 hits, and
Kenny Chesney with 42 hits.](Figs/longhits-1.png)

<br> <br>

## 3) Wrangling the Olympics

<br>

#### Part A

<br>

**The 95th percentile of heights for female competitors across all
Athletics events**

<br>

<table>
<thead>
<tr class="header">
<th><strong>Event</strong></th>
<th><strong>95th Percentile</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Athletics Women’s 1,500 metres</td>
<td>172.00</td>
</tr>
<tr class="even">
<td>Athletics Women’s 10 kilometres Walk</td>
<td>170.00</td>
</tr>
<tr class="odd">
<td>Athletics Women’s 10,000 metres</td>
<td>167.80</td>
</tr>
<tr class="even">
<td>Athletics Women’s 100 metres</td>
<td>179.60</td>
</tr>
<tr class="odd">
<td>Athletics Women’s 100 metres Hurdles</td>
<td>176.00</td>
</tr>
<tr class="even">
<td>Athletics Women’s 20 kilometres Walk</td>
<td>173.00</td>
</tr>
<tr class="odd">
<td>Athletics Women’s 200 metres</td>
<td>180.00</td>
</tr>
<tr class="even">
<td>Athletics Women’s 3,000 metres</td>
<td>170.00</td>
</tr>
<tr class="odd">
<td>Athletics Women’s 3,000 metres Steeplechase</td>
<td>176.80</td>
</tr>
<tr class="even">
<td>Athletics Women’s 4 x 100 metres Relay</td>
<td>176.00</td>
</tr>
<tr class="odd">
<td>Athletics Women’s 4 x 400 metres Relay</td>
<td>178.00</td>
</tr>
<tr class="even">
<td>Athletics Women’s 400 metres</td>
<td>180.00</td>
</tr>
<tr class="odd">
<td>Athletics Women’s 400 metres Hurdles</td>
<td>181.40</td>
</tr>
<tr class="even">
<td>Athletics Women’s 5,000 metres</td>
<td>170.75</td>
</tr>
<tr class="odd">
<td>Athletics Women’s 80 metres Hurdles</td>
<td>174.80</td>
</tr>
<tr class="even">
<td>Athletics Women’s 800 metres</td>
<td>175.75</td>
</tr>
<tr class="odd">
<td>Athletics Women’s Discus Throw</td>
<td>188.40</td>
</tr>
<tr class="even">
<td>Athletics Women’s Hammer Throw</td>
<td>183.90</td>
</tr>
<tr class="odd">
<td>Athletics Women’s Heptathlon</td>
<td>188.70</td>
</tr>
<tr class="even">
<td>Athletics Women’s High Jump</td>
<td>188.00</td>
</tr>
<tr class="odd">
<td>Athletics Women’s Javelin Throw</td>
<td>186.20</td>
</tr>
<tr class="even">
<td>Athletics Women’s Long Jump</td>
<td>181.35</td>
</tr>
<tr class="odd">
<td>Athletics Women’s Marathon</td>
<td>171.40</td>
</tr>
<tr class="even">
<td>Athletics Women’s Pentathlon</td>
<td>179.00</td>
</tr>
<tr class="odd">
<td>Athletics Women’s Pole Vault</td>
<td>183.00</td>
</tr>
<tr class="even">
<td>Athletics Women’s Shot Put</td>
<td>191.50</td>
</tr>
<tr class="odd">
<td>Athletics Women’s Triple Jump</td>
<td>186.90</td>
</tr>
</tbody>
</table>

<br> <br>

#### Part B

<br> **Which single women’s event had the greatest variability in
competitor’s heights across the entire history of the Olympics, as
measured by the standard deviation?** <br>

<table>
<thead>
<tr class="header">
<th><strong>Event</strong></th>
<th><strong>Standard Deviation</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Rowing Women’s Coxed Fours</td>
<td>10.86549</td>
</tr>
</tbody>
</table>

<br> The Women’s Rowing Coxed Fours has the highest variablity in height
across women’s single Olympic events. <br> <br>

#### Part C

<br> **How has the average age of Olympic swimmers changed over time?**
<br>

![The average age of all Olympic swimmers in the early 1900s is around
27 years old. However, the average age dips to around 20 during the
early and mid 1900s. By the 2010s, however, the average age is back up
to around 23.](Figs/swim%20agg%20plot-1.png)

<br> <br> ![The average age for male Olympic swimmers starts around 16
years old in 1900, but shoots up to about 32 in 1925 before dropping
back to about 20. By the 2010s, the average male age is about 24.
Meanwhile, for female Olympic swimmers, the average age is starts around
16 in 1925 and stays on an upward trend to around 22 in the
2010s.](Figs/swim%20age%20plot2-1.png)

<br> <br>

## 4) K-nearest Neighbors

<br>

#### S CLass 350

<br>

![After plotting the RMSE for different values of K, it is clear the the
RMSE bottoms out around K=40 for the S Class 350.](Figs/sclass350-1.png)

<br> <br> ![Using the optimal value of K=40 for the S Class 350, we can
plot the fitted model of price against mileage.](Figs/sclass350_2-1.png)

<br> <br>

#### S Class 65 AMG

<br>

![After plotting the RMSE for different values of K, it is clear the the
RMSE bottoms out around K=60 for the S Class 65
AMG.](Figs/sclass65-1.png)

<br> <br> ![Using the optimal value of K=60 for the S Class 65 AMG, we
can plot the fitted model of price against
mileage.](Figs/sclass65_2-1.png)

<br> <br> **Relative to the S Class 350, the S Class 65 AMG has a higher
optimal value of K. The S Class 65 AMG may have a larger optimal value
of K, because the predicted values are not as closely grouped together.
Therefore, a larger K is necessary to get a more accurate estimate.**
<br> <br> <br>
