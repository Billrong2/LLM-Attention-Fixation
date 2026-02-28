function f(text::String)::Bool 
    return count(x -> x == '-', text) == length(text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("---123-4") == false)
end
