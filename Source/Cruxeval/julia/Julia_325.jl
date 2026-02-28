function f(s::String)::Bool 
    l = collect(s)
    for i in 1:length(l)
        l[i] = lowercase(l[i])
        if !isdigit(l[i])
            return false
        end
    end
    return true
end
using Test

@testset begin

candidate = f;
	@test(candidate("") == true)
end
