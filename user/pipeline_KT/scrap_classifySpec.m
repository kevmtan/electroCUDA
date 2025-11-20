c0 = load("s38_classifySpec_230622_ic.mat");
c1 = load("s38_classifySpec_230622h_ic.mat");

a0=c0.ra; a1=c1.ra; 
t0=c0.rt; t1=c1.rt;

ra=a0; ra=a1;
rt=t0; rt=t1;



%%
ch = 104;
a = ra(ra.ch==ch,:);
a.condC = categorical(a.cond,["Semantic" "Episodic" "Self" "Other"],"Ordinal",true);
a_s = grpstats(a,["condC" "frame"],["mean" "sem" "median"],DataVars=["acc" "ppa" "ppd"]);
a.accBL = a.acc - mean(a.acc(a.pct<0)) + 0.5;

t = rt(rt.ch==ch,:);
t.acc2 = t.acc - abs(1-t.wt(:,1));
t.acc3 = mean(t.accCV,2,"omitmissing");
t.accBL = t.acc - mean(t.acc(t.pct2<0)) + 0.5;

%% Percent RT
g = gramm(x=double(a.pct),y=double(a.acc),subset=a.in);
g = g.stat_summary(bin_in=120,type="fitbinomialci");
figure; g.draw

g = gramm(x=double(a.pct),y=double(a.acc),color=a.condC,subset=a.in);
g = g.stat_summary(bin_in=120,type="fitbinomialci");
figure; g.draw

g = gramm(x=double(a.pct),y=double(a.ppd),color=a.condC);
g = g.stat_summary(bin_in=120);
figure; g.draw


% g = gramm(x=double(r.pct),y=double(r.ppd),color=r.condC,subset=r.in);
% g = g.stat_summary(bin_in=120);
% figure; g.draw
% 
% g = gramm(x=double(r.pct),y=double(r.ppd),color=r.condC,subset=r.inx);
% g = g.stat_summary(bin_in=120);
% figure; g.draw


%% Latency

g = gramm(x=double(a.bin),y=double(a.acc),...
    subset=a.in & a.latency>-201 & a.latency<=3000);
g = g.stat_summary(type="fitbinomialci");
figure; g.draw

g = gramm(x=double(a.bin),y=double(a.pred)-1,color=a.condC,...
    subset=a.latency>-201 & a.latency<3000);
g = g.stat_summary(type="fitbinomialci");
figure; g.draw

g = gramm(x=double(a.bin),y=double(a.ppd),color=a.condC,...
    subset=a.latency>-201 & a.latency<3000);
g = g.stat_summary(type="fitbinomialci");
figure; g.draw

% g = gramm(x=double(a.bin),y=double(a.ppd),color=a.condC,...
%     subset=a.in & a.latency>-201 & a.latency<3000);
% g = g.stat_summary();
% figure; g.draw
% 
% g = gramm(x=double(a.bin),y=double(a.ppd),color=a.condC,...
%     subset=a.inx & a.latency>-201 & a.latency<3000);
% g = g.stat_summary();
% figure; g.draw



%%
ac = a;
ac.x = squeeze(x(:,53,:));
ac = ac(ac.in & ac.pct==20,:);