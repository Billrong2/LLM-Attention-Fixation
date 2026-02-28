function f(text::String, chunks::Int64)::Vector{String} 
    return split(text, '\n', limit=chunks, keepempty=false)
end
using Test

@testset begin

candidate = f;
	@test(candidate("/alcm@ an)t//eprw)/e!/d
ujv", 0) == ["/alcm@ an)t//eprw)/e!/d", "ujv"])
end
