% Run analyses on resuls of classifyChSpec

% Log filename
fnLog = "/01/lbcn/anal/classifyChSpec/MzAb_regLDA_ch_251217/log_251217_0732.mat";

% Load logs
load(fnLog,"logs")
%logs.i{1}.post(:) = false;
%logs.i{1} = movevars(logs.i{1},"post","After","class");


%% Loop across subjects & channel type
for p = 1 %1:2 % Switch EEG data: channels (1) or independent components (2)
    for s = 1:height(logs.i{p})
        if logs.i{p}.class(s) && ~logs.i{p}.post(s)
            disp("STARTING: "+logs.i{p}.sbj(s));
            o = logs.i{p}.o{s};

            %% Do subject
            try
                mmr_cChSpecPost(o);
                logs.i{p}.post(s) = true;
            catch ME; getReport(ME)
                logs.i{p}.error{s} = ME;
                logs.i{p}.post(s) = false;
            end

            %% Save logs
            logs.i{p}.time(s) = datetime('now','TimeZone','local','Format','yyMMdd_HHmm');
            save(logs.fn(p),'logs','-v7');
        end
    end
end