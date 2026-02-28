function f(text::String, use::String)::String 
    return replace(text, use => "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("Chris requires a ride to the airport on Friday.", "a") == "Chris requires  ride to the irport on Fridy.")
end
