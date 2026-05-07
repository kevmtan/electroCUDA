% Initialize options struct
o = struct;
o.proj = "lbcn";
o.task = "MMR";
o.verbose = true;

%% Options
o.floatAnal = "double"; % Analysis at floating-point precision ["double"|"single"|"half"]
o.floatOut = "single"; % Save results at floating-point precision ["double"|"single"|"half"]
o.idxType = "double";
o.idxType2 = "double";
o.parallel = "none"; % 1-sample permute parallelization: ["none"|"gpu"|"cpu"] (cpu not worth it)
o.parallel2 = "cpu"; % Permute parallelization: ["none"|"gpu"|"cpu"] (cpu not worth it)
o.gather = "block"; % Gather data from GPU ["block"=each permute block|"final"=end of function]
o.stream = true;
o.ramAvail = ec_ramAvail(o.parallel=="gpu"); % Available memory in bytes
o.ramAvail2 = ec_ramAvail(o.parallel2=="gpu"); % Available memory in bytes
o.saveDF = false;

% ROI source dirs
o.roiDir = "ROIs"; % directory name within dirs.anal
o.roiName = "ep_zf"; % directory name within o.roiDir

% Analysis dirs
o.analDir = "condConROI"; % directory name within dirs.anal
o.analName = "xs_condCon_perm"; % directory name within o.analDir

% ROIs
o.ROIs = ["Visual" "TPJ" "PCC" "ATL" "amPFC" "dmPFC" "vmPFC"]; 

% Variables in observations table
o.condVar = "cnd";              % condition variable
o.grpVars = ["sbjCh" "tr"];   % group variables for 1-sample grouped/nested stats
o.grpVars2 = ["sbjCh" "run"];  % group variables for 2-sample grouped/nested stats

% Stats options
o.alpha = 0.05; % Critical p-value (default=0.05)
o.tail = "both"; % hypothesis tail
o.varType = "equal"; % ["equal"=standard t-test | "unequal"=Welch's t-test]
o.stableVar = true; % Stable variance calculation (false=fast but prone to cancellation with many obs)
o.ciMode = "approx";
o.nPerm = 5e2; % number of permutations
o.nBlocks = 0;
o.nBlocks2 = 0;
o.blockElMax = 0; % Max element count per permute block to limit RAM use (auto=0)
o.blockElMax2 = 0;
if o.parallel=="gpu"
    o.blockMemFrac = 0.2; % Fraction of available memory to use within permute blocks (for auto permBlockEl)
    o.blockMemFrac2 = 0.01; 
else
    o.blockMemFrac = 0.5;
    o.blockMemFrac2 = 0.025; 
end

% Multiple comparisons
o.maxCorrect = false; % max multiple comparison correction (false=do FDR instead)
o.fdrDep = "corr+"; % Dependence structure for FDR ["unknown"|"corr+"|"corr-"|"indep"]
o.fdrTimeRng = [0 inf]; % Range of times for FDR

% Stats contrast names (eg. cond1-cond0)
o.contrasts = [...
    "Other-Self"...
    "Episodic-Semantic"...
    "Mz-Autobio"...
    "Mz-Math"...
    "Autobio-Math"
    ]; % 
% Reference conditions - leave blank for cond vs. baseline
o.cond0 = {...
    "Self",...
    "Semantic",...
    ["Semantic" "Episodic"],...
    "Math",...
    "Math"
    }; 
% Comparison conditions
o.cond1 = {...
    "Other",...
    "Episodic",...
    ["Self" "Other"],...
    ["Self" "Other"],...
    ["Episodic" "Semantic"]
    };


%% Start parpool
try delete(gcp("nocreate")); catch;end
try parpool("local12"); catch;end


%% Run
st = ec_condConROI_perm(o);