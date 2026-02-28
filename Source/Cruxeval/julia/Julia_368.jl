function f(string::String, numbers::Vector{Int64})::String 
    arr = [lpad(string, n, '0') for n in numbers]
    return join(arr, ' ')
end
using Test

@testset begin

candidate = f;
	@test(candidate("4327", [2, 8, 9, 2, 7, 1]) == "4327 00004327 000004327 4327 0004327 4327")
end
