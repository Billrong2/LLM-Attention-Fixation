function f(title::String)::String 
    return lowercase(title)
end
using Test

@testset begin

candidate = f;
	@test(candidate("   Rock   Paper   SCISSORS  ") == "   rock   paper   scissors  ")
end
