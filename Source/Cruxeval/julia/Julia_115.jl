function f(text::String)::String 
    res = UInt8[]
    for ch in codeunits(text)
        if ch == 61
            break
        elseif ch != 0
            push!(res, ch)
        end
    end
    return "b'$(join([string(x, "; ") for x in res], ""))'"
end
using Test

@testset begin

candidate = f;
	@test(candidate("os||agx5") == "b'111; 115; 124; 124; 97; 103; 120; 53; '")
end
