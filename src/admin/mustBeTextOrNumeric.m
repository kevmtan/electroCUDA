function mustBeTextOrNumeric(input)
    if ~(istext(input) || isnumeric(input))
        error('Input must be text or numeric');
    end
end