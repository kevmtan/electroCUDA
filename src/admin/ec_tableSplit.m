function T = ec_tableSplit(T,var,o)
arguments
    T table
    var string
    o.sorted {mustBeMember(o.sorted,["sorted" "stable"])} = "stable"
end

groups = unique(T.(var),o.sorted);

T = arrayfun(@(g) T(T.(var)==g,:),groups,UniformOutput=false);
T = cell2table(T,"RowNames",groups,"VariableNames",var);
