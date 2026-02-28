using Base.Iterators: all

function f(s::String)::String 
    if all(isletter, s)
        return "yes"
    end
    if s == ""
        return "str is empty"
    end
    return "no"
end
using Test

@testset begin

candidate = f;
	@test(candidate("Boolean") == "yes")
end
