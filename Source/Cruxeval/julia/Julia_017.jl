function f(text::String)::Int64 
    return findfirst(',', text) == nothing ? -1 : findfirst(',', text) - 1
end
using Test

@testset begin

candidate = f;
	@test(candidate("There are, no, commas, in this text") == 9)
end
