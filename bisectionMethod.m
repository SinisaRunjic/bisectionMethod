function c = bisectionMethod(fun, startInterval, endInterval, acceptedSolutionDifference)
%BisectionMethod is method to find x where is fun(x) = 0 
%   fun needs to be a string that have variable x
%   startInterval needs to be real number
%   endInterval needs to be real number
%   acceptedSolutionDifference needs to be real number
    %% test if fun is string
    assert(~isstring(fun),'Fist parameter isn''t string please provide function as string');
    %% test if fun is empty string
    [rowFun, ~] = size(fun);
    assert(rowFun ~= 0,'Fun parameters is empty. Please provide string that has function');
    clear rowFun;
    %% test intervals are they numeric
    assert(isnumeric(startInterval), 'Start of interval isn''t numeric')
    assert(isnumeric(endInterval), 'End of interval isn''t numeric')
    assert(isnumeric(acceptedSolutionDifference), 'Accepted solution difference is not numeric')
    %% test intervals are they not complex
    assert(isreal(startInterval), 'Start interval is complex number. Please provide real number')
    assert(isreal(endInterval), 'End of interval is complex number. Plesae provide real number')
    assert(isreal(acceptedSolutionDifference), 'Accepted solution difference is complex number. Please provide real number')
    %% test if they aren't scalars
    [rowStartInterval, columnStartInterval] = size(startInterval);
    assert(rowStartInterval == 1 && columnStartInterval == 1, 'Start interval isn''t scalar')
    clear rowStartInterval columnStartInterval;
    [rowEndInterval, columnEndInterval] = size(endInterval);
    assert(rowEndInterval == 1 && columnEndInterval == 1, 'End interval isn''t scalar')
    clear rowEndInterval columnEndInterval;
    [rowAcceptedSolutionDifference, columnAcceptedSolutionDifference] = size(acceptedSolutionDifference);
    assert(rowAcceptedSolutionDifference == 1 && columnAcceptedSolutionDifference == 1, 'Accepted solution difference isn''t scalar')
    clear rowAcceptedSolutionDifference columnAcceptedSolutionDifference;
    %% test if interval is good 
    assert(startInterval<endInterval, 'Start interval is larger than end interval')
    f = str2func(['@(x)',fun]);
    try
           f(startInterval);
    catch
        error('Please provide only "x" as variable')
    end
    assert(~(f(startInterval)*f(endInterval)>0), 'Change interval, function have same sign at start and end of interval');
    %% calculation
    c = (startInterval + endInterval) /2;
    while abs(f(c))>acceptedSolutionDifference && f(c) ~= 0
        if(f(startInterval)<0 && f(endInterval)>0)
            if(f(c)>=0);
                endInterval = c;
            else
                startInterval = c;
            end
        else
            if(f(c)<=0);
                endInterval = c;
            else
                startInterval = c;
            end
        end
        c = (startInterval + endInterval) /2;
    end
end