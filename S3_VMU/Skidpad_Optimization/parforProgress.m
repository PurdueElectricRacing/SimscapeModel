% Tracks number of times the function has been called
% if there are any inputs, reset counter; otherwise increment counter and
% output it
function parforProgress(countStart, total)
    persistent iterCount iterTotal

    if nargin == 2
        iterCount = countStart;
        iterTotal = total;
    else
        iterCount = iterCount + 1;
        fprintf("iteration %d of %d\n", iterCount, iterTotal)
    end