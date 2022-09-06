function  functionOutput  = functionValue(functionHandle, functionInput )
%functionValue is function that takes functionHandle, and row vector and
%returns row vector 
%   Detailed explanation goes here
%% test is first parameter function handle
assert(isa(functionHandle,'function_handle'),'First parameter in function "functionValue" isn''t class of function_handle')
[rowInput, columnInput] = size(functionInput);
%% test if functionInput is row vector
assert((rowInput == 1 && columnInput > 0),'Secound parameter in function "functionValue isn''t row vector"') 
%% calculation
functionOutput = zeros(rowInput,columnInput);
for i=1:columnInput
    functionOutput(rowInput,i) = functionHandle(functionInput(rowInput,i)); 
end
end

