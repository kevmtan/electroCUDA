function runs = contiguousKT(A,varargin)
%   RUNS = CONTIGUOUS(A,NUM) returns the start and stop indices for contiguous
%   runs of the elements NUM within vector A.  A and NUM can be vectors of
%   integers or characters.  Output RUNS is a 2-column cell array where the ith
%   row of the first column contains the ith value from vector NUM and the ith
%   row of the second column contains a matrix of start and stop indices for runs
%   of the ith value from vector NUM.    These matrices have the following form:
%
%   [startRun1  stopRun1]
%   [startRun2  stopRun2]
%   [   ...        ...  ]
%   [startRunN  stopRunN]
%
%   Example:  Find the runs of '0' and '2' in vector A, where
%             A = [0 0 0 1 1 2 2 2 0 2 2 1 0 0];
%
%   runs = contiguous(A,[0 2])
%   runs =
%           [0]    [3x2 double]
%           [2]    [2x2 double]
%
%   The start/stop indices for the runs of '0' are given by runs{1,2}:
%
%           1     3
%           9     9
%          13    14
%
%   RUNS = CONTIGUOUS(A) with only one input returns the start and stop
%   indices for runs of all unique elements contained in A.
%
%   CONTIGUOUS is intended for use with vectors of integers or characters, and
%   is probably not appropriate for floating point values.  You decide.
%

if numel(A) ~= length(A)
    error('A must be a vector.')
end

if isempty(varargin)
    num = unique(A);
else
    num = varargin{1};
    if numel(num) ~= length(num)
        error('NUM must be a scalar or vector.')
    end
end

nFind = length(num);

runs = table;
if nFind > 1
    runs.find = num;
    runs.nClust(:) = nan;
    runs.C{:} = [];
else
    runs.find = num;
    runs.sz = 0;
    runs.idx = [nan,nan];
end

for r = 1:nFind
    indexVect = find(A(:) == num(r));
    if nnz(indexVect)
        shiftVect = [indexVect(2:end);indexVect(end)];
        diffVect = shiftVect - indexVect;

        % The location of a non-one is the last element of the run:
        transitions = (find(diffVect ~= 1));

        clustEnd = indexVect(transitions);
        clustStart = [indexVect(1);indexVect(transitions(1:end-1)+1)];
        clust = [clustStart clustEnd];

        C = table;

        C.find(1:length(clustStart)) = num(r);
        C.sz = diff(clust,1,2)+1;
        C.idx = clust;


        if nFind > 1
            runs.nClust(r) = length(clustStart);
            runs.C{r} = C;
        else
            runs = C;
        end
    else
        if nFind > 1
            runs.nClust(r) = 0;
        end
    end
end
