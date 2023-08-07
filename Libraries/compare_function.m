function new_ind = compare_function(vector1,vector2,threshold)
%
%   This is a function that is used to compare the time indeces of the
%   peaks for a single dataset vector. It will eliminate any repeated
%   values and will also eliminate any values that are within a certain
%   threshold of eachother. Will return a new vector as new_ind.
%
%   Inputs:
%           vector1::AbsVec =   First vector dataset you would like to
%                               compare. Must be a column vector.
%           vector2::AbsVec =   Second vector dataset you would like to
%                               compare.
%           threshold::Float =  This is the difference threshold criteria
%                               you establish to eliminate two values and 
%                               combine them to a single value. 
%
%   Ouputs:
%           new_ind::AbsVec =   This is a new vector with a compared
%                               dataset that keeps the unique values.
%
%

% --Setup
    indeces = [vector1; vector2];
    new_ind = [indeces(1)];

% --Loop through entire ind array set
    for i = 2:length(indeces)
    
        % --Setup loop
            okay = "true";
            IIQ = indeces(i); 

        % --Check across previous values in new_ind
            k = 1;
            while k <= length(new_ind)

                % --Check difference
                    diff_ind = abs(new_ind(k) - IIQ);

                % --If difference enough, continue loop
                    if diff_ind >= threshold      
                        k = k + 1;
                    else
                        okay = "false";
                        break
                    end
            end

        % --Save value into new indeces
            if okay == "true"
                new_ind = [new_ind; IIQ];
            end
    end
end