function [column,conds] = getCondNames(project_name, hypothesis)

switch project_name
    
    case 'UCLA'
        switch hypothesis
            case {'math_memory', 'lock_type', 'full_model'}
                column = 'condNames';
                conds = {'math', 'episodic'};
            case 'cross_decade'
                column = 'decadeCross_str';
                conds = {'cross_decade', 'no_cross_decade'};
            case {'min_operand_mod', 'cross_decade_mod'}
                column = 'condNames';
                conds = {'math', 'autobio'};
            case 'correctness'
                column = 'correctness';
                conds = {'correct', 'incorrect'};
                
        end
        
    case 'MMR'
        switch hypothesis
            case {'math_memory', 'lock_type', 'full_model'}
                column = 'condNames';
                conds = {'math', 'autobio'};
            case 'cross_decade'
                column = 'decadeCross_str';
                conds = {'cross_decade', 'no_cross_decade'};
            case {'min_operand_mod', 'cross_decade_mod'}
                column = 'condNames';
                conds = {'math', 'autobio'};
            case 'correctness'
                column = 'correctness';
                conds = {'correct', 'incorrect'};
                
        end
        
    case 'MFA'
        switch hypothesis
            case 'format'
                column = 'math_type';
                conds = {'digit', 'word'};
            case 'operation_type'
                column = 'condNames';
                conds = {'digit_add', 'digit_mult'};
            case 'correctness'
                column = 'correctness';
                conds = {'correct', 'incorrect'};
                
        end
        
        
    case 'Memoria'
        switch hypothesis
            case {'math_memory', 'lock_type', 'full_model'}
                column = 'condNames';
                conds = {'math', 'autobio'};
                
            case 'correctness'
                column = 'correctness_str';
                conds = {'correct', 'incorrect'};
                
            case 'format'
                column = 'mathtype';
                conds = {'digit', 'numword'};
                
            case 'cross_decade'
                column = 'decadeCross_str';
                conds = {'cross_decade', 'no_cross_decade'};
                
            case {'min_operand_mod', 'cross_decade_mod'}
                column = 'condNames';
                conds = {'math', 'autobio'};
                
            case {'operand_2_mod', 'correctness_mod', 'sl_ls_mod', 'format_mod', 'abs_deviant_mod'}
                column = 'condNames';
                conds = {'math', 'autobio'};
                
                
        end
        
        
    case 'Calculia'
        switch hypothesis
            case 'format'
                column = 'condNames_lite';
                conds = {'digit_active', 'letter_active'};
                
            case 'correctness'
                column = 'correctness_simple';
                conds = {'digit_correct', 'digit_incorrect'};
                
        end
        
    case 'Context'
        switch hypothesis
            
            case 'correctness'
                column = 'correctness_basic';
                conds = {'correct_active', 'incorrect_active'};
                
            case 'format'
                column = 'condNames';
                conds = {'numerals_active', 'numword_active'};
                
            case 'activeness'
                column = 'condNamesBasic';
                conds = {'active', 'passive'};                
        end
        
        
    case 'VTCLoc'
        switch hypothesis
            case 'digit_other'
                column = 'condNames_numbers';
                conds = {'numbers', 'other'};
            case 'face_other'
                column = 'condNames_faces';
                conds = {'faces', 'other'};
            case 'word_other'
                column = 'condNames_words';
                conds = {'words', 'other'};
                
        end
    case 'ReadNumWord'
        switch hypothesis
            case 'digit_other'
                column = 'condNames_number';
                conds = {'numbers', 'other'};
            case 'word_other'
                column = 'condNames_words';
                conds = {'words', 'other'};
                
        end
        
        
        
        
        
    case 'AllCateg'
        
        
    case 'Logo'
        
        
    case 'Scrambled'
        
        
    otherwise
        error('you must specify a valid project name')
end

