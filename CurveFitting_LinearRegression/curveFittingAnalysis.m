%% Curve Fitting/Linear Regression
%--------------------------------------------------------------------------
%  
% This scripts implements curve fitting for randomly generated data with
% guassian noise by
%
% Analysis for different order polynomials and regularizing factor values. 
%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Skanda Bharadwaj 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ========================================================================

clear; close all; clc;

%% ======================== Input generation ==============================

%Set the order of the polynomial
M = [1, 2, 3, 9];

%Set the regularization coefficient
lnLambda = [-10, -13, -15, -18, -20, -25];

%Load data points
dataPoints = {'data.mat', 'data50.mat', 'data100.mat'};

for p = 1:size(dataPoints, 2)
    %load data
    load(dataPoints{1, p})
    x=x'; Y=y'; T=t';
    N = length(x);
    
    W_all = zeros(10, 4);
    for j = 1:length(M)
        
        %Create the matrix X
        X = [ones(N, 1), zeros(N, M(j))];
        for i = 1:M(j)
            X(:, i+1) = x.^i;
        end
        
        %% =========== Linear Regression (Without Regularization) =============
        
        %compute the closed form solution: W = inv(X'X)*X'*T
        W = (X'*X)\(X'*T);
        if p==1
            w_all(:, j) = [W; zeros(10-length(W), 1)];
        end
        
        %compute the resulting polynomial from W
        yhat = X*W;
        
        %compute the error
        Err  = 0.5*sum((yhat-T).^2);
        
        if p == 1
            figure(1)
            subplot(2, 2, j)
            %Plot the data points
            scatter(x, T', 'b', 'LineWidth', 2); hold on
            %Plot the GroundTruth
            plot(x, Y', 'r', 'LineWidth', 2);
            %Plot the extimated polynomial
            plot(x, yhat', 'g', 'LineWidth', 2); axis([0, 14, -2, 2]);
            %Title, labels and legend
            set(gca,'FontWeight','bold','LineWidth',2); grid on;
            %title('Linear Regression', 'FontWeight', 'bold', 'FontSize', 14);
            xlabel('x', 'FontWeight', 'bold', 'FontSize', 14);
            ylabel('t', 'FontWeight', 'bold', 'FontSize', 14);
            legend({'tn', 'y', 'yhat'}, 'FontSize', 14);
            str = sprintf('M = %d', M(j));
            text(2, 1.6, str, 'FontSize', 14);
            hold off;
            
            suptitle('Linear Regression');
            if M(j)==9
                figure(2)
                subplot(2, 2, p)
                %Plot the data points
                scatter(x, T', 'b', 'LineWidth', 2); hold on
                %Plot the GroundTruth
                plot(x, Y', 'r', 'LineWidth', 2);
                %Plot the extimated polynomial
                plot(x, yhat', 'g', 'LineWidth', 2); axis([0, 14, -2, 2]);
                %Title, labels and legend
                set(gca,'FontWeight','bold','LineWidth',2); grid on;
                %title('Linear Regression', 'FontWeight', 'bold', 'FontSize', 14);
                xlabel('x', 'FontWeight', 'bold', 'FontSize', 14);
                ylabel('t', 'FontWeight', 'bold', 'FontSize', 14);
                legend({'tn', 'y', 'yhat'}, 'FontSize', 14);
                str = sprintf('N = %d', N);
                text(2, 1.6, str, 'FontSize', 14);
            end
            
        else
            if M(j) == 9
                figure(2)
                subplot(2, 2, p)
                %Plot the data points
                scatter(x, T', 'b', 'LineWidth', 2); hold on
                %Plot the GroundTruth
                plot(x, Y', 'r', 'LineWidth', 2);
                %Plot the extimated polynomial
                plot(x, yhat', 'g', 'LineWidth', 2); axis([0, 14, -2, 2]);
                %Title, labels and legend
                set(gca,'FontWeight','bold','LineWidth',2); grid on;
                %title('Linear Regression', 'FontWeight', 'bold', 'FontSize', 14);
                xlabel('x', 'FontWeight', 'bold', 'FontSize', 14);
                ylabel('t', 'FontWeight', 'bold', 'FontSize', 14);
                legend({'tn', 'y', 'yhat'}, 'FontSize', 14);
                str = sprintf('N = %d', N);
                text(2, 1.6, str, 'FontSize', 14);
            end
            suptitle('Polynomial of order M=9 for varying N')
        end
        
    end
end


%% =============== Linear Regression (With Regularization) ================

load data.mat
x=x'; Y=y'; T=t';
N = length(x);
X = [ones(N, 1), zeros(N, M(j))];
for i = 1:M(j)
    X(:, i+1) = x.^i;
end
    
for i = 1:size(lnLambda, 2)
    %Caluculate lambda from ln(lambda)
    lambda = exp(lnLambda(i)); 
    I = eye(size(X'*X));

    %Calculate closed form solution with regularization term: W = (inv(X'X)*X'*T + lambda*I)
    W_Reg = ((X'*X)+(lambda*I))\(X'*T);

    %compute the resulting polynomial from W_Reg
    yhat_Reg = X*W_Reg;

    %compute the error
    EReg = 0.5*sum((yhat_Reg-T).^2)+(0.5*lambda*(W_Reg'*W_Reg));
    Erms(i) = sqrt(2*EReg/N);
end

figure(3)
    plot(lnLambda, Erms, 'b', 'LineWidth', 2);
    set(gca,'FontWeight','bold','LineWidth',2); grid on;
    title('Variation of Erms with ln \lambda', 'FontWeight', 'bold', 'FontSize', 14); 
    xlabel('ln \lambda', 'FontWeight', 'bold', 'FontSize', 14); 
    ylabel('Erms', 'FontWeight', 'bold', 'FontSize', 14);
    hold off;
    
 lnLambdaAndErms = [lnLambda', Erms'];
 disp('Polynomial Coefficients for M=1, 2, 3 & 9 -')
 disp(w_all)
 disp('ln(lambda) & Erms - ')
 disp(lnLambdaAndErms);
 
%% ============================= End ======================================