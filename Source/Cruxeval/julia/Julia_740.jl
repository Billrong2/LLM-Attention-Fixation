function f(plot::Vector{Int64}, delin::Int64)::Vector{Int64} 
    if delin in plot
        split = findfirst(x -> x == delin, plot)
        first = plot[1:split-1]
        second = plot[split+1:end]
        return vcat(first, second)
    else
        return plot
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 3, 4], 3) == [1, 2, 4])
end
