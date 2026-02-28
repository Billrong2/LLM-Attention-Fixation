function f(n::String)::String 
    revn = collect(n)
    result = join(revn, "")
    return result * "!"^(length(result) + 2)
end

using Test

@testset begin

candidate = f;
	@test(candidate("iq") == "iq!!!!")
end
