% Redo findBadFrames on original suffix & copy to other suffixes
sbjs = ["S12_33_DA";"S12_34_TC";"S12_35_LM";"S12_36_SrS";"S12_38_LK";"S12_39_RT";...
    "S12_40_MJ";"S12_41_KS";"S12_42_NC";"S12_45_LR";"S13_46_JDB";"S13_47_JT2";...
    "S13_50_LGM";"S13_51_MTL";"S13_52_FVV";"S13_53_KS2";"S13_54_KDH";"S13_56_THS";...
    "S13_57_TVD";"S13_59_SRR";"S13_60_DY";"S14_62_JW";"S14_66_CZ";"S14_67_RH";...
    "S14_74_OD";"S14_75_TB";"S14_76_AA";"S14_78_RS";"S15_81_RM";"S15_82_JB";...
    "S15_83_RR";"S15_87_RL";"S16_95_JOB";"S16_96_LF"];
proj = "lbcn";
task = "MMR";
%load("parcellationIdx.mat","atlaz");


%% Options
o.sfx_src = "";
o.sfx_copy = ["s" "f"];
o.thrMAD = 10; % z-threshold relative to all data points to exclude timepoints (default=5)
o.thrDiff = 10; % z-threshold for amplitude difference of consecutive timepoints (default=5)
o.thrSNS = 3; % Threshold for low-freq spikes; Sensor-specific noise thresh (try 5)
o.thrFlat = 0.01; % max |Δz| for flat-segment detection in ec_findBadFrames (0=off; try 0.0001)


%%
% try delete(gcp("nocreate")); catch;end
% try ppool = parpool("local6"); catch;end


%% Run sbjs
parfor s = 1:numel(sbjs)
    try
        findBadFrames_lfn(sbjs(s),proj,task,o);
    catch ME
        disp(ME);
    end
end







%% Main function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function chNfo = findBadFrames_lfn(sbj,proj,task,o)
try
    [n,x,chNfo,dirs] = ec_loadSbj(sbj=sbj,proj=proj,task=task,sfx="",...
        vars=["n" "x" "chNfo"]);
catch ME
    chNfo = [];
    disp(ME);
    return
end

% Start time
tt = tic;

% Filename string
fnStr = "s"+dirs.sbjID+"_"+task;


%% findBadFrames
[chBad,xBad] = ec_findBadFrames(x,chNfo.bad,mad=o.thrMAD,diff=o.thrDiff,...
    flat=o.thrFlat,sns=o.thrSNS);
disp("Identified bad frames per ch: "+sbj); toc(tt);

% Move vars
chBad = movevars(chBad,["flat" "flatP"],Before="sns");

% Copy to chNfo
chNfo.bad = chBad;

% Copy to n struct
n.chBad = chBad;
n.xBad = xBad;


%% Save orig suffix

% Save chNfo
fn = dirs.procSbj+"chNfo_"+fnStr;
save(fn,"chNfo","-v7"); disp("SAVED: "+fn)
% Save n struct
fn = dirs.procSbj+"n"+n.suffix+"_"+fnStr;
save(fn,"n","-v7"); disp("SAVED: "+fn);


%% Figure out resampling bad frames
warning("Figure out resampling bad frames before copying)");
return;

%% Copy & save to other suffixes
for sfx = o.sfx_copy
    % Load
    [n,dirs] = ec_loadSbj(sbj=sbj,proj=proj,task=task,sfx=sfx,...
        vars="n");

    % Copy to n struct
    n.chBad = chBad;
    n.xBad = xBad;

    % Save n struct
    fn = dirs.procSbj+"n"+sfx+"_"+fnStr;
    save(fn,"n","-v7"); disp("SAVED: "+fn); toc(tt);
end
end


