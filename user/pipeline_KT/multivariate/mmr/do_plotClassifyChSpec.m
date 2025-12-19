% Log filename
fnLog = "/01/lbcn/anal/classifyChSpec/MzAb_regLDA_ch_251217/log_251217_0732.mat";

% Plot options
op.visible = false; % !!!!!!!!!!
op.save = true; % !!!!!!!!!!!
op.res = [810 1080];
op.posVar = "pialRAS"; % position variable in chNfo table (should match surfType)
op.surfType = "pial"; % surface type (freesurfer naming convention) ["pial_avg"|"inflated_avg"]
op.pullF = 15; % Pull factor, view elecs closer to camera (default=15)
op.alpha = 0.95; % cortex opacity
op.marker = "o"; % marker type (see Matlab marker symbols)
op.nsMark = "o"; % marker type for nonsignificant chans (see Matlab marker symbols)
op.markSz = 9; % marker size for significant chans;
op.nsSz = 3; % marker size for nonsignificant chans;
op.bSz = 0; % marker border size
op.cmap = "RdBu"; % colormap (see ec_colorsFromValues)
op.markCol = [1 0 0];
op.nsCol = [0 0 0]; % marker color for nonsignificant chans: [R G B]
op.bCol = [0 0 0]; % marker border color: [R G B]
op.txtCol = [.8 .8 .8]; % Text color: [R G B]
op.txtSz = 10; % text size
op.clim = [-4 4];
op.climICA = [];
op.climICA_z = [-6 6];
op.align = true; % align vertex centers
op.o1D = ecu_genPlotParams("ERP","MMR");
op.o1D.style= ':';
op.o1D.width = 0.5;
op.o1D.wSig = 1;
op.o1D.edgestyle = ':';
op.o1D.col = orderedcolors("gem");
op.o1D.col = ec_dim2cell(op.o1D.col,1);
% for c = 1:numel(o.conds)
%     op.o1D.col{c} = op.col(c,:);
% end


%% Load logs
load(fnLog,"logs")


%% Create parallel pool (must be processes, can't be threadpool)
%try delete(gcp("nocreate")); catch;end
try ppool = parpool("local12"); catch;end


%% Loop across subjects & channel type
for p = 1 %1:2 % Switch EEG data: channels (1) or independent components (2)
    for s = 1:height(logs.i{p})
        if logs.i{p}.class(s) %&& ~logs.i{p}.plot(s)
            disp("STARTING: "+logs.i{p}.sbj(s));
            o = logs.i{p}.o{s};

            %% Do subject
            try
                mmr_cChSpecPlot(o,op);
                logs.i{p}.plot(s) = true;
            catch ME; getReport(ME)
                logs.i{p}.error{s} = ME;
                logs.i{p}.plot(s) = false;
            end

            %% Save logs
            logs.i{p}.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(logs.fn(p),'logs','-v7');
        end
    end
end