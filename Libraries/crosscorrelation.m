function value = crosscorrelation(data1, data2)
%
%   Function for crosscorrelating data sets for use in signals analysis for
%   data collected by the array. data1 must be larger than data2 for the
%   zero padding to work properly.
%
%   Sam Kramer
%   July 14th, 2023
%

if height(data1) && height(data2) ~= 1
    %{
        Checks to see if data is in row vectors and if not will change them
        to row vectors.
    %}

    data1 = data1';
    data2 = data2';

end

% --Function Setup
    N = length(data1);
    M = length(data2);
    value = [];
    append = zeros(1, N - M);
    data2 = [data2 append];
    
%--For loop
    for tau = 1:N-1
        
        % --Calculate Rxy at that tau
        Rxy = mean(data1(tau:N) * data2(1:N - (tau-1))');
        value = [value Rxy];
        
    end % loop end

end % Function end