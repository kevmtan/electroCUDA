function [st,ob] = mmr_cSpecPrep(st,ob,o)
%%% Add extra vars in ec_classifyPrep for MMR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
svars = string(st.Properties.VariableNames);
f0 = cast(nan,o.floatAnal);

% Add categorical for CC conds
if o.doCC
    ob.cx = categorical(string(ob.cnd),o.p.condx,Ordinal=true);
    ob = movevars(ob,"cx",After="cc");
end

% Remove "none" for response - did it in epochPsy
%ob.resp = removecats(ob.resp,"none");


%% Regression on PP

% Behav response time
st.ppr_RT(:) = f0;
st.ppr_RT_SE(:) = f0;
st.ppr_RT_p(:) = f0;
st.ppr_RT_q(:) = f0;
% Behavioral response choice
st.ppr_RC(:) = f0;
st.ppr_RC_SE(:) = f0;
st.ppr_RC_p(:) = f0;
st.ppr_RC_q(:) = f0;


%% Regression on CC PP
if o.doCC && ~ismember("ppxr_RT",svars)
    % Behav response time
    st.ppxr_RT(:) = f0;
    st.ppxr_RT_SE(:) = f0;
    st.ppxr_RT_p(:) = f0;
    st.ppxr_RT_q(:) = f0;
    % Behavioral response choice
    st.ppxr_RC(:) = f0;
    st.ppxr_RC_SE(:) = f0;
    st.ppxr_RC_p(:) = f0;
    st.ppxr_RC_q(:) = f0;
    % Affective valence
    st.ppxr_val(:) = f0;
    st.ppxr_val_SE(:) = f0;
    st.ppxr_val_p(:) = f0;
    st.ppxr_val_q(:) = f0;
end

% Move added vars
stAddVars = setdiff(st.Properties.VariableNames,svars,"stable");
st = movevars(st,stAddVars,Before="n0");
