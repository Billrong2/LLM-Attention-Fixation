function f(text::String, pref::String)::Bool 
    if isa(pref, Vector{String})
        return join([startswith(text, x) for x in pref], ", ")
    else
        return startswith(text, pref)
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("Hello World", "W") == false)
end
