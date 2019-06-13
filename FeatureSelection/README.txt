Run featureSelection.m

rankingfeat.m implements the Filter method for feature selection.
	- A provision is created to either choose VR(variance ratio) or AVR(Augmented Variance Ratio) as the selection criterion. You can type in the criterion as input argument.

forwardselection implements the wrapper based sequential forward selection.

datasplit.m is used in place of randomDivideMulti.m for convenience. The function splits the data based on the percentage required. 

plotConfusion plots the overall classification result and confusion matrix in a single table. 
