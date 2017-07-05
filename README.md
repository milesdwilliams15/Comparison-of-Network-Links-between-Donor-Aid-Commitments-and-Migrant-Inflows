# Comparison of Network Links between Donor Aid Commitments and Migrant-Inflows

## A Network Analysis

For d = 18 OECD Members, Pearson's correlation coefficient is estimated for aid commitments from d_1 and d_n to a given aid recipient (a non-member state of the OECD) and for migrant inflows from a given aid recipient to d_1 and d_n. 

An example of the equation used to estimate Pearson's r for bilateral aid commitments between donors is shown below.

<img width="355" alt="capture" src="https://user-images.githubusercontent.com/23504082/27806715-bf712938-6001-11e7-9c9a-414f90bbd535.PNG">

Following estimation of each pairwise correlation coefficient, the results are placed within a network analytic model where each node in the network to be mapped is a given donor and where the width and transparency of the links between nodes is proportional to the strength of the estimated pairwise correlation.

<img width="538" alt="img network" src="https://user-images.githubusercontent.com/23504082/27806910-06906292-6003-11e7-8edb-b11beb4e8af5.PNG">
<img width="534" alt="aid network" src="https://user-images.githubusercontent.com/23504082/27806924-1d8baa10-6003-11e7-8b88-fa36542240c5.PNG">

## Does Bilateral Distance Explain Variation in Correlations in Bilateral Aid Commitments?

To what extent does geographical proximity account for stronger network ties (strength of correlation between the bilateral aid commitments of donor_1 and donor_n)? To answer this question, I estimated a simple regression model where the dependent variable was the correlation between countries' bilateral aid commitments and where the dependent variable was the bilateral distance between countries' largest population centers in kilometers, weighted by the size of the population centers.

<img width="216" alt="capture2" src="https://user-images.githubusercontent.com/23504082/27878106-bd552078-6182-11e7-8730-1906fe4e6764.PNG">

As the below figure shows, the distance does seem to be associated with a decline in the strength of correlation between country-pairs' bilateral aid commitments. The model estimates are statistically significant and the model accounts for around 20% of the variation in the dependent variable.

<img width="872" alt="correlation and distance" src="https://user-images.githubusercontent.com/23504082/27878242-2d0909fc-6183-11e7-909a-fa80b6736d0d.PNG">

One should note, however, that there is a notable degree of heterosketasticity in the data. Though it is hard to say for certain, one could look at the above figure and postulate that greater proximity is a necessary, though not sufficient, condition for stronger links between two given countries' bilateral aid commitments. That is, the farther two countries are from one another, the less likely the two are to have similar patterns of bilateral aid commitments; however, greater proximity, does not guarantee that two countries with have increasingly similar patterns of bilateral aid commitments. Other factors, unaccounted for in this analysis, likely inhibit or promote greater similarity in aid allocation.
