function SaveDataNihonKohden_KT(sbj_name, project_name, block_name, dirs, refChan, epiChan, emptyChan, badChan, noisyChan, altBadChan)

%% load the data to define and eliminate bad channels

% Loop across blocks
for i = 1:length(block_name)
    bn = block_name{i};
    
    % Load globalVar
    fn = sprintf('%s/orig/%s/global_%s_%s_%s.mat',dirs.data,sbj_name,project_name,sbj_name,bn);
    load(fn,'globalVar');
    
    data_dir = [dirs.origDat filesep sbj_name filesep bn]; % directory for saving data
    fname =  [dirs.origDat filesep sbj_name filesep bn filesep bn '.edf'];
    
    if strcmp(globalVar.center, 'Stanford')
        [hdr, D] = edfread_lbcn(globalVar.iEEG_data_server_path);
    elseif strcmp(globalVar.center, 'China')
        [hdr, D] = edfread_China(globalVar.iEEG_data_server_path);
    else
    end
    
    %% Add Exception for when channels don' have labels
    hdr.label =  hdr.label(~strcmp(hdr.label, 'POL'));
    D = D(~strcmp(hdr.label, 'POL'),:);
    hdr.label =strrep(hdr.label,'`','''');
    fs = size(D,2)/(hdr.records * hdr.duration);
    % hdr.records = number of chuncks
    % hdr.duration = duration of each chunck
    
    % Downsampling parameters
    target_fs = 1000; %
    target_fs_comp = round(target_fs/5); % reduced fs for spectral data
    
    if fs <= target_fs
        ecog_ds = 1;
    else
        ecog_ds = round(fs/target_fs); % decimate factor
    end
    
     pdio_ds = 1; % do not downsample for photodiode signals
%     pdio_ds=ecog_ds; %downsample for photodiode signals
    pdio_ds=1; %downsample for photodiode signals

    
    % Take the indices of the channels of interest
    pdio_oldinds = find(contains(hdr.label, 'DC'));
    pdio_newinds = 1:length(pdio_oldinds); %how to save data
    
    ekg_oldinds = find(contains(hdr.label, 'EKG'));
    ekg_newinds = 1:length(ekg_oldinds); %how to save data
    %     ecog_oldinds = find(~contains(hdr.label, '$')&~contains(hdr.label, 'DEL')&~contains(hdr.label, 'EMG')&~contains(hdr.label, 'EKG') & ~contains(hdr.label, 'DC') & ~contains(hdr.label, 'EF') & ~contains(hdr.label, 'Annotations')...
    %         &~ contains(hdr.label,'ELG') & ~ contains (hdr.label,'BP')& ~ strcmp(hdr.label,'POLE')); %index in EDF file
    %
    if  strcmp(globalVar.center, 'Stanford')
        ecog_oldinds = find(~contains(hdr.label, 'EKG') & ~contains(hdr.label, 'DC') & ~contains(hdr.label, 'REF') & ~contains(hdr.label, 'Annotations')); %index in EDF file
        
    elseif strcmp(globalVar.center, 'China')
        chan_tmp= regexp(hdr.label,'^(EEG|POL)[A-Z]{1}(''?)+[0-9]{1,2}','match');
        ecog_oldinds=find(cellfun(@isempty,chan_tmp)==0);
    end
    ecog_newinds = 1:length(ecog_oldinds); 
    % Loop across channels
    channame = cell(size(ecog_newinds));
    for ei = 1:length(ecog_oldinds)
        if (ecog_newinds(ei)<10)
            chanlbl = ['0',num2str(ecog_newinds(ei))];
        else
            chanlbl = num2str(ecog_newinds(ei));
        end
        fp = sprintf('%s/iEEG%s_%s.mat',data_dir,bn,chanlbl);
        wave = squeeze(D(ecog_oldinds(ei),:,1));
        if (ecog_ds > 1)
            wave = decimate(double(wave),ecog_ds,'fir');
            %wave = downsample(double(wave),ecog_ds);
        end
        % Clean channel name
        channame_tpm = hdr.label{ecog_oldinds(ei)};
        channame_tpm = strrep(channame_tpm,'POL','');
        
        % This is to correct some chan labels from China
        if contains(channame_tpm, 'EEG') && contains (channame_tpm, '-')
            channame_tpm = strrep(channame_tpm,'EEG','');
            channame{ei} = strrep(channame_tpm,'-Ref','');
        else
            channame{ei} = strrep(channame_tpm,'Ref','');
        end
        save(fp,'wave','fs','channame')
        disp(['Saving chan ',chanlbl,' ',channame{ei}])
    end
    
    dclabel=hdr.label(pdio_oldinds);
    for pi = 1:length(pdio_oldinds)
        if strcmp(globalVar.center, 'Stanford')
            chanlbl = ['0',num2str(pdio_newinds(pi))];
        else
            chanlbl=dclabel{pi}(end-1:end);
        end
        fp = sprintf('%s/Pdio%s_%s.mat',data_dir,bn,chanlbl);
        anlg = squeeze(D(pdio_oldinds(pi),:,1));
        if ~strcmp(project_name, 'Calculia_production')
            if (pdio_ds > 1)
                anlg = decimate(double(anlg),pdio_ds,'fir');
                % anlg = downsample(double(anlg),ecog_ds);
            end
        else
        end
        save(fp,'anlg','fs')
        disp(['Saving pdio ',chanlbl])
    end
    
    ekglabel=hdr.label(ekg_oldinds);
    for pi = 1:length(ekg_oldinds)
        if strcmp(globalVar.center, 'Stanford')
            chanlbl = ['0',num2str(ekg_newinds(pi))];
        else
            chanlbl=dclabel{pi}(end-1:end);
        end
        fp = sprintf('%s/EKG%s_%s.mat',data_dir,bn,chanlbl);
        anlg = squeeze(D(ekg_oldinds(pi),:,1));
        if ~strcmp(project_name, 'Calculia_production')
            if (pdio_ds > 1)
                anlg = decimate(double(anlg),pdio_ds,'fir');
                % anlg = downsample(double(anlg),ecog_ds);
            end
        else
        end
        save(fp,'anlg','fs')
        disp(['Saving pdio ',chanlbl])
    end    
    
    
    %% Update global variable
    
    % Plot the pdio channels (pdio_oldinds)
    % Prompt asking to visually identify the photodiode channel
    % add the photodiode channel label the globalVar
    
    
    globalVar.iEEG_rate = fs/ecog_ds;
    globalVar.Pdio_rate = fs/pdio_ds;
    globalVar.fs_comp= target_fs_comp;
    globalVar.channame = channame;
    globalVar.chanLength = length(wave);
    globalVar.nchan = length(globalVar.channame);
    globalVar.refChan = refChan;
    globalVar.epiChan = epiChan;
    globalVar.emptyChan = emptyChan;
    globalVar.badChan = [];
    globalVar.noisyChan = noisyChan;
    globalVar.altBadChan = altBadChan;
    globalVar.badChan = badChan;
    
    save(fn,'globalVar');
    disp('globalVar updated')
    
end
