function Fc = hier_model_KT(I,filter,n_filters,filter_size,filter_overlap,g_filter_Jar,box_filter,doGPU)
% Method: Hierarchical model

%% Convolve filters with images and take absolute value
if doGPU
    I = imresize(single(I), [400 400]);
else
    I = imresize(I, [400 400]);
end

% Run each filter
I_filtered = arrayfun(@(a) abs(tanh(conv2(I,a{1}))), filter,'UniformOutput',false);
I_g = arrayfun(@(a) conv2(a{1},g_filter_Jar), I_filtered,'UniformOutput',false);

%% Sum gaussian conv across filters
kl = 1+filter_overlap:400-filter_overlap;
I_g_sum = zeros(400, 400);
if doGPU
    I_g_sum = gpuArray(single(I_g_sum));
end

for j = 1:n_filters
    I_g_sum(kl,kl) = I_g_sum(kl,kl) + I_g{j}(kl,kl);
end

%% Subtract results from I_filtered
for j = 1:n_filters
    I_filtered{j}(kl,kl) = I_filtered{j}(kl,kl) - I_g_sum(kl,kl);
end

%% Gausian conv^2
for j = 1:n_filters % run each filter
	I_g{j} = conv2((I_filtered{j}).^2, g_filter_Jar); % convolve with gaussian
end

%% Sum gaussian conv across filters--> sqrt
I_g_sum = zeros(400, 400);
if doGPU
    I_g_sum = gpuArray(single(I_g_sum));
end

for j = 1:n_filters
    I_g_sum(kl,kl) = I_g_sum(kl,kl) + I_g{j}(kl,kl);
end
I_g_sum(kl,kl) = sqrt(I_g_sum(kl,kl));
I_g_avg = sum(sum(I_g_sum)) / ((400-3*(filter_size-1))^2);


%% Divide
for j = 1:n_filters
    I_filtered{j}(kl,kl) = I_filtered{j}(kl,kl)./max(I_g_avg, I_g_sum(kl,kl));
end

%% Average (pooling)
Fc = arrayfun(@(a) avgPoolLoc(a{1},box_filter,filter_overlap), I_filtered,'UniformOutput',false);

end


function Fc = avgPoolLoc(J_filtered,box_filter,filter_overlap)
%%
J_filtered = conv2(J_filtered, box_filter);
% decrease size, due to convolutions
J_filtered = J_filtered(4*filter_overlap:400-4*filter_overlap, 4*filter_overlap:400-4*filter_overlap);

%histogram
l_form = reshape(J_filtered, [], 1);
N_t = hist(l_form, -2:0.1:2); %#ok<HIST>
%N_t =  histcounts(l_form, -2.05:0.1:2.05);
sumh = 0;
for m = 1:size(N_t, 2)
    if ~N_t(m)
        N_t(m) = eps; %avoid issues with log(0) when calling kldiv
    end
    sumh = sumh + N_t(m);
end
alpha = 1 / sumh;
Fc = alpha * N_t;
end