

function seriesTable(tabda, idfield; fmod = x->x)

  fieldvec = [ fmod(x[idfield]) for x in tabda];

  xfields = unique(fieldvec);

  if(size(xfields,1) == size(fieldvec,1)) 

    println("Series in $idfield not found");

    return [];

    end;

  n = size(tabda, 1);

  m = size(xfields,1);

  lookfield = Dict{Any, Int}();

  sizehint!(lookfield, m);

  [lookfield[x] = y for (y,x) in enumerate(xfields)];

  xcounts = zeros(Int, m);

  for i = 1:n

    xcounts[lookfield[fieldvec[i]]] += 1;

    end;

  q = maximum(xcounts);

  series = similar(tabda, m, q); ##Array{NamedTuple}(undef, m, q);

  ##series[:] .= (xundef = true, );

  xcounts[:] .= 0;

  for iter = 1:n

    id = lookfield[fieldvec[iter]];

    series[id, xcounts[id]+1] = tabda[iter];
  
    xcounts[id] += 1;

    end;

  return (series, xcounts);

  end;


function splitTable(tabda, xcounts)

  ret = Array{typeof(tabda[:,1])}(undef, 0); #[];

  n = size(tabda,1);

  for iter = 1:n

    push!(ret, tabda[iter, 1:xcounts[iter]]);

    end;

  return ret;

  end;

