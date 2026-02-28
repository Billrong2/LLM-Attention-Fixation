function f(base::Vector{String}, delta::Vector{Vector{Union{String, String}}})::Vector{String} 
    for j in 1:length(delta)
        for i in 1:length(base)
            if base[i] == delta[j][1]
                @assert delta[j][2] != base[i]
                base[i] = delta[j][2]
            end
        end
    end
    return base
end
using Test

@testset begin

candidate = f;
	@test(candidate(["gloss", "banana", "barn", "lawn"], Vector{Vector{String}}([])) == ["gloss", "banana", "barn", "lawn"])
end
