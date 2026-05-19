oa.analDir = "/01/lbcn/anal/classifySpecROI/zf_hpf_SemEpi_LDA_nestedGammaDelta";
oa.timeVar = "bin";


%%
[o,logs,sts] = mmr_cSpecLoad(oa);

sts.sbjID = string(sts.sbjID);


%%
h = figure(Position=[0 0 900 1200],Visible=false,Theme="light",Color="w");

clear g

ch = "Visual";
id = ismember(sts.ch,ch);
g(1,1) = gramm(x=sts.time(id),y=sts.acc(id),color=sts.sbjID(id));
g(1,1).geom_line();
g(1,1).set_names('x','Time (ms)','y','Accuracy','color','Subject');
g(1,1).set_title(ch);

ch = "TPJ";
id = ismember(sts.ch,ch);
g(1,2) = gramm(x=sts.time(id),y=sts.acc(id),color=sts.sbjID(id));
g(1,2).geom_line();
g(1,2).set_names('x','Time (ms)','y','Accuracy','color','Subject');
g(1,2).set_title(ch);

ch = "PCC";
id = ismember(sts.ch,ch);
g(2,1) = gramm(x=sts.time(id),y=sts.acc(id),color=sts.sbjID(id));
g(2,1).geom_line();
g(2,1).set_names('x','Time (ms)','y','Accuracy','color','Subject');
g(2,1).set_title(ch);

ch = "ATL";
id = ismember(sts.ch,ch);
g(2,2) = gramm(x=sts.time(id),y=sts.acc(id),color=sts.sbjID(id));
g(2,2).geom_line();
g(2,2).set_names('x','Time (ms)','y','Accuracy','color','Subject');
g(2,2).set_title(ch);

ch = "amPFC";
id = ismember(sts.ch,ch);
g(3,1) = gramm(x=sts.time(id),y=sts.acc(id),color=sts.sbjID(id));
g(3,1).geom_line();
g(3,1).set_names('x','Time (ms)','y','Accuracy','color','Subject');
g(3,1).set_title(ch);

ch = "dmPFC";
id = ismember(sts.ch,ch);
g(3,2) = gramm(x=sts.time(id),y=sts.acc(id),color=sts.sbjID(id));
g(3,2).geom_line();
g(3,2).set_names('x','Time (ms)','y','Accuracy','color','Subject');
g(3,2).set_title(ch);

ch = "vmPFC";
id = ismember(sts.ch,ch);
g(4,1) = gramm(x=sts.time(id),y=sts.acc(id),color=sts.sbjID(id));
g(4,1).geom_line();
g(4,1).set_names('x','Time (ms)','y','Accuracy','color','Subject');
g(4,1).set_title(ch);

g.set_layout_options("redraw",true,"redraw_gap",0.02);
g.set_text_options("base_size",8,"legend_title_scaling",1);
g.draw();


fn = oa.analDir+filesep+"sbjAcc.jpg";
print(h,fn,"-djpeg","-r150");
disp("SAVED: "+fn);
