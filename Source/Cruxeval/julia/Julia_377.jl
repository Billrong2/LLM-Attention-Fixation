function f(text::String)::String 
    return join(split(text, '\n'), ", ")
end
using Test

@testset begin

candidate = f;
	@test(candidate("BYE
NO
WAY") == "BYE, NO, WAY")
end
