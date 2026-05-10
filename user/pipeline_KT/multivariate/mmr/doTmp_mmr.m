
do_classifySpecCh;
clear all; close all;

doTmp_50ms_SemEpi_LDA_pcaGamma;
clear all; close all;

doTmp_50ms_MathAb_LDA_bandsGamma;
clear all; close all;

doTmp_50ms_MathAb_LDA_pcaGamma;
clear all; close all;

do_cSpecPlot_ch;
try delete(gcp("nocreate")); catch;end

quit;