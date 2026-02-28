function f(names::Vector{String}, excluded::String)::Vector{String} 
    for i in 1:length(names)
        if occursin(excluded, names[i])
            names[i] = replace(names[i], excluded => "")
        end
    end
    return names
end
using Test

@testset begin

candidate = f;
	@test(candidate(["avc  a .d e"], "") == ["avc  a .d e"])
end
