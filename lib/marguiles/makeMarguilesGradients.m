gradVerts = struct;
for g = 1:5
    gradVerts(g).gradient = g;
    gradVerts(g).string = "hcp.embed.grad_"+g;
    left = gifti("hcp.embed.grad_"+g+".L.fsa.func.gii");
    gradVerts(g).L = single(left.cdata);
    right = gifti("hcp.embed.grad_"+g+".L.fsa.func.gii");
    gradVerts(g).R = single(right.cdata);
end
gradVerts = struct2table(gradVerts);
%%
save('marguilesGradients_fsaverage.mat','gradVerts','-v7')