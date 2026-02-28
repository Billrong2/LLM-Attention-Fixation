function f(s::String)::String 
    if occursin(r"^[a-zA-Z0-9]*$", s)
        return "True"
    else
        return "False"
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("777") == "True")
end
