curveFit.m implements curve fitting with different 4 approaches
	1. Error minimization without regularization
	2. Error minimization with regularization
	3. Maximum likelihood approach
	4. Maximum a posteriori approach

All the experiments of this file uses only 10 data points that is stored in data.mat

cvurveFittingAnalysis.m implements experiments with varying parameters such as M, N and lambda. This file uses data files data50.mat(50 data points) and data100.mat(100 data points). 

Experiments for different values for all the parameters are automated so that one single run will explores 18 experiments.

Refer to chapter 1 of "Pattern Recognition and Machine Learning", Christopher M. Bishop