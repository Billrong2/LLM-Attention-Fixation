function f(album_sales::Vector{Int64})::Int64 
    while length(album_sales) != 1
        push!(album_sales, shift!(album_sales))
    end
    return album_sales[1]
end
using Test

@testset begin

candidate = f;
	@test(candidate([6]) == 6)
end
