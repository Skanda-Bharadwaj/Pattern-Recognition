Run SupervisedClassifiers.m for the experiments.
SupervisedClassifiers.m implements a User Input section that allows the user to choose the classifier and LDA analysis using Macros and the experiment will run accordingly.

Given below is the User-Input section of the SupervisedClassifiers.m file
------------------------------------------------------------------------------
%
% 
%             Given below is the User-Input section
%   |------------------------------------------------------|
%   | %% User Inputs                                       |
%   |                                                      |
%   | FISHERS_PROJECTION = 1;                              |
%   |                                                      |
%   | K_CLASS_DISCRIMINANT = 1;                            |
%   | KNN_CLASSIFIER       = 1;                            |
%   | k_nn = 5; % select a value of K for KNN classifier   |
%   |                                                      |
%   | I_WANT_ALL_FEATURES = 1;                             |
%   |------------------------------------------------------|
% 
%
------------------------------------------------------------------------------

If LDA is required, uncomment "%FISHERS_PROJECTION = 1;"

By default least squares K-class discriminant classifier is used. If you were to choose KNN, comment "K_CLASS_DISCRIMINANT = 1;" and uncomment "%KNN_CLASSIFIER = 1;". Also ensure to uncomment "%k_nn = 5;" which decides the number of nearest-neighbours.

Since visualisation requires fewer features, by default a train_featureVector will only contain 2 features. If you were to consider all the features, uncomment "%I_WANT_ALL_FEATURES = 1;"
Note : Enabling LDA will automatically consider all features into train_featureVector.
