function f(dictionary::Dict{String, Int}, key::String)::String 
    delete!(dictionary, key)
    if key == first(sort(collect(keys(dictionary))))
        key = first(keys(dictionary))
    end
    return key
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("Iron Man" => 4, "Captain America" => 3, "Black Panther" => 0, "Thor" => 1, "Ant-Man" => 6), "Iron Man") == "Iron Man")
end
