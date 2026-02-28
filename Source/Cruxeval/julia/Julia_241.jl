function f(postcode::String)::String 
    return postcode[findfirst(isequal('C'), postcode):end]
end
using Test

@testset begin

candidate = f;
	@test(candidate("ED20 CW") == "CW")
end
