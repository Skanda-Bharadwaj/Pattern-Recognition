1.trianingDataCreation.m
	This scripts creates the region proposals required to train the alexnet from the wallpaper dataset. The region proposals are created from the labelling information that is available in the fillGroupValues.m file. 

2.fillGroupVlues.m
	This scripts contains the values required for manually labelling the images. The function call will fill the structure and return it.

3.CreateRegionProposals.m
	This is a function called by trainingDataCreation.m to convert the labelled regions into the input size of the alexnet (227, 227, 3) and to save the data into a folder.

4.RCNN_Alexnet.m
	This script implements the training of the pre-trained alexnet, testing and fetching the necessary results of classification. 

5.detectionAndLocalization.m
	This scripts implements detection and localization of the unit lattices in any given image. The script implements an exhaustive search, converts each image into (227, 227, 3), predicts the group, calls the function, checkIfBoxIsExisting.m, to mitigate overlapping bounding boxes and finally draws bounding boxes on the image to represent the unit lattices. 

6.CheckIfBoxIsExisting.m
	This scripts implements a workaround for non-maximum supression creating the same effects. It returns a boolean indicating whether or not to consider a given bounding box as representing a unit lattice. 

7.plotTriainingAccuracy_All.m
	Plots accuracy and loss Vs error.

8.plotConfusionMatrix.m
	Plots the confusion matrix with all the required the metrics, such as, precision, recall, missclassification rate etc.

9.Visualization.m
	Implements the visualization of filters of all the convolutional layers and the t-SNE from the last fully connected layer. 


To run the code, input an image to detectionAndLocalization.m and run the script. 

