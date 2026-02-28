function f(text::String)::String 
    return replace(text, '\n' => '\t')
end
using Test

@testset begin

candidate = f;
	@test(candidate("apples
	
pears
	
bananas") == "apples			pears			bananas")
end
