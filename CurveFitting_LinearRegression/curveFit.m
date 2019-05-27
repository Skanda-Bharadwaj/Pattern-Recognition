%% Curve Fitting/Linear Regression
%--------------------------------------------------------------------------
%  
% This scripts implements curve fitting for randomly generated data with
% guassian noise by
%
% estimate the regression coefficients w by minimizing
% (1) the sum-of-squares error.
% (2) Maximum Likelihood and Maximum A Posteriori(MAP) estimator of the 
% Bayesian approach by introducing a prior distribution p(w|α) over the 
% coefficients and therefore solve it as the Bayesian linear regression 
% problem. 
%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ========================================================================

clear; close all; clc;

%% ======================== Input generation ==============================

%Set the order of the polynomial
M = 9;

%Set the regularization coefficient
lnLambda = 3; 

%Generate input data by providing the number of samples
numDataPoints = 10;

%Load data points
load data.mat

x=x'; Y=y'; T=t';
N = length(x);

%Create the matrix X
X = [ones(N, 1), zeros(N, M)];
for i = 1:M
    X(:, i+1) = x.^i;
end

%% ============= Linear Regression (Without Regularization) ===============

%compute the closed form solution: W = inv(X'X)*X'*T
W = (X'*X)\(X'*T);          

%compute the resulting polynomial from W
yhat = X*W;

%compute the error 
Err  = 0.5*sum((yhat-T).^2);   

figure(1)
    %Plot the data points
    scatter(x, T', 'b', 'LineWidth', 2); hold on
    %Plot the GroundTruth
    plot(x, Y', 'r', 'LineWidth', 2);
    %Plot the extimated polynomial
    plot(x, yhat', 'g', 'LineWidth', 2);  
    %Title, labels and legend
    set(gca,'FontWeight','bold','LineWidth',2); grid on;
    title('Linear Regression', 'FontWeight', 'bold', 'FontSize', 14);  
    xlabel('x', 'FontWeight', 'bold', 'FontSize', 14); 
    ylabel('t', 'FontWeight', 'bold', 'FontSize', 14); 
    legend({'tn', 'y', 'yhat'}, 'FontSize', 14);
    hold off;

%% ============== Linear Regression (With Regularization) =================

%Caluculate lambda from ln(lambda)
lambda = exp(lnLambda); 
I = eye(size(X'*X));

%Calculate closed form solution with regularization term: W = (inv(X'X)*X'*T + lambda*I)
W_Reg = ((X'*X)+(lambda*I))\(X'*T);

%compute the resulting polynomial from W_Reg
yhat_Reg = X*W_Reg;

%compute the error
EReg = 0.5*sum((yhat_Reg-T).^2)+(0.5*lambda*(W_Reg'*W_Reg));

figure(2)
    %Plot the data points
    scatter(x, T', 'b', 'LineWidth', 2); hold on
    
    %Plot the GroundTruth
    plot(x, Y', 'r', 'LineWidth', 2);
    
    %Plot the extimated polynomial
    plot(x, yhat_Reg', 'g', 'LineWidth', 2); axis([0, 14, -2, 2]);
    
    %Title, labels and legend
    set(gca,'FontWeight','bold','LineWidth',2); grid on;
    title('Linear Regression (with regularization)', 'FontWeight', 'bold', 'FontSize', 14); 
    xlabel('x', 'FontWeight', 'bold', 'FontSize', 14); 
    ylabel('t', 'FontWeight', 'bold', 'FontSize', 14);
    legend({'tn', 'y', 'yhatReg'}, 'FontSize', 14); 
    str = sprintf('ln \\lambda = %d', lnLambda);
    text(8, 1.6, str, 'FontSize', 14);
    hold off;

%% ==================== Maximum Likelihood Estimation =====================

%Calulate the precision(beta) obtained by maximizing the likelihood
%function 
beta = N/sum((yhat-T).^2);

%Calulate sigma 
sigma = (beta)^-0.5;
SigmaErr = ones(size(x))*sigma;

figure(3)
    %Plot the error area around
    h = shadedErrorBar(x, yhat, SigmaErr,{'m-','color','m','LineWidth',1},0); hold on
    
    %Plot the data points
    s = scatter(x, T', 'b', 'LineWidth', 2); axis([0, 14, -1.5, 1.5]);
    
    %Plot the GroundTruth
    p1 = plot(x, Y', 'r', 'LineWidth', 2);
    
    %Plot the extimated polynomial
    p2 = plot(x, yhat, 'g', 'LineWidth', 2); grid on;
    
    %Title, labels and legend
    set(gca,'FontWeight','bold','LineWidth',2)
    title('Maximum Likelihood', 'FontWeight', 'bold', 'FontSize', 14);
    xlabel('x', 'FontWeight', 'bold', 'FontSize', 14); 
    ylabel('t', 'FontWeight', 'bold', 'FontSize', 14);
    t = sprintf('\\sigma = %f', sigma);
    legend([s, p1, p2], {'tn', 'y', 'yhat'}, 'FontSize', 14);
    text(8.1, 1.1, t, 'FontSize', 14);
    hold off  

%% ======================= Maximum A Posteriori ===========================

%Assume beta=11.1 and alpha=0.005
beta_MAP = 11.1; alpha_MAP = 5e-03;

%Calculate the W using alpha and beta
W_MAP = ((X'*X)+((alpha_MAP/beta_MAP)*I))\(X'*T);

%Compute the resulting polynomial from W_MAP
yhat_MAP = X*W_MAP;

%Compute sigma
sigma_MAP = (beta_MAP)^-0.5;
SigmaErr_MAP = ones(size(x))*sigma_MAP;


figure(4)
    %Plot the error area around
    h = shadedErrorBar(x, yhat_MAP, SigmaErr_MAP,{'m-','color','m','LineWidth',1},0); hold on
    
    %Plot the data points
    s = scatter(x, T', 'b', 'LineWidth', 2); axis([0, 14, -2, 2]);
    
    %Plot the GroundTruth
    p1 = plot(x, Y', 'r', 'LineWidth', 2);
    
    %Plot the extimated polynomial
    p2 = plot(x, yhat_MAP, 'g', 'LineWidth', 2); grid on;
    
    %Title, labels and legend
    set(gca,'FontWeight','bold','LineWidth',2); grid on;
    title('Maximum A Posteriori', 'FontWeight', 'bold', 'FontSize', 14); 
    xlabel('x', 'FontWeight', 'bold', 'FontSize', 14); 
    ylabel('t', 'FontWeight', 'bold', 'FontSize', 14);
    legend([s, p1, p2], {'tn', 'y', 'yhat'}, 'FontSize', 14);
    str = sprintf('\\alpha = %.4f; \\beta = %.2f', alpha_MAP, beta_MAP);
    text(6, 1.1, str, 'FontSize', 14);
    hold off;
    
%% ============================= End ======================================