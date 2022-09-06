clc
clear
%% Test script for class test
resultsClassTest = run(BisectionMethodClassTest)
percentPassed = 100 * nnz([resultsClassTest.Passed]) / numel(resultsClassTest);
disp([num2str(percentPassed), '% Passed.']);