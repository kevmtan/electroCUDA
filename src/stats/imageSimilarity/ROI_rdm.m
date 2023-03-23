function [RDM_fmri] = ROI_rdm(brain_dataIN)
% function [RDM_fmri] = ROI_rdm(brain_dataIN)
% This function computes and returns the representational dissimilarity
% matrix (RDM) for the feature vectors obtained in each region of interest 
% of a subject (after viewing some set of images).
% 
% Input: brain_dataIN - a matrix containing the feature vectors for a ROI.
%
% Output: RDM_fmri (the RDM computed from the feature vectors of the ROI)
% Also produced is a heatmap of the RDM.
%
% Author: Kegan Landfair - June 24, 2015

%% Pull in data and declare variables
brain_data = brain_dataIN; % The matrix of feature vectors will be stored in brain_data.
numVectors = size(brain_dataIN,1); % The number of stimuli presented to subject. 
RDM_fmri = zeros(numVectors); % The RDM must be square (numFeatures x numFeatures).
F_fmri = cell(numVectors,1); % Each cell will contain a feature vector from brain_data.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compute the RDM
%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load F_fmri with the feature vectors (the rows of brain_data)
for i=1:numVectors
    F_fmri{i} = brain_data(i,:); 
end

% Compare the feature vectors and put the
% corresponding dissimilarity metric into the RDM
%RDM_row = 1;
%RDM_size = nchoosek(numFeatures,2);
for vector1=1:numVectors
	%fprintf('Computing dissimilarity matrix... %i%% done\n', round(100*RDM_row/RDM_size));
	for vector2=vector1+1:numVectors
        corrValue = 1 - abs(corr(F_fmri{vector1}',F_fmri{vector2}','Type','Spearman'));
		RDM_fmri(vector1,vector2) = corrValue;
        RDM_fmri(vector2,vector1) = corrValue; % To fill the lower half of the RDM as well.
		%RDM_row = RDM_row + 1;
	end
end
% RDM(find(RDM == Inf)) = -Inf;
% RDM(find(RDM == -Inf)) = max(RDM);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Create the Heatmap
%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('Name','Heatmap For RDM_fmri','NumberTitle','off');
colormap('jet');
%imagesc(prc_mat);
imagesc(RDM_fmri);
set(gca,'xtick',[],'ytick',[]);
colorbar

end
