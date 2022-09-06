classdef BisectionMethodClassTest < matlab.unittest.TestCase
    %BisectionMethodClassTest is test class function to test bisectionMethod function
    properties (TestParameter) %% parameters that will be used in test methods
        %% functions
        parameters = struct('parameter1',struct('function','sin(x)*x -0.5','startInterval',-2,'endInterval',0,'precision',10^(-9))); 
        solutions = struct('solution1',-0.740840955095491); %% solutin has been taken from wolfram alpha
        %% variables design to verify errors
        parametersFunctionValueSameSignOfStartAndEndInterval = struct('parameter1',struct('function','sin(x)*x -0.5','startInterval',-2,'endInterval',-1,'precision',10^(-9))); 
        parametersEmptyFunction = struct('parameter1',struct('function','','startInterval',-2,'endInterval',0,'precision',10^(-9))); 
        parametersStringStartInterval = struct('parameter1',struct('function','sin(x)*x -0.5','startInterval','-2','endInterval',0,'precision',10^(-9))); 
        parametersStringEndInterval = struct('parameter1',struct('function','sin(x)*x -0.5','startInterval',-2,'endInterval','0','precision',10^(-9))); 
        parametersStringPrecision = struct('parameter1',struct('function','sin(x)*x -0.5','startInterval',-2,'endInterval',0,'precision','10^(-9)')); 
        parametersCellFunction = struct('parameter1',struct('function',{{'sin(x)*x -0.5'}},'startInterval',-2,'endInterval',0,'precision',10^(-9))); 
        parametersCellStartInterval = struct('parameter1',struct('function','sin(x)*x -0.5','startInterval',{{-2}},'endInterval',0,'precision',10^(-9))); 
        parametersCellEndInterval = struct('parameter1',struct('function','sin(x)*x -0.5','startInterval',-2,'endInterval',{{0}},'precision',10^(-9))); 
        parametersCellPrecision = struct('parameter1',struct('function','sin(x)*x -0.5','startInterval',-2,'endInterval',0,'precision',{{10^(-9)}})); 
        parametersVectorFunction = struct('parameter1',struct('function',['sin(x)*x -0.5', '+ 8'],'startInterval',-2,'endInterval',0,'precision',10^(-9))); 
        parametersVectorStartInterval = struct('parameter1',struct('function','sin(x)*x -0.5','startInterval',[-2 0.4],'endInterval',0,'precision',10^(-9))); 
        parametersVectorEndInterval = struct('parameter1',struct('function','sin(x)*x -0.5','startInterval',-2,'endInterval',[-2 0],'precision',10^(-9))); 
        parametersVectorPrecision = struct('parameter1',struct('function','sin(x)*x -0.5','startInterval',-2,'endInterval',0,'precision',[10^(-9), 10^(-10)])); 
        parametersComplexNumbersStartInterval = struct('parameter1',struct('function','sin(x)*x -0.5','startInterval',-2+2i,'endInterval',0,'precision',10^(-9)));
        parametersComplexNumbersEndInterval = struct('parameter1',struct('function','sin(x)*x -0.5','startInterval',-2,'endInterval',0+5i,'precision',10^(-9)));
        parametersComplexNumbersPrecision = struct('parameter1',struct('function','sin(x)*x -0.5','startInterval',-2+2i,'endInterval',0,'precision',(1+1i).*10^(-9)));
    end
    properties
       calculationError  
    end
    methods(TestClassSetup) %% runs when test class is about to close
        function setupOnce(testCase)
            format long
            testCase.calculationError = 10^(-7);
        end
    end
    methods(TestClassTeardown) %% runs when test class is about to close
        function teardownOnce(testCase)
            format short
        end
    end
    methods (Test, ParameterCombination = 'sequential')
%         %% test values
         function testInverseSquareMatrix(testCase, parameters,solutions )
            actualSolution = bisectionMethod(parameters.function,parameters.startInterval,parameters.endInterval, parameters.precision);
            expectedSolution = solutions;
            verifyLessThan(testCase,abs(actualSolution-expectedSolution), testCase.calculationError, 'Calculating funciton zero is wrong')
         end
    end
        methods (Test)
         %% test for errors
         function testBisectionMethodFunctionSameSignStartAndEndInterval(testCase, parametersFunctionValueSameSignOfStartAndEndInterval)
             verifyError(testCase,@() bisectionMethod(parametersFunctionValueSameSignOfStartAndEndInterval.function,parametersFunctionValueSameSignOfStartAndEndInterval.startInterval,parametersFunctionValueSameSignOfStartAndEndInterval.endInterval, parametersFunctionValueSameSignOfStartAndEndInterval.precision),?MException, 'Can''t calculate bisectionMethod of empty function')
        end
        function testBisectionMethodWithEmptyFunctionString(testCase, parametersEmptyFunction)
             verifyError(testCase,@() bisectionMethod(parametersEmptyFunction.function,parametersEmptyFunction.startInterval,parametersEmptyFunction.endInterval, parametersEmptyFunction.precision),?MException, 'Can''t calculate bisectionMethod of empty function')
        end
        function testBisectionMethodWithStartIntervalString(testCase, parametersStringStartInterval)
             verifyError(testCase,@() bisectionMethod(parametersStringStartInterval.function,parametersStringStartInterval.startInterval,parametersStringStartInterval.endInterval, parametersStringStartInterval.precision),?MException, 'Can''t calculate bisectionMethod if start interval is string')
        end
        function testBisectionMethodWithEndIntervalString(testCase, parametersStringEndInterval)
             verifyError(testCase,@() bisectionMethod(parametersStringEndInterval.function,parametersStringEndInterval.startInterval,parametersStringEndInterval.endInterval, parametersStringEndInterval.precision),?MException, 'Can''t calculate bisectionMethod if end interval is string')
        end
        function testBisectionMethodWithPrecisionString(testCase, parametersStringPrecision)
             verifyError(testCase,@() bisectionMethod(parametersStringPrecision.function,parametersStringPrecision.startInterval,parametersStringPrecision.endInterval, parametersStringPrecision.precision),?MException, 'Can''t calculate bisectionMethod if end interval is string')
        end
        function testBisectionMethodWithFunctionCell(testCase, parametersCellFunction)
             verifyError(testCase,@() bisectionMethod(parametersCellFunction.function,parametersCellFunction.startInterval,parametersCellFunction.endInterval, parametersCellFunction.precision),?MException, 'Can''t calculate bisectionMethod if function is cell')
        end
        function testBisectionMethodWithStartIntervalCell(testCase, parametersCellStartInterval)
             verifyError(testCase,@() bisectionMethod(parametersCellStartInterval.function,parametersCellStartInterval.startInterval,parametersCellStartInterval.endInterval, parametersCellStartInterval.precision),?MException, 'Can''t calculate bisectionMethod if start interval is cell')
        end
        function testBisectionMethodWithEndIntervalCell(testCase, parametersCellEndInterval)
             verifyError(testCase,@() bisectionMethod(parametersCellEndInterval.function,parametersCellEndInterval.startInterval,parametersCellEndInterval.endInterval, parametersCellEndInterval.precision),?MException, 'Can''t calculate bisectionMethod if end interval is cell')
        end
        function testBisectionMethodWithPrecisionCell(testCase, parametersCellPrecision)
             verifyError(testCase,@() bisectionMethod(parametersCellPrecision.function,parametersCellPrecision.startInterval,parametersCellPrecision.endInterval, parametersCellPrecision.precision),?MException, 'Can''t calculate bisectionMethod if solution difference is cell')
        end
        function testBisectionMethodWithFunctionVectorRow(testCase, parametersVectorFunction)
             verifyError(testCase,@() bisectionMethod(parametersVectorFunction.function,parametersVectorFunction.startInterval,parametersVectorFunction.endInterval, parametersVectorFunction.precision),?MException, 'Can''t calculate bisectionMethod if function is row vector')
        end
        function testBisectionMethodWithStartIntervalVectorRow(testCase, parametersVectorStartInterval)
             verifyError(testCase,@() bisectionMethod(parametersVectorStartInterval.function,parametersVectorStartInterval.startInterval,parametersVectorStartInterval.endInterval, parametersVectorStartInterval.precision),?MException, 'Can''t calculate bisectionMethod if start interval is row vector')
        end
        function testBisectionMethodWithEndIntervalVectorRow(testCase, parametersVectorEndInterval)
             verifyError(testCase,@() bisectionMethod(parametersVectorEndInterval.function,parametersVectorEndInterval.startInterval,parametersVectorEndInterval.endInterval, parametersVectorEndInterval.precision),?MException, 'Can''t calculate bisectionMethod if end interval is row vector')
        end
        function testBisectionMethodWithPrecisionVectorRow(testCase, parametersVectorPrecision)
             verifyError(testCase,@() bisectionMethod(parametersVectorPrecision.function,parametersVectorPrecision.startInterval,parametersVectorPrecision.endInterval, parametersVectorPrecision.precision),?MException, 'Can''t calculate bisectionMethod if solution difference is row vector')
        end
        function testBisectionMethodWithFunctionVectorColumn(testCase, parametersVectorFunction)
             verifyError(testCase,@() bisectionMethod(parametersVectorFunction.function.',parametersVectorFunction.startInterval,parametersVectorFunction.endInterval, parametersVectorFunction.precision),?MException, 'Can''t calculate bisectionMethod if function is row vector')
        end
        function testBisectionMethodWithStartIntervalVectorColumn(testCase, parametersVectorStartInterval)
             verifyError(testCase,@() bisectionMethod(parametersVectorStartInterval.function,parametersVectorStartInterval.startInterval.',parametersVectorStartInterval.endInterval, parametersVectorStartInterval.precision),?MException, 'Can''t calculate bisectionMethod if start interval is row vector')
        end
        function testBisectionMethodWithEndIntervalVectorColumn(testCase, parametersVectorEndInterval)
             verifyError(testCase,@() bisectionMethod(parametersVectorEndInterval.function,parametersVectorEndInterval.startInterval,parametersVectorEndInterval.endInterval.', parametersVectorEndInterval.precision),?MException, 'Can''t calculate bisectionMethod if end interval is row vector')
        end
        function testBisectionMethodWithPrecisionVectorColumn(testCase, parametersVectorPrecision)
             verifyError(testCase,@() bisectionMethod(parametersVectorPrecision.function,parametersVectorPrecision.startInterval,parametersVectorPrecision.endInterval, parametersVectorPrecision.precision.'),?MException, 'Can''t calculate bisectionMethod if solution difference is row vector')
        end
        function testBisectionMethodWithStartIntervalComplexNumber(testCase, parametersComplexNumbersStartInterval)
             verifyError(testCase,@() bisectionMethod(parametersComplexNumbersStartInterval.function,parametersComplexNumbersStartInterval.startInterval,parametersComplexNumbersStartInterval.endInterval, parametersComplexNumbersStartInterval.precision.'),?MException, 'Can''t calculate bisectionMethod if solution difference is row vector')
        end
        function testBisectionMethodWithEndIntervalComplexNumber(testCase, parametersComplexNumbersEndInterval)
             verifyError(testCase,@() bisectionMethod(parametersComplexNumbersEndInterval.function,parametersComplexNumbersEndInterval.startInterval,parametersComplexNumbersEndInterval.endInterval, parametersComplexNumbersEndInterval.precision.'),?MException, 'Can''t calculate bisectionMethod if solution difference is row vector')
        end
        function testBisectionMethodWithPrecisionComplexNumber(testCase, parametersComplexNumbersPrecision)
             verifyError(testCase,@() bisectionMethod(parametersComplexNumbersPrecision.function,parametersComplexNumbersPrecision.startInterval,parametersComplexNumbersPrecision.endInterval, parametersComplexNumbersPrecision.precision.'),?MException, 'Can''t calculate bisectionMethod if solution difference is row vector')
        end
    end
end