function f(text::String)::Bool 
    return !occursin(r"^\d+$", text)
end
using Test

@testset begin

candidate = f;
	@test(candidate("the speed is -36 miles per hour") == true)
end
