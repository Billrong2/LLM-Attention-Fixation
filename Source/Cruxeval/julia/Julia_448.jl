function f(text::String, suffix::String)::Bool 
    if suffix == ""
        suffix = nothing
    end
    return endswith(text, suffix)
end
using Test

@testset begin

candidate = f;
	@test(candidate("uMeGndkGh", "kG") == false)
end
