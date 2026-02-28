function f(s::String, c1::String, c2::String)::String 
    if s == ""
        return s
    end
    
    ls = split(s, c1)
    for (index, item) in enumerate(ls)
        if occursin(c1, item)
            ls[index] = replace(item, c1 => c2, count=1)
        end
    end
    
    return join(ls, c1)
end
using Test

@testset begin

candidate = f;
	@test(candidate("", "mi", "siast") == "")
end
