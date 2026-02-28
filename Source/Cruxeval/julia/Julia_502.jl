function f(name::String)::String 
    return join(split(name, " "), "*")
end
using Test

@testset begin

candidate = f;
	@test(candidate("Fred Smith") == "Fred*Smith")
end
