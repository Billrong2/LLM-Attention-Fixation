function f(text::String)::Vector{Int64} 
    occ = Dict{Char, Int}()
    for ch in text
        name = Dict('a' => 'b', 'b' => 'c', 'c' => 'd', 'd' => 'e', 'e' => 'f')
        name = get(name, ch, ch)
        occ[name] = get(occ, name, 0) + 1
    end
    return [x for x in values(occ)]
end
using Test

@testset begin

candidate = f;
	@test(candidate("URW rNB") == [1, 1, 1, 1, 1, 1, 1])
end
