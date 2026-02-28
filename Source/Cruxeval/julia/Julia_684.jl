function f(text::String)::String 
    trans = Dict('"'=>'9', '\''=>'8', '>'=>'3', '<'=>'3')
    return join([get(trans, c, c) for c in text])
end
using Test

@testset begin

candidate = f;
	@test(candidate("Transform quotations\"
not into numbers.") == "Transform quotations9
not into numbers.")
end
