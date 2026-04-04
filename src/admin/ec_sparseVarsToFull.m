function T = ec_sparseVarsToFull(T)

T = convertvars(T,varfun(@issparse,T,OutputFormat="uniform"),"full");