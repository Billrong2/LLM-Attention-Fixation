function f(a::Int64)::Union{Vector{Int64}, Int64} 
    if a == 0
        return [0]
    end
    
    result = []
    while a > 0
        push!(result, a % 10)
        a = div(a, 10)
    end
    reverse!(result)
    
    return parse(Int, join(string(i) for i in result))
end
using Test

@testset begin

candidate = f;
	@test(candidate(0) == [0])
end
