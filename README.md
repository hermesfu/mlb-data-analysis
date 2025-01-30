This repository is a project to grab and analyze MLB player batting data.
The Python program grabs MLB player batting data from the official website and make some simple analyses.
The R program analyzes the data based on some statistical methods such as ANOVA and multinominal regression.
The pdf file contains the analysis report.
The majority of the analysis focuses on performance differences across positions. The result shows a significant difference in stolen bases across different positions. The multinomial regressions and machine learning model also provide a moderately accurate prediction for players' positions based on their batting data(not so accurate, but a lot better than random guessing).

Update: After writing the analysis report, I created a new ML model to predict players' positions (like I did with multinomial regressions). The ML's accuracy is about 0.2518, similar to the accuracy of multinomial regressions. The main problem is that the data set is quite few in terms of ML(only about 1000 training data from 2024 and 1000 testing data from 2023). This is what I am trying to improve. Also, the model shows a particularly accurate prediction for center fielders, who might have significantly different batting performances from others.
