function f(text::String)::Bool 
    return !any(c -> isuppercase(c), text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("lunabotics") == true)
end
