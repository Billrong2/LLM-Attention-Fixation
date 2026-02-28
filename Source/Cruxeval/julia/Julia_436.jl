function f(s::String, characters::Vector{Int64})::Vector{String} 
    return [SubString(s, i, i) for i in characters .+ 1]
end

using Test

@testset begin

candidate = f;
	@test(candidate("s7 6s 1ss", [1, 3, 6, 1, 2]) == ["7", "6", "1", "7", " "])
end
