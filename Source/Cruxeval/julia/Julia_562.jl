function f(text::String)::Bool 
    return uppercase(text) == text
end
using Test

@testset begin

candidate = f;
	@test(candidate("VTBAEPJSLGAHINS") == true)
end
