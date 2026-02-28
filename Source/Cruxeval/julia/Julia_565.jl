function f(text::String)::Int64
    return maximum(findfirst(ch, text) !== nothing ? first(findfirst(ch, text)) - 1 : -1 for ch in "aeiou")
end

using Test

@testset begin

candidate = f;
	@test(candidate("qsqgijwmmhbchoj") == 13)
end
