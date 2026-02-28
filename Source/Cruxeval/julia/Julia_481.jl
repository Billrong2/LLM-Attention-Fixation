function f(values::Vector{Int64}, item1::Int64, item2::Int64)::Vector{Int64} 
    if values[end] == item2
        if !(values[1] in values[2:end])
            push!(values, values[1])
        end
    elseif values[end] == item1
        if values[1] == item2
            push!(values, values[1])
        end
    end
    return values
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 1], 2, 3) == [1, 1])
end
