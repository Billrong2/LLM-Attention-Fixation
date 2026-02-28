function f(sb::String)::Dict{String, Int64} 
    d = Dict{String, Int64}()
    for s in sb
        d[string(s)] = get(d, string(s), 0) + 1
    end
    return d
end
using Test

@testset begin

candidate = f;
	@test(candidate("meow meow") == Dict("m" => 2, "e" => 2, "o" => 2, "w" => 2, " " => 1))
end
