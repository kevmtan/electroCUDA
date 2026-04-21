figure;
clear g
g(1,1) = gramm(x=st.bin,y=st.acc,color=st.ch);
g(1,1).geom_line();
g.draw();


%%
id = ismember(st.ch,["TPJ" "PCC" "dmPFC"]);

figure; 
clear g
g(1,1) = gramm(x=st.t(id),y=st.acc(id),color=st.ch(id));
g(1,1).geom_line();
g.draw();

%%
x1 = x{3}(:,99); %x(:,92,6); %x(:,92,53); %x(:,104,53); %x{3}(:,99);

clear g
figure; 
%g(1,1) = gramm(x=psy.frame,y=x1,color=psy.cond);
g(1,1) = gramm(x=ep.t,y=x1,color=ep.cnd);
g(1,1).stat_summary(type="sem",geom="area");
g.draw();

%%
x1 = x(:,92,6);
ep.x = x1;

gs = grpstats(ep,["cnd" "t"],["mean" "sem"],DataVars="x");


%% All-subjects plot
id = sta.ch=="dmPFC";

clear g
figure;
g(1,1) = gramm(x=sta.t(id),y=sta.ppc1(id));
g(1,1).stat_summary(type="sem",geom="area");
g.draw();

%%
id = oba.ch=="dmPFC";

clear g
figure;
g(1,1) = gramm(x=oba.t(id),y=oba.pp1(id),color=oba.cnd(id));
g(1,1).stat_summary(type="sem",geom="area");
g.draw();


%%
clear g
figure;
g(1,1) = gramm(x=stat.t,y=stat.acc,color=stat.roi);
g(1,1).geom_line();
g.draw();


%%
id = stat.roi=="PCC";

clear g
figure;
g(1,1) = gramm(x=stat.t(id),y=stat.accl(id));
g(1,1).geom_line();
g.draw();


%%
clear g
figure; 
g(1,1) = gramm(x=stat.t,y=stat.acc,color=stat.roi);
g(1,1).geom_line();
g.draw();