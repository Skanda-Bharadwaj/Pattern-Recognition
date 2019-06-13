Run featureSelection.m

rankingfeat.m implements the Filter method for feature selection.
	- A provision is created to either choose VR(variance ratio) or AVR(Augmented Variance Ratio) as the selection criterion. You can type in the criterion as input argument.

forwardselection implements the wrapper based sequential forward selection.

datasplit.m is used in place of randomDivideMulti.m for convenience. The function splits the data based on the percentage required. 

plotConfusion plots the overall classification result and confusion matrix in a single table. 

2 workspaces for 100 iterations have been provided without data (data split to be called if train and test matrices are required). FACE_100epochs_50_50.mat and FACE_100epochs_70_30.mat. The numbers represent the data split. E.g: FACE_100epochs_70_30.mat represents that the entire feature matrix is split into 70% training data and 30% testing data.