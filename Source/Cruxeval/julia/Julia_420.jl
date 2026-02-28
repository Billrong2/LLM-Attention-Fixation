function f(text::String)::Bool 
    try
        return occursin(r"^[a-zA-Z]+$", text)
    catch
        return false
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("x") == true)
end
