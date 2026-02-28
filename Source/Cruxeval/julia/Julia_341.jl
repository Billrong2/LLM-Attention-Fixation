function f(cart::Dict{Int64, Int64})::Dict{Int64, Int64}
    while length(cart) > 5
        delete!(cart, first(keys(cart)))
    end
    return cart
end

using Test

@testset begin

candidate = f;
	@test(candidate(Dict{Int64, Int64}()) == Dict{Int64, Int64}())
end
