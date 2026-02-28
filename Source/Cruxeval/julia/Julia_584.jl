function f(txt::String)::String 
    return txt
end
using Test

@testset begin

candidate = f;
	@test(candidate("5123807309875480094949830") == "5123807309875480094949830")
end
