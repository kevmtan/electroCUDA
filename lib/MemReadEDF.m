function [EDFhdr, EDFdata] = MemReadEDF(EDFfile, varargin)

% Reading EDF+ file format with specific times and channels without putting 
% unwanted information into memory. This uses the memmap function to map 
% the EDF+ file on disk where it can then be pulled from and put into
% memory for further analysis. This also cuts down on unnecessary
% computational time and greatly reducing the time it takes to read a file.
%
%
% EDFhdr = MemReadEDF(EDFfile)
%   A single output request will only read the EDF+ header information and
%   return it as a struct. No signal data will be outputed in the header.
%
% EDFhdr = MemReadEDF(EDFfile, 'annotations')
%   Including the optional annotations argument will read the annotations
%   in the EDF+ file and return them in the header structure.
%
% [EDFhdr, EDFdata] = MemReadEDF(EDFfile)
%   Including the secondary output will return the signal data from the
%   EDF+ file. If no other inputs are provided it will return the entire 
%   signal record associated with the EDF+ file (all times and all channels)
%
% [EDFhdr, EDFdata] = MemReadEDF(EDFfile, 'time', [0 60], 'channels', [1:12], 'annotations')
%   Currently there are 3 optional parameters provided for reading
%   information from the EDF+ file. The 'time' and 'channels' inputs
%   require their values after the call as seen above. The call above will
%   read the first 60 seconds of the recording for channels 1 through 12.
%   Including the 'annotations' parameter will simply write the annotations
%   to the struct header (EDFhdr).
%
% 'time': you can ask for any time periode you would like in seconds. The
% time will start at time 0 and go until the end of the file. If you want 
% everything from time 100 to the end of the file but do not
% know then end of the file you can simpling run the following: [EDFhdr, EDFdata] =
% MemReadEDF(EDFfile, 'time', [100, inf],).
%
% 'channels': You can order the channels in any way you would like. For
% example if you wanted the 3rd channel first in the data records and
% the 1st channel second you could write the following: [EDFhdr, EDFdata] =
% MemReadEDF(EDFfile, 'channels', [3, 1],).
%
% 'annotations': Asking for annotations will greatly increase the amount of 
% time it takes to run a file depending on the length of the file, the 
% amount of annotations or how they are saved.
%
%
% All information about the EDF+ file format was sourced from: https://www.edfplus.info/specs/edfplus.html
% With their home page being: https://www.edfplus.info/index.html
%
%
% Coded May ‎27, ‎2022, by Darion Toutant,
% Email: toutant3@myumanitoba.ca
% If this code is used please cite it in your work
% Citation Greatly Appreciated
%
%
% Huge thank you to Andrew Michalak who aided in the development of this
% function also helping in independent testing of the function on his set
% of files.
%
%


%% Grab varargin inputs 

% Currently there are 5 optional inputs that can be used
if numel(varargin) > 5
    error(['MemReadEDF: You have inputted to many arguments.' newline...
        'Correct syntax is: MemReadEDF(FileName, ''time'', [0 60], ''channels'', [2,3,4,8], ''annotations'')']);
end

% There must be at least a fileName input to use this function
if ~nargin
    error(['MemReadEDF: Requires an edf file to read (must input a fileName).' newline...
        'Correct syntax is: MemReadEDF(FileName)']);
end

% Make all strings lowercase
CharIDX = cellfun(@ischar, varargin);
varargin(CharIDX) = lower(varargin(CharIDX));

% Time
TimeIDX = find(strcmp(varargin, 'time'), 1);

% Channels
ChanIDX = find(strcmp(varargin, 'channels'), 1);

% Annotations
AnnoIDX = find(strcmp(varargin, 'annotations'), 1);

% Check if inputs provided match what can be used
Count=0;
if ~isempty(TimeIDX), Count = Count+2; end
if ~isempty(ChanIDX), Count = Count+2; end
if ~isempty(AnnoIDX), Count = Count+1; end

% if values do not match what was inputted than find what is wrong
if Count ~= numel(varargin)

    varIDX = find(CharIDX);
    varIDXcount = 1;
    for idx = 1:numel(varargin(CharIDX))

        if ~ismember(varargin(varIDX(idx)), {'time', 'channels', 'annotations'})

            ErrrorMessageInputs{varIDXcount} = [blanks(1), char(varargin(varIDX(idx)))]; %#ok<AGROW>

            varIDXcount = varIDXcount + 1;

        end

    end

    if exist('ErrrorMessageInputs','var') == 1

        error(['These are not valid inputs:', [ErrrorMessageInputs{:}] newline...
            'Correct syntax is: MemReadEDF(FileName, ''time'', [0 60], ''channels'', [2,3,4,8], ''annotations'')'])

    else

        error(['You need to have the values after the optional parameters ''time'' and ''channels''', newline...
            'Correct syntax is: MemReadEDF(FileName, ''time'', [0 60], ''channels'', [2,3,4,8], ''annotations'')'])

    end

end

%% EDF header
[fileID, errMsg] = fopen(EDFfile, 'r');

if fileID == -1
    error(errMsg)
end

% Version of this data format 8 ascii 
EDFhdr.Version = str2double(char(fread(fileID, 8)'));

% Local patient identification 80 ascii 
EDFhdr.Patient = strtrim(fread(fileID, 80, "*char")');

% Local recording identification 80 ascii 
EDFhdr.Recording = strtrim(fread(fileID, 80, "*char")');

% Start date of recording 8 ascii 
EDFhdr.StartDate = fread(fileID, 8, "*char")';

% Start time of recording 8 ascii 
EDFhdr.StartTime = fread(fileID, 8, "*char")';

% Number of bytes in header record 8 ascii
EDFhdr.NumBytes = str2double(fread(fileID, 8, "*char")');

% reserved 44 ascii (example: EDF+D)
EDFhdr.Reserved = strtrim(fread(fileID, 44, "*char")');

% Number of data records 8 ascii (-1 if unkown) 
EDFhdr.NumRecords = str2double(fread(fileID, 8, "*char")');

if EDFhdr.NumRecords == -1
    disp("Clearly I didn't allow for this version of EDF to be read")
    return
end

% Duration of a data record, in seconds 8 ascii 
EDFhdr.Duration = str2double(fread(fileID, 8, "*char")');

% Real duration of study in seconds
EDFhdr.TotalDurationSeconds = EDFhdr.Duration*EDFhdr.NumRecords;

% Number of channels (ns) in the recording 4 ascii
EDFhdr.NumChannels = str2double(fread(fileID, 4, "*char")');

% Total bytes = 256


%% Data headers

% channel label (ns*16 ascii)
for n = 1:EDFhdr.NumChannels
    EDFhdr.ChanLabel{n} = strtrim(fread(fileID, 16, "*char")');
end

% Transducer type (ns*80 ascii)
for n = 1:EDFhdr.NumChannels
    EDFhdr.Transducer{n} = fread(fileID, 80, "*char")';
end

% Physical dimension (ns*8 ascii)
for n = 1:EDFhdr.NumChannels
    EDFhdr.PhysicalDimension{n} = fread(fileID, 8, "*char")';
end

% Physical minimum (ns*8 ascii)
for n = 1:EDFhdr.NumChannels
    EDFhdr.PhysicalMin(n) = str2double(fread(fileID, 8, "*char")');
end

% Physical maximum (ns*8 ascii)
for n = 1:EDFhdr.NumChannels
    EDFhdr.PhysicalMax(n) = str2double(fread(fileID, 8, "*char")');
end

% Digital minimum (ns*8 ascii)
for n = 1:EDFhdr.NumChannels
    EDFhdr.DigitalMin(n) = str2double(fread(fileID, 8, "*char")');
end

% Digital maximum (ns*8 ascii)
for n = 1:EDFhdr.NumChannels
    EDFhdr.DigitalMax(n) = str2double(fread(fileID, 8, "*char")');
end

% Prefiltering (ns*80 ascii)
for n = 1:EDFhdr.NumChannels
    EDFhdr.Prefiltering{n} = fread(fileID, 80, "*char")';
end

% Number of samples in each data record (nr) (ns*8 ascii)
for n = 1:EDFhdr.NumChannels
    EDFhdr.NumSamples(n) = str2double(fread(fileID, 8, "*char")');
end

% Make the sampling rate from the Number of samples stored and duration
EDFhdr.SamplingRate = EDFhdr.NumSamples ./ EDFhdr.Duration;

% reserved (ns*32 ascii)
for n = 1:EDFhdr.NumChannels
    EDFhdr.DataReserved{n} = fread(fileID, 32, "*char")';
end

% Total bytes before data recording is in EDF.NumBytes
% totalbytes = (8+80+80+8+8+8+44+8+8+4) + EDF.NumChannels * (16+80+8+8+8+8+8+80+8+32);
% totalbytes = 256 + EDF.NumChannels * 256;

fclose(fileID);


%% Memmory map the data portion of the EDF file (offset by total bytes of header)

% Annotations are unfortuantely in the actual data therefore need memmory map everything

%Get full amount of samples for each channel
TotalNumSamples = sum(EDFhdr.NumSamples);

% this will only work for signals of the same sampling rate
EDFrecord = memmapfile(EDFfile, 'Format',{'int16' [TotalNumSamples  EDFhdr.NumRecords] 'x'}, 'Offset', EDFhdr.NumBytes, 'Repeat', 1);


%% Experimental Annotations (only works for EDF+ files with annotations as last channel)

if ~isempty(AnnoIDX)

    % Much more difficult than expected as not all are written similarly
    % because some have an annotation for every time point while others only
    % create for the time points of the annotation and leave excess at the back
    % Every TAL is seperated by a 0 though. If I were to create an annotation
    % reader divided by 0s than I'd have to ensure they are using 32 for
    % spaces.

    AnnotationRows = sum(EDFhdr.NumSamples(1:end-1));


    Anno = EDFrecord.Data.x(AnnotationRows+1:AnnotationRows+EDFhdr.NumSamples(end), :);
    Anno = reshape(Anno, [], 1);
    Anno = typecast(Anno,'uint8');

    % Find all annotations by looking for changes from 0 to someting non 0
    % Every annotation is seperated by a 0
    AnnoIDX = find(Anno==0);
    Annotemp = diff(AnnoIDX)==1;
    AnnoIDX = AnnoIDX(~Annotemp);

    % Must use this to adjust all other annotations (zeros the record)
    EDF_Start = str2double(char(Anno(1:AnnoIDX(1)-3))); % The first anno has the miliseconds for the real start time


    EDFhdr.Annotations(1).Type      = [];
    EDFhdr.Annotations(1).Seconds   = [];
    EDFhdr.Annotations(1).Duration  = [];

    % https://www.edfplus.info/specs/edfplus.html
    % Each TAL starts with a time stamp Onset21Duration20
    % Example: '+1800.2 21 25.5 20 Apnea 20 0' spaces are only to show differences
    % Where uint(21) seperates onset and duration with uint(20) seperating
    % duration - text - end followed by a uint(0) at the end of every TAL
    count = 1;
    for x = 1:numel(AnnoIDX) - 1

        % Trying to vectorize stoofs
        % y = Anno(find(Anno(AnnoIDX(x):AnnoIDX(x+1)),1,'first'):find(Anno(AnnoIDX(x):AnnoIDX(x+1)),1,'last'));

        % CurrentAnno = regexprep(char(Anno(AnnoIDX(x):AnnoIDX(x+1)))', char(0), '');
        CurrentAnno = char(Anno(AnnoIDX(x)+1:AnnoIDX(x+1)))';

        TALS20idx = find(CurrentAnno==20);
        TALS21idx = find(CurrentAnno==21);

        % if there is a 21 than there is a duration
        if TALS21idx
            EDFhdr.Annotations(count).Duration = str2double(CurrentAnno(TALS21idx(1)+1:TALS20idx(1)-1));
            EDFhdr.Annotations(count).Seconds = str2double(CurrentAnno(1:TALS21idx(1)-1)) - EDF_Start;
            EDFhdr.Annotations(count).Type = CurrentAnno(TALS20idx(1)+1:TALS20idx(end)-1);

            count = count + 1;

            % There isn't a duration therefore set it to 0
        elseif numel(TALS20idx) >= 2


            % For some reason I have recordings with multiple text for a single time
            for xx = 1:numel(TALS20idx) - 1
                % If TALS20idx are next to eachother than there is no text so skip
                if diff(TALS20idx) ~= 1
                    EDFhdr.Annotations(count).Duration = 0;
                    EDFhdr.Annotations(count).Seconds = str2double(CurrentAnno(1:TALS20idx(1)-1)) - EDF_Start;
                    EDFhdr.Annotations(count).Type = CurrentAnno(TALS20idx(xx)+1:TALS20idx(xx+1)-1);

                    count = count + 1;
                end
            end

        end

    end

end


%% If only requesting a single output than return header info
if nargout <= 1

    return

else

    % Grab actual file size and compare to header information to ensure
    % proper amount of data is availalbe (Could be faulty download)
    s = dir(EDFfile);
    if double(s.bytes/2) ~= double(sum(EDFhdr.NumSamples) *  EDFhdr.NumRecords +  EDFhdr.NumBytes/2)
        error('Actual file size does not match the calculated amount of data in the file. This file is missing crucial information to be processed.')
    end

end


%% Varargin Time parsing

if ~isempty(TimeIDX)

    % Make sure there are 2 values for the time input
    assert(isnumeric(varargin{TimeIDX + 1}) && numel(varargin{TimeIDX + 1}) == 2 && varargin{TimeIDX + 1}(2) > varargin{TimeIDX + 1}(1), ['Correct syntax is: MemReadEDF(FileName, ''time'', [startTime stopTime])' newline...
        'You are required to input a start and finish value (in seconds) after the ''time'' parameter. '...
        'For example: [0 ', num2str(EDFhdr.TotalDurationSeconds), ']'])

    StartOffset  = 1 + varargin{TimeIDX + 1}(1) / EDFhdr.Duration;           % Where time starts at 0
    InputSeconds = varargin{TimeIDX + 1}(2) / EDFhdr.Duration - StartOffset;

    if StartOffset > EDFhdr.NumRecords
        error(['Why you gotta have a start point past the actual recording... The max time allowed is: ', mat2str(EDFhdr.TotalDurationSeconds) newline...
            'Correct syntax is: MemReadEDF(FileName, ''time'', [startTime stopTime])'])
    end
    
% If time was not asked for than read the entire file
else
    
    StartOffset = 1;
    InputSeconds = EDFhdr.NumRecords - StartOffset;
    disp([9 'No input time was specified. Extracting entire file time of ', num2str(EDFhdr.TotalDurationSeconds), ' seconds.'])

end

% This just makes the file go to the end instead of overshooting
if StartOffset + InputSeconds > EDFhdr.NumRecords
    InputSeconds = EDFhdr.NumRecords - StartOffset;
    disp(['You went to far!!! Fetching data up until: ', mat2str(EDFhdr.TotalDurationSeconds), ' seconds'])
end

% Do a quick check and ensure they want to load tons of data into memory
% Comment this out if its annoying
if (InputSeconds - StartOffset) * EDFhdr.Duration >= 4 * 3600

    % Throw a Yes, No dialogue box to ensure they want to put over 4 hours into memory
    answer = questdlg(['Are you sure you want to put ', num2str(InputSeconds * EDFhdr.Duration), ' seconds into memory?'], ...
        'Memory Overload', 'Yes', 'No', 'No');

    % If response was no just return
    if strcmp(answer, 'No')
        return
    end

end

% Add a Requested time to the header struct
EDFhdr.TimeRequested = [StartOffset - 1, (InputSeconds * EDFhdr.Duration) + StartOffset];


%% Channel, sampling rates and annotations check

% If there is a channel input
if ~isempty(ChanIDX)
 
    assert(isnumeric(varargin{ChanIDX + 1}) && numel(varargin{ChanIDX + 1}) <= numel(EDFhdr.ChanLabel) && all(rem(varargin{ChanIDX + 1},1)==0),...
        ['Correct syntax is: MemReadEDF(FileName, ''channels'', [2,3,4,8])' newline 'You are required to input the channel numbers as integers after the ''channels'' parameter. '...
        newline 'For example: [1:', num2str(numel(EDFhdr.ChanLabel)), '] would give all channels'])

    ChannelsIDX = varargin{ChanIDX + 1};

    % Add a Requested channel to the header struct
    EDFhdr.ChannelsRequested = EDFhdr.ChanLabel(ChannelsIDX);

    % Otherwise just get all channels
else

    ChannelsIDX = 1:numel(EDFhdr.ChanLabel);

end

AnnotationIDX = strfind(EDFhdr.ChanLabel(ChannelsIDX), 'Annotations');
if ~isempty(AnnotationIDX{end}) % Is required to be at the end of the list
    lenchannels = numel(EDFhdr.ChanLabel(ChannelsIDX)) - 1;
else
    lenchannels = numel(EDFhdr.ChanLabel(ChannelsIDX));
end

% Also check to see all the rest of the channels have same sampling rate
if ~(numel(unique(EDFhdr.SamplingRate(1:lenchannels)))==1)
    % If they arent all the same frequency
    fprintf(['Only tested with channels that have the same sampling frequency. \nYou can certainly comment this loop out ' ...
        'to test if this funtion works with different sampling rate signals\n'])
    return
end


%% Extract data requested

Scaling = (EDFhdr.PhysicalMax - EDFhdr.PhysicalMin) ./ (EDFhdr.DigitalMax - EDFhdr.DigitalMin);
dc      = EDFhdr.PhysicalMax - Scaling .* EDFhdr.DigitalMax;

% Pre-allocate EDFdata (Only works if sampling rates are all the same)
% Could just go to the largest and have blanks for the rest which could
% accomidate different sampling rates?
EDFdata = zeros((1 + InputSeconds) * EDFhdr.NumSamples(1), lenchannels); 

% would need to leverage cells or individual structs if sampling rates differed 
% (or simply extend to the largest sampling rate and leave a bunch of empty
% spaces in the arrays with lower sampling rates)

% Stop values for every channel
CurrentRows = cumsum(EDFhdr.NumSamples);

% Loop over number of channels
for i = 1:lenchannels % -1 for if theres annotations (now just lenchannels)  

    % Get the data per channel
    Datatemp = double(EDFrecord.Data.x(CurrentRows(ChannelsIDX(i))-(EDFhdr.NumSamples(ChannelsIDX(i)) - 1):CurrentRows(ChannelsIDX(i)), StartOffset:StartOffset+InputSeconds)) * Scaling(ChannelsIDX(i)) + dc(ChannelsIDX(i));

    % convert matrix to column vector
    EDFdata(1:(1 + InputSeconds)*EDFhdr.NumSamples(ChannelsIDX(i)), i) = reshape(Datatemp, [], 1); 

    % The Matlab profiler actually says doing it in 2 steps is faster
    % EDFdata(1:(1 + InputSeconds)*EDFhdr.NumSamples(ChannelsIDX(i)), i) = reshape(double(EDFrecord.Data.x(CurrentRows(ChannelsIDX(i))-(EDFhdr.NumSamples(ChannelsIDX(i)) - 1):CurrentRows(ChannelsIDX(i)), StartOffset:StartOffset+InputSeconds)) * Scaling(ChannelsIDX(i)) + dc(ChannelsIDX(i)), [], 1);
    
end

return