function f(letters::Vector{String})::String 
    a = []
    for i in 1:length(letters)
        if letters[i] in a
            return "no"
        end
        push!(a, letters[i])
    end
    return "yes"
end
using Test

@testset begin

candidate = f;
	@test(candidate(["b", "i", "r", "o", "s", "j", "v", "p"]) == "yes")
end
