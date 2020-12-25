# UIP
Uncovered Interest Parity

Uncovered interest parity is a theory that states changes in interest rates in two countries should be equal to the change of the foreign exchange rate between those two countries. To test this theory, we can use interest rates and exchange rates of the US dollar and Japanese Yen. These two countries were chosen for numerous reasons, including that they have data available that goes further back than other choices available. Furthermore, it will be interesting to study Japan—a country recovering economically from World War 2. Japan still uses unique monetary policies such as their managed float regime and employed trade strategies and choices to appreciate the Yen over time.

The data we will use will be the interest rates of 10-year government bonds for both countries, as well as the exchange rate between them. All datasets will be of monthly frequency. Because of the conditions of UIP, specifically foreign exchange equilibrium, we pick government bonds because they are typically of the least risk in a country’s economy. Our data comes from the Federal Reserve Economic Data of St. Louis . From their website, we can find the three datasets we need with monthly frequencies: US Dollar interest rates, Japanese Yen interest rates, and Japan / U.S. foreign exchange rates . Using R, we can plot these datasets to have a better understanding of their behavior. Using the merge() function in R, we find that the three datasets have 1989 as the earliest common start year. Furthermore, although we can combine the three datasets onto one graph, the Japan / U.S. foreign exchange rates have much higher values than the interest rates, and thus take away from the readability of the plots. 

Because the standard UIP condition can be rewritten as  (E_(JPY/USD)^e-E_(JPY/USD))/E_(JPY/USD) = R_JPY-R_USD , if UIP holds, R_JPY-R_USD should be an unbiased estimator of  (E_(JPY/USD)^e-E_(JPY/USD))/E_(JPY/USD) . Thus, we can run the regression ∆s= α +β(R_JPY-R_USD )+ ε , where ∆s is the percent change of the spot interest rate. Under the null hypothesis, given there is no risk premium, α=0 and β=1, and UIP holds. If there is a risk premium, it would impact α. Using R, we can find R_JPY-R_USD and ∆s. To illustrate both the interest rate differential and the change of the percent foreign exchange rate, we can make a scatterplot of the interest rate differential and the percent change of the foreign exchange rate between the US and Japan.


| Call: lm ( dFX ~ dIR )                     | Estimate | Standard Error | Pr(>|t|) |
| ------------------------------------------ |:--------:| --------------:| --------:|
| Intercept (α)                              | -2.9131  | 1.6685         | 0.0817   |
| Interest Rate Differential coefficient (β) | -1.0342  | 0.6054         | 0.0885   |


If this data was evidence for UIP, the estimate for the intercept α should have been near or at 0, and the estimate for the interest rate differential β should have been near or at 1. R outputs that according to OLS, the estimates for α  and β are respectively far from 0 and 1. Furthermore, because the residual standard error suggests how much, on average, the data deviates from the regression line, the standard error values in the table suggest that both the interest rate differential coefficient and the intercept deviate significantly from the regression line. The estimates +/- the standard errors are still not 0 or 1 respectively for alpha or beta. 

The results of our regression show clearly the data is not consistent with UIP. A possible explanation for this result is that there might be a variable risk premium in the Yen. The Japanese government experienced economic turbulence due to their losses from World War 2, and the Yen lost much of its value before the war. High risk premia due to high levels of government debt can lead to higher interest rates, which gives a positive correlation to interest rates and risk premia. If the risk premium is an increasing function of the interest rate, β would be less than 1, as our results show. 

| Call: lm ( dFX ~ dIR )        | Estimate           | Standard Error  |
| ------------- |:-------------:| -----:|
| Intercept (α)      | -2.9131 | 1.6685  |
| Interest Rate Differential coefficient (β)      | -1.0342      |   0.6054 |

