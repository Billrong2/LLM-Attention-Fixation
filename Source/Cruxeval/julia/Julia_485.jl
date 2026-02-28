function f(tokens::String)::String 
    tokens = split(tokens)
    if length(tokens) == 2
        tokens = reverse(tokens)
    end
    result = join([rpad(tokens[1], 5), rpad(tokens[2], 5)], " ")
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate("gsd avdropj") == "avdropj gsd  ")
end
