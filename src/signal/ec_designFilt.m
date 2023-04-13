function d = ec_designFilt(x,fs,hz,dType,a)
% Input validation
arguments
    x {mustBeFloat}
    fs (1,1) double
    hz (1,:) double
    dType {mustBeMember(dType,["lowpass" "highpass" "bandpass"])} = "highpass"
    a.steepness {mustBeLessThanOrEqual(a.steepness,1)} = 0.75 % Passband to stopband multiplier
    a.impulse {mustBeMember(a.impulse,["fir" "iir" "auto"])} = "auto" % Impulse response
    %a.design (1,1) string = ""
end
if numel(hz)>1; dType = "bandpass"; end
x = double(x(:,1,1));

%% Make filter object
if dType=="highpass"
    if a.impulse=="auto"
        [~,d] = highpass(x,hz,fs,ImpulseResponse=a.impulse,Steepness=a.steepness);
    else
        hz(2) = hz * a.steepness;
        if a.impulse=="fir"; a.design="kaiserwin"; else; a.design="ellip"; end
        d = designfilt(dType+a.impulse,StopbandFrequency=hz(2),PassbandFrequency=hz(1),...
            PassbandRipple=0.1,DesignMethod=a.design,SampleRate=fs);
    end
elseif dType=="lowpass"
   [~,d] = lowpass(x,hz,fs,ImpulseResponse=a.impulse,Steepness=a.steepness);
elseif dType=="bandpass"
    [~,d] = bandpass(x,hz,fs,ImpulseResponse=a.impulse,Steepness=a.steepness);
else
    d = signal.internal.filteringfcns.parseAndValidateInputs(x,char(dType),...
        {hz,fs,'Steepness',a.steepness,'ImpulseResponse',a.impulse});
    d = designFilter_lpf(d);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%% Subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% designFilter_lpf %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [d,opts] = designFilter_lpf(opts)
opts.IsFIR = true;
Fs = opts.Fs;
Wpass = opts.Wpass;
WpassNormalized = opts.WpassNormalized;
Apass = opts.PassbandRipple;
Astop = opts.StopbandAttenuation;

% All pass filter if Wpass is >= 1 or if signal length is <=3
if opts.SignalLength <= 3 || WpassNormalized >= 1
    d = dfilt.dffir(1);
    opts.FilterObject = digitalFilter(d);
    if opts.SignalLength <= 3
        warning(message('signal:internal:filteringfcns:AllPassBecauseSignalIsTooShort',num2str(3)));
    else
        warning(message('signal:internal:filteringfcns:ForcedAllpassDesign'));
    end
    return;
end

% Compute Tw and Wstop
Tw = opts.TwPercentage * (1 - WpassNormalized);
if opts.Response=="lowpass"
    WstopNormalized = WpassNormalized + Tw;
else
    WstopNormalized = WpassNormalized * (1-Tw);
end
Wstop = WstopNormalized * (Fs/2);
opts.Wstop = Wstop;
opts.WstopNormalized = WstopNormalized;

% Try to design an FIR filter, if order too large for input signal length,
% then try an IIR filter.

% Calculate the required min FIR order from the parameters
NreqFir = kaiserord([Wpass Wstop], [1 0], [opts.PassbandRippleLinear opts.StopbandAttenuationLinear], Fs);
% if opts.Response=="lowpass"
%     NreqFir = kaiserord([Wpass Wstop], [1 0], [opts.PassbandRippleLinear opts.StopbandAttenuationLinear], Fs);
% else
%     NreqFir = kaiserord([Wstop Wpass], [1 0], [opts.PassbandRippleLinear opts.StopbandAttenuationLinear], Fs);
% end
impRespType = signal.internal.filteringfcns.selectImpulseResponse(NreqFir, opts);    

if strcmp(impRespType,'iir')
    %% IIR design
    opts.IsFIR = false;

    % Get the min order of an elliptical IIR filter that will meet the
    % specs and see if signal length is > 3*order otherwise, truncate order
    NreqIIR = getIIRMinOrder(WpassNormalized,WstopNormalized,Apass,Astop);

    if opts.SignalLength <= 3*NreqIIR
        N = max(1,floor(opts.SignalLength/3));

        if N > 1 && 3*N == opts.SignalLength
            N = N-1;
        end
        params = {opts.Response+"iir", 'FilterOrder', N,...
            'PassbandFrequency', Wpass, 'PassbandRipple', Apass,...
            'StopbandAttenuation', Astop, 'DesignMethod', 'ellip'};
        warning(message('signal:internal:filteringfcns:SignalLengthForIIR'));
    else
        params = {opts.Response+"iir", 'PassbandFrequency', Wpass,...
            'StopbandFrequency', Wstop, 'PassbandRipple', Apass,...
            'StopbandAttenuation', Astop, 'DesignMethod', 'ellip'};
    end
else
    %% FIR design
    params = {opts.Response+"fir", 'PassbandFrequency', Wpass,...
        'StopbandFrequency', Wstop, 'PassbandRipple', Apass,...
        'StopbandAttenuation',Astop,'DesignMethod','kaiserwin','MinOrder','even'};
end

params{1} = char(params{1});
if ~opts.IsNormalizedFreq
    params = [params {'SampleRate',Fs}];
end
d = designfilt(params{:});



%% getIIRMinOrder
function N = getIIRMinOrder(WpassNormalized,WstopNormalized,Apass, Astop)
% Compute analog frequencies
%   WpassNormalized, WstopNormalized are passband and stopband normalized
%   frequencies Apass, and Astop are ripple and attenuation in linear units

% Analog frequencies
aWpass = tan(pi*WpassNormalized/2);
aWstop = tan(pi*WstopNormalized/2);
[N, ~] = signal.internal.filteringfcns.getMinIIREllipOrder(aWpass,aWstop,Apass,Astop);


