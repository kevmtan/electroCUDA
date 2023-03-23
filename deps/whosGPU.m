function varargout=whosGPU(varargin)
% A WHOS analog for gpuArrays. 
%    
%       whosGPU
%       whosGPU var1 var2 ... varN
%       whosGPU -exact ____
%       S=whosGPU(___)
%
% Anyone who has worked with gpuArray objects through Matlab's Parallel
% Computing Toolbox may have found it frustrating that the whos command
% does not reveal as much information about data size and type for
% gpuArrays as for normal Matlab variables. The whosGPU routine is intended
% as a remedy for this.
%
% This utility will provide WHOS-like output for gpuArray variables in the
% current workspace, but with essentially the same information as if the
% variables were not in gpuArray form. The syntax for the command is highly
% analogous to Matlab's native whos(). Note, however, that any non-gpuArray
% variables queried with the command will be ignored. Some examples are
% given below.
%    
% EXAMPLES:
%    
%    1. Default Output
%    
%     Running the following function
%    
%         function test
%
%             persistent a
%             global b
%     
%             a=gpuArray(ones(500,400,'single')*1i);
%             b=gpuArray.speye(1e6)*1i;
%     
%             whosGPU a b
%
%          end
%    
%     gives the output,
%    
%         Name          Size           Kilobytes     Class             Attributes        
%         ____    _________________    _________    ________    _________________________
%     
%          a       500x400                1563       single      persistent, complex     
%          b       1000000x1000000       39063       double      sparse, global, complex 
%     
%      
%       *Kilobytes shown for sparse variables are approximate.
%    
%    2. Exact Output
%    
%     The kilobytes consumed by sparse variables are approximately calculated
%     in the interest of speed, but a figure agreeing with whos() can be
%     obtained with the syntax,
%     
%          >> whosGPU -exact a b
%    
%         Name          Size           Kilobytes     Class             Attributes        
%         ____    _________________    _________    ________    _________________________
%     
%          a       500x400                1563       single      persistent, complex     
%          b       1000000x1000000       31251       double      sparse, global, complex



sparseExact=false;
if nargin && startsWith(lower(varargin{1}),'-e');
 sparseExact=true;
 varargin(1)=[];
end

if numel(varargin)==0

  cmdstr='whos;';
  s=evalin('caller', cmdstr) ;

else


     in=['''' varargin{1} ''''];

     numargs=length(varargin);

     if numargs>1  
       for ii=2:numargs
         in= [in ',' '''' varargin{ii} ''''];
       end
     end

     cmdstr=['whos(' in  ');'];


     s=evalin('caller', cmdstr) ;

end


s=s({s.class}=="gpuArray" & ~({s.name}=="ans"));
flds=strrep(fieldnames(s),'bytes','kilobytes');

if isempty(s)
   if ~nargout, return; end
   
   tmp=s;
   tmp(1).kilobytes=[];
   s=orderfields(rmfield(tmp,'bytes'),flds);
   s(1)=[];
   varargout={s.'};
   return
end



for i=1:numel(s)
    
    s(i).sparse=evalin('caller', "issparse("+s(i).name+")");
    s(i).complex=evalin('caller', "~isreal("+s(i).name+")");
    
    if s(i).sparse && sparseExact
        
        cpuvar=gather(evalin('caller', s(i).name));
        wvar=whos('cpuvar');
        
        s(i).kilobytes=wvar.bytes/2^10;
        
    elseif s(i).sparse
        
        nz=gather(evalin('caller', "nnz("+s(i).name+")"));
        cl=gather(evalin('caller', "classUnderlying("+s(i).name+")"));

        cpuvar=sparse(1,1,feval(cl,1));
        if s(i).complex, cpuvar=cpuvar+sparse(1i); end
        
        wvar=whos('cpuvar');
       
        s(i).kilobytes=nz*wvar.bytes/2^10;
        
    else

        cpuvar=gather(evalin('caller', s(i).name+"(1)"));
        wvar=whos('cpuvar');
        
        s(i).kilobytes=prod(s(i).size)*wvar.bytes/2^10;
        
        
    end
    
     %s(i).kilobytes=ceil(s(i).kilobytes);
     s(i).class=class(cpuvar);
    
end

s=orderfields(rmfield(s,'bytes'),flds);

if nargout
   varargout={s};
else
    
  for i=1:numel(s)
     
      T(i).Name=string(s(i).name); %#ok<*AGROW>
      
      T(i).Size=join( string(s(i).size) , "x");
      
      T(i).Kilobytes=round(s(i).kilobytes);
      
      T(i).Class=string(s(i).class);
      
      attributes={};
      if s(i).sparse
        attributes=[attributes,'sparse'];
      end
      if s(i).global
        attributes=[attributes,'global'];
      end
      if s(i).persistent
        attributes=[attributes,'persistent'];
      end
      if s(i).complex
        attributes=[attributes,'complex'];
      end
      
      if isempty(attributes),
          attributes="";
          
      else
          attributes=join(string(attributes),", ");
      end
      
      T(i).Attributes=attributes;
      

      
  end
  
  T=struct2table(T,'AsArray',1);
  
 T{:,'Size'}=string(strjust(char(T{:,'Size'}),'center')); %#ok<NASGU>
  
  
  disp ' '
  str=evalc('disp(T)');
  str(str==34)=' ';
  disp(str);
  
  if ~sparseExact && any([s.sparse])
     disp '  *Kilobytes shown for sparse variables are approximate.'
     disp ' '
  end
    
end

