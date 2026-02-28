function f(dictionary::Dict{Int64, Int64})::Dict{Int64, Int64} 
    while !haskey(dictionary, 1)
        empty(dictionary)
        break
    end
    return dictionary
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict(1 => 47698, 1 => 32849, 1 => 38381, 3 => 83607)) == Dict(1 => 38381, 3 => 83607))
end
