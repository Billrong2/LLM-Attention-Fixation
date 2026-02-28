function f(text::String)::String 
    ls = collect(text)
    for x in reverse(eachindex(ls))
        if length(ls) <= 1
            break
        end
        if !(ls[x] in ['z', 'y', 'x', 'w', 'v', 'u', 't', 's', 'r', 'q', 'p', 'o', 'n', 'm', 'l', 'k', 'j', 'i', 'h', 'g', 'f', 'e', 'd', 'c', 'b', 'a'])
            splice!(ls, x)
        end
    end
    return join(ls, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("qq") == "qq")
end
