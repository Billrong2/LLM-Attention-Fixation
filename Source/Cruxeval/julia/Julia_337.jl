function f(txt::String)::String 
    d = []
    for c in txt
        if isdigit(c)
            continue
        elseif islowercase(c)
            push!(d, uppercase(c))
        elseif isuppercase(c)
            push!(d, lowercase(c))
        end
    end
    return join(d, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("5ll6") == "LL")
end
