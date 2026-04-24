load("/01/lbcn/anal/classifySpecCh/MzAb_LDA_pcaTune_260422_0604/log_260422_0604.mat")

% Colors
load("cdcol_2018.mat","cdcol");

op = struct;


%% Options
op.visible = false; % !!!!!!!!!!
op.save = true; % !!!!!!!!!!!
op.sigThr = 0.05; % significance threshold

% Plot
op.res = [1440 720];
op.txtCol = [0 0 0]; % Text color: [R G B]
op.txtSz = 10; % text size
op.txtSzTitle = 12;
op.txtSzAx = 8;

% Cortex opts
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
op.align = true; % align vertex centers

% Accuracy
op.a = struct;
op.a.style= ':';
op.a.edgestyle = ':';
op.a.width = 0.5;
op.a.wSig = 2;
op.a.col = cdcol.spruce_green;
op.a.col = ec_dim2cell(op.a.col,1);

% PP per cond
op.c = op.a;
op.c.col = [cdcol.prussian_blue; cdcol.mauve; cdcol.pastel_blue; 0 0.75 0];
op.c.col = ec_dim2cell(op.c.col,1);

% PP cond difference
op.d = op.c;
op.d.col = [cdcol.violet; cdcol.greenish_blue];
op.d.col = ec_dim2cell(op.d.col,1);

% PP RT/RC/valence
op.r = op.c;
op.r.col = [cdcol.indian_red; cdcol.orange; cdcol.peacock_green];
op.r.col = ec_dim2cell(op.r.col,1);


%% Create parallel pool (must be processes, can't be threadpool)
%try delete(gcp("nocreate")); catch;end
try ppool = parpool("local12"); catch;end


%% Loop across subjects & channel type
for s = 1:height(logs)
    if logs.class(s) %&& ~logs.plot(s)
        disp("STARTING: "+logs.sbj(s));
        n = logs.n{s};
        o = logs.o{s};

        %% Do subject
        try
            mmr_cSpecPlot_ch(n,o,op);
            logs.plot(s) = true;
        catch ME; getReport(ME)
            logs.error{s} = ME;
            logs.plot(s) = false;
        end

        %% Save logs
        logs.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
        save(logs.fn(s),'logs','-v7.3');
    end
end