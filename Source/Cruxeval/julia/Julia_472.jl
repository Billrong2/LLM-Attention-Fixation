function f(text::String)::Vector{Int64} 
    d = Dict{Char, Int64}()
    for char in lowercase(replace(text, "-" => ""))
        d[char] = get(d, char, 0) + 1
    end
    d = sort(collect(d), by=x->x[2])
    return [val for (key, val) in d]
end
using Test

@testset begin

candidate = f;
	@test(candidate("x--y-z-5-C") == [1, 1, 1, 1, 1])
end
