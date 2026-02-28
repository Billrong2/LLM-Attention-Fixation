function f(a::String, b::String)::Tuple{String, String} 
    if a < b
        return (b, a)
    else
        return (a, b)
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("ml", "mv") == ("mv", "ml"))
end
