
module qTab

function xcodegen(labels)

  ob = "(";
  cb = ")";
  xstr = "" * ob;
  for (i, j) in enumerate(labels)
    xstr = xstr * j * " = datar[$(i)], ";
    end;
  xstr = xstr[1:end-2] * cb;
  return xstr;
  end;


function qfunc(header)

  dataexec = xcodegen(header);
  myf = eval(Meta.parse(" function (datar) \n" * dataexec * "\n end;"));
  return myf;
  end; 


function quickTable(data, xfun)

  ret = [ xfun(data[i, :]) for i in 1:size(data,1)];  
  return ret;
  end;

function quickTable(data) 
  
  x = qfunc(data[1, :]);
  return Base.invokelatest(quickTable, data, x);
  end;


export quickTable, qfunc;

end # module
