function f(text::String)::Int64 
    if strip(text) == ""
        return length(strip(text))
    end
    return nothing
end
using Test

@testset begin

candidate = f;
	@test(candidate(" 	 ") == 0)
end
