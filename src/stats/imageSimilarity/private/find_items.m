function list = find_items(Z,node,n_objects)
% list = find_items(Z,node,n_objects)
% This recursive function returns a list of items (leaves) that are contained
% in the node specified by the variable 'node'. 'Z' is
% returned by Matlab's linkage function. 'n_objects'
% is the number of leaves on the dendrogram (60 in our case).

% How the variable "Z" is defined (from Matlab's "linkage" function documentation):
%
% Z is a (m-1)-by-3 matrix, where m is the number of observations in the original data. 
% Columns 1 and 2 of Z contain cluster indices linked in pairs to form a binary tree.
% The leaf nodes are numbered from 1 to m. Leaf nodes are the singleton clusters from 
% which all higher clusters are built. Each newly-formed cluster, corresponding to row Z(I,:),
% is assigned the index m+I. Z(I,1:2) contains the indices of the two component clusters that 
% form cluster m+I. There are m-1 higher clusters which correspond to the interior nodes of 
% the clustering tree. Z(I,3) contains the linkage distances between the two clusters merged 
% in row Z(I,:).
%
% In short: Z(i,1) = node/leaf within node i
% Z(i,2) = node/leaf within node i
% Z(i,3) = distance of node i

%%%%%%%%%%
% DEBUG: This shouldn't occur unless the function
% is called with trash parameters
%%%%%%%%%
%if node <= n_objects % this is not a node; it is an object
%	fprintf('objects=%i node=%i\n',n_objects,node);
%	error('this is not a node, it is an object');
%end

%%%%%%%%%%%
% This node will contain two 'things': one or both
% of which are nodes or one or both of which are leaves
%%%%%%%%%%

% first 'thing' in this node
if Z(node-n_objects,1) <= n_objects % an object, end of this branch
	list(1) = Z(node-n_objects,1); % add the leaf to the list returned
else % another node, continue branching
	% add the leaves in this branch to the list
	list = find_items(Z,Z(node-n_objects,1),n_objects);
end

% second 'thing' in this node
if Z(node-n_objects,2) <= n_objects % an object, end of this branch
	list(size(list,2)+1) = Z(node-n_objects,2); % add the leaf to the list returned
else % another node, continue branching
	% add the leaves in this branch to the list
	list2 = find_items(Z,Z(node-n_objects,2),n_objects);
	list = [list list2];
end