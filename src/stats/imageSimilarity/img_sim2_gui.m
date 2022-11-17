function [img_dir,method,create_heatmap,rank_similarity,start] = img_sim2_gui(img_dir_g) 

% This GUI facilitates the use of the Image Similarity Toolbox
% defined in img_sim2.m
% Author: Kegan Landfair - July 16, 2015

%img_dir=[full_path 'example_images/'];
method = 1;
create_heatmap = 0;
rank_similarity = 0;
start = 0;
img_dir = img_dir_g;

% Create and then hide the UI as it is being constructed.
f = figure('Visible','off','NumberTitle','off','Menubar','none','Toolbar','none','Position',[350,300,500,300]);

% Construct the components.
browseb = uicontrol('Style','pushbutton','String','Browse',...
    'Position',[370,240,70,25],...
    'Callback',{@browsebutton_Callback});
btext1 = uicontrol('Style','text','String','Specify an image directory',...
    'Position',[140,270,150,15]);
btext = uicontrol('Style','edit','String',img_dir_g,...
    'Position',[70,240,300,25],...
    'Callback',{@browsetext_Callback});
mtext = uicontrol('Style','text','String','Select Computer Vision Method',...
    'Position',[150,200,150,15]);
mpopup = uicontrol('Style','popupmenu','String',...
    {'Pixel','SIFT','Jarrett Hierarchical','Geometric Blur',...
    'Scene Gist','HMAX','Shock Graphs','Gabor Filterbank',...
    'CNN1(low layer)','CNN1(mid layer)','CNN1(high layer)',...
    'CNN2(low layer)','CNN2(mid layer)','CNN2(high layer)',...
    'CNN3(low layer)','CNN3(mid layer)','CNN3(high layer)',...
    'CNN4(low layer)','CNN4(mid layer)','CNN4(high layer)',...
    'CNN5(low layer)','CNN5(mid layer)','CNN5(high layer)'},...
    'Position',[170,170,200,25],...
    'Callback',{@method_menu_Callback});
optext = uicontrol('Style','text','String','Choose task(s)',...
    'Position',[137,140,100,15]);
heatcb = uicontrol('Style','checkbox','String','Create Heatmap',...
    'Position',[170,110,140,25],...
    'Callback',{@heatmap_Callback});
rankcb = uicontrol('Style','checkbox','String','Rank similarity pairs',...
    'Position',[170,80,160,25],...
    'Callback',{@rankpairs_Callback});
startb = uicontrol('Style','pushbutton','String','Start',...
    'Position',[150,30,70,25],...
    'Callback',{@startbutton_Callback});
cancelb = uicontrol('Style','pushbutton','String','Cancel',...
    'Position',[280,30,70,25],...
    'Callback',{@cancelbutton_Callback});

% Align the components
%align([browseb,mpopup],'HorizontalAlignment','Right');
%align([mtext,optext],'HorizontalAlignment','Left');

% Initialize the UI
% change units to normalized so components resize automatically.
f.Units = 'normalized';
browseb.Units = 'normalized';
btext1.Units = 'normalized';
btext.Units = 'normalized';
mtext.Units = 'normalized';
mpopup.Units = 'normalized';
optext.Units = 'normalized';
heatcb.Units = 'normalized';
rankcb.Units = 'normalized';
startb.Units = 'normalized';
cancelb.Units = 'normalized';
% Assign a name to appear in the window title.
f.Name = 'Image Similarity Console';
% Move the windo to the center of the screen.
movegui(f,'center')
% Make the UI visible.
f.Visible = 'on';


% Editable textfield callback (for image directory).
    function browsetext_Callback(~,~)
        %source.String = selected_dir;
        img_dir = btext.String;
    end

% Pop-up menu callback. Read the pop-up menu Value property to 
% determine which item is currently displayed and make it the 
% current method.
    function method_menu_Callback(source,~)
        % Determine the selected method.
        str = source.String;
        val = source.Value;
        % Set method to the selected method.
        switch str{val};
            case 'Sum Squared Error'
                method = 1;
            case 'SIFT'
                method = 2;
            case 'Jarrett Hierarchical'    
                method = 3;
            case 'Geometric Blur'        
                method = 4;
            case 'Scene Gist'
                method = 5;
            case 'HMAX'    
                method = 6;
            case 'Shock Graphs'
                method = 7;
            case 'Gabor Filterbank'
                method = 8;
            case 'CNN1(low layer)'
                method = 9;
            case 'CNN1(mid layer)'
                method = 10;
            case 'CNN1(high layer)'
                method = 11;
            case 'CNN2(low layer)'
                method = 12;
            case 'CNN2(mid layer)'
                method = 13;
            case 'CNN2(high layer)'
                method =14;
            case 'CNN3(low layer)'
                method =15;     
            case 'CNN3(mid layer)'
                method = 16;  
            case 'CNN3(high layer)'
                method =17;                
            case 'CNN4(low layer)'
                method =18;     
            case 'CNN4(mid layer)'
                method = 19;  
            case 'CNN4(high layer)'
                method =20;  
            case 'CNN5(low layer)'
                method =21;     
            case 'CNN5(mid layer)'
                method = 22;  
            case 'CNN5(high layer)'
                method =23;                
        end
    end

% Push button callbacks.

    function browsebutton_Callback(~,~)
        img_dir = uigetdir;
        btext.String = img_dir;
    end

    function startbutton_Callback(~,~)
        start = 1;
        delete(f); % close the GUI
    end

    function cancelbutton_Callback(~,~)
        start = 0;
        delete(f); % close the GUI
    end

% Checkbox callbacks.

    function heatmap_Callback(source,~)
        create_heatmap = source.Value;
    end

    function rankpairs_Callback(source,~)
        rank_similarity = source.Value;
    end

% Wait until figure is closed
waitfor(f);

end