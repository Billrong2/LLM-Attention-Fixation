function f(text::String)::String 
    a = Char[]
    for i in 1:length(text)
        if !isdigit(text[i])
            push!(a, text[i])
        end
    end
    return join(a, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("seiq7229 d27") == "seiq d")
end
