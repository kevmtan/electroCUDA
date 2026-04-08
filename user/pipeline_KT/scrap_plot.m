
id = ismember(st.ch,["TPJ" "PCC" "dmPFC"]);

figure;
clear g
g(1,1) = gramm(x=st.bin,y=st.acc,color=st.ch);
g(1,1).geom_line();
g.draw();