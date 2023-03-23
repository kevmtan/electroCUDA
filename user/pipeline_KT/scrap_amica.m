[n,x,psy,trialNfo,chNfo] = ec_loadSbj("Kevin_DMN",sbj="S12_38_LK",proj="MMR");
ch_bad = chNfo.bad;

%%
[A,c,LL,Lt,gm,alpha,mu,beta,rho] = ec_amica(x(:,ch_bad.ica)');