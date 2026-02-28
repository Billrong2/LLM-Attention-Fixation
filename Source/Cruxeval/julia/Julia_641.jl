function f(number::String)::Bool 
    return all(isdigit, number)
end
using Test

@testset begin

candidate = f;
	@test(candidate("dummy33;d") == false)
end
