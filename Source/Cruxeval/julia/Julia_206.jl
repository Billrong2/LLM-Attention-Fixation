function f(a::String)::String 
    return join(split(a), " ")
end
using Test

@testset begin

candidate = f;
	@test(candidate(" h e l l o   w o r l d! ") == "h e l l o w o r l d!")
end
