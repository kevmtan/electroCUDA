sbjs = ["S12_33_DA";"S12_34_TC";"S12_35_LM";"S12_36_SrS";"S12_38_LK";"S12_39_RT";...
    "S12_40_MJ";"S12_41_KS";"S12_42_NC";"S12_45_LR";"S13_46_JDB";"S13_47_JT2";...
    "S13_50_LGM";"S13_51_MTL";"S13_52_FVV";"S13_53_KS2";"S13_54_KDH";"S13_56_THS";...
    "S13_57_TVD";"S13_59_SRR";"S13_60_DY";"S14_62_JW";"S14_66_CZ";"S14_67_RH";...
    "S14_74_OD";"S14_75_TB";"S14_76_AA";"S14_78_RS";"S15_81_RM";"S15_82_JB";...
    "S15_83_RR";"S15_87_RL";"S16_95_JOB";"S16_96_LF"];
% ISSUES: s54

proj = "lbcn";
task = "MMR";
doSave = true;

statusDate = string(datetime('now','TimeZone','local','Format','yyMMdd_HHmm'));
statusFn = "/01/lbcn/logs/preproc/pre41_behav/"+statusDate;

status = table;
status.sbj = sbjs;
status.hz1000(:) = false;
status.hz100(:) = false;
status.error = cell(height(status),1);

try parpool('Processes'); catch; end


%% Subject loop
if doSave; diary(statusFn+".log"); diary on; end %#ok<*UNRCH>
parfor s = 1:height(status)
    % Slice status table
    stat = status(s,:);
    sbj = stat.sbj;
    o = struct;

    % No resampling (1000 hz)
    if ~stat.hz1000
        hz = 1000; 
        try
            o.suffix = "";
            [stat.error{1},o,n,chNfo,trialNfo,psy] = ec_initialize(sbj,proj,task,o,...
                save=doSave,saveN=doSave,hzTarget=hz,redoBeh=1);

            o.suffix = "i";
            [stat.error{1},o,n,chNfo,trialNfo,psy] = ec_initialize(sbj,proj,task,o,...
                saveN=doSave,hzTarget=hz);

            o.suffix = "z";
            [stat.error{1},o,n,chNfo,trialNfo,psy] = ec_initialize(sbj,proj,task,o,...
                saveN=doSave,hzTarget=hz);

            stat.hz1000 = true;
        catch ME
            stat.error{1} = ME;
            getReport(ME)
        end
    end

    % Resample (100 hz)
    if ~stat.hz100
        hz = 100;
        try
            o.suffix = "s";
            [stat.error{1},o,n,chNfo,trialNfo,psy] = ec_initialize(sbj,proj,task,o,...
                save=doSave,saveN=doSave,hzTarget=hz,redoBeh=1);

            o.suffix = "is";
            [stat.error{1},o,n,chNfo,trialNfo,psy] = ec_initialize(sbj,proj,task,o,...
                saveN=doSave,hzTarget=hz);

            stat.hz100 = true;
        catch ME
            stat.error{1} = ME;
            getReport(ME)
        end
    end
    status(s,:) = stat;
end
if doSave; save(statusFn+".mat","status"); diary off; end






