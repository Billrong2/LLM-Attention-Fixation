function f(c::Dict{String, Int}, st::Int, ed::Int)::Tuple{String, String}
    d = Dict{Int, String}()
    a, b = 0, 0
    for (x, y) in c
        d[y] = x
        if y == st
            a = x
        end
        if y == ed
            b = x
        end
    end
    w = d[st]
    return a > b ? (w, d[ed]) : (d[ed], w)
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("TEXT" => 7, "CODE" => 3), 7, 3) == ("TEXT", "CODE"))
end
