function f(a::String)::Vector{String} 
    a = replace(a, "/" => ":")
    z = rsplit(a, ":", limit=2)
    if length(z) == 1
        return [z[1], "", ""]
    else
        return [z[1], ":", z[2]]
    end
end

using Test

@testset begin

candidate = f;
	@test(candidate("/CL44     ") == ["", ":", "CL44     "])
end
