function list2 = find_nodes(Z,n_nodes,n_objects)
% list2 = find_nodes(Z,n_nodes,n_objects)
% This function finds the number of nodes specified by 'n_nodes'.
% It starts at the top of the graph and branches downward until it
% finds 'n_nodes'# of nodes. 'n_objects' is the number of leaves on the
% dendrogram (60 in our case). 'list2' is n_nodes x 1 in size and contains the node 
% indices found.

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

%%%%%%%%%%%%%%%%%%%%
% list2(j,2:4) temporarily stores data directly from Z(j,:)
% the first column of list2 specifies the node index.

% copy first node
list2(1,1)=size(Z,1)+n_objects; % the highest node's index
list2(1,2:4)=Z(list2(1,1)-n_objects,1:3); % copy node data from var 'Z'
f_nodes = 1; % the number of nodes we have found.

%%%%%%%%%%%%
% Keep branching down until we find the # of nodes specified by 'n_nodes'
%%%%%%%%%%%%
while f_nodes < n_nodes
	f_nodes = f_nodes + 1;
	
	% Which node should we break into two? Let's break apart
	% node "C", the node that has the highest distance:
	C = find(list2(:,4) == max(list2(:,4)));
	if size(C,1) > 1
		C = C(1);
	end % else there are no more nodes to break apart.
	
	list2(C,1) = list2(C,2); % The new index of node C is now one of its children: child 1
	list2(f_nodes,1) = list2(C,3); % The next entry of list2 will be the other
									% child of node C: child 2
									
	% Is "child 1" a node or a leaf?
	if list2(C,1) <= n_objects
		list2(C,2:4) = 0; % It's a leaf. Fill the rest of the columns with null data.
	else
		list2(C,2:4)=Z(list2(C,1)-n_objects,1:3); % It's a node. Fill the columns
		% with its data from var 'Z'
	end
	
	% Is "child 2" a node or a leaf?
	if list2(f_nodes,1) <= n_objects
		list2(f_nodes,2:4) = 0; % It's a leaf. Fill the rest of the columns with null data.
	else
		list2(f_nodes,2:4)=Z(list2(f_nodes,1)-n_objects,1:3); % It's a node. Fill the columns
		% with its data from var 'Z'
	end
end
list2 = list2(:,1); % only keep/return the node indices

%catch
%keyboard
%end