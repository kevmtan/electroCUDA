function od = ecu_genPlotParams(plotType,task,od)
arguments
    plotType string {mustBeMember(plotType,["ERP" "ERFP" "ERSP" "ITPC" ""])}
    task string = ""
    od struct = struct
end

%% Prep
load ("cdcol_2018.mat","cdcol");

%% Plot Type
switch plotType
    case "ERP"
        od.textsize = 8;
        od.xlabel = "Latency (ms)";
        od.ylabel = "Amplitude (z-score)";
    case "ERFP"
        od.textsize = 8;
        od.xlabel = "Latency (ms)";
        od.ylabel = "Magnitude (z-score)";
    case "ERSP"
        od.textsize = 14;
        od.cmap = flip(ec_cbrewer2("RdBu"));
        od.clim = [-4 4];
        od.xlabel = "Latency (ms)";
        od.ylabel = "Frequency (Hz)";
    case "ITPC"
        od.textsize = 16;
        od.cmap = parula; % cbrewer2("RdYlBu")(end:-1:1,:);
        od.clim = [0 0.4];
        od.xlabel = "Latency (ms)";
        od.ylabel = "Frequency (Hz)";
end

%% Task
switch task
    case "MMR"
        od.xlim = [-0.2 3];
        od.bl_win = [-0.2 0];
        od.col =...
            [0 0.75 0;
            cdcol.pastel_blue;
            cdcol.prussian_blue;
            cdcol.mauve;
            cdcol.light_cadmium_red;
            cdcol.yellow;];
    case "UCLA"
        od.xlim = [-0.2 3];
        od.bl_win = [-0.2 0];
        od.col = [cdcol.ultramarine;
            cdcol.grass_green;
            cdcol.lilac;
            cdcol.yellow;
            cdcol.turquoise_blue;
            cdcol.flame_red;
            cdcol.pink;
            cdcol.carmine
            cdcol.apricot];
    case "Calculia_production"
        od.xlim = [-0.2 4];
        od.bl_win = [-0.2 0];
    case "Memoria"
        od.xlim = [-0.2 8.5];
        od.bl_win = [-0.2 0];
    case "Calculia"
        od.xlim = [-0.2 6];
        od.bl_win = [-0.2 0];
        od.col = [cdcol.carmine;
            cdcol.pink;
            cdcol.ultramarine;
            cdcol.turquoise_blue;
            cdcol.flame_red;
            cdcol.periwinkle_blue;
            cdcol.pink;
            cdcol.purple];
    case "Context"
        od.xlim = [-0.2 6];
        od.bl_win = [-0.2 0];
        od.col = [cdcol.carmine;
            cdcol.pink;
            cdcol.ultramarine;
            cdcol.turquoise_blue;
            cdcol.periwinkle_blue;
            cdcol.pink;
            cdcol.purple];
    case "Calculia_China"
        od.xlim = [-0.2 7];
        od.bl_win = [-0.2 0];
        od.col = [cdcol.ultramarine;
            cdcol.grass_green;
            cdcol.lilac;
            cdcol.yellow;
            cdcol.turquoise_blue;
            cdcol.flame_red;
            cdcol.periwinkle_blue;
            cdcol.pink;
            cdcol.purple];
    case "GradCPT"
        od.xlim = [-0.5 1.6];
    case "Number_comparison"
        od.xlim = [-0.2 3];
        od.bl_win = [-0.2 0];
        od.col =  [[38 55 97]/255;
            [148 169 215]/255;
            [84 172 90]/255;
            [184 230 156]/255;
            cdcol.turquoise_blue;
            cdcol.flame_red;
            cdcol.periwinkle_blue;
            cdcol.pink;
            cdcol.purple];
    case "EglyDriver"
        od.xlim = [-0.5 2];
        od.blc = true;
        od.bl_win = [-0.5 0];
        od.col = [cdcol.ultramarine;
            cdcol.grass_green];
end

% %% Copy pre-specified fields
% fn = string(fieldnames(od1));
% for f = 1:numel(fn)
%     od.(fn(f)) = od1.(fn(f)); end
