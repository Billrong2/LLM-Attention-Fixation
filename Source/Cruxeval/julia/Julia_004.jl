function f(array::Vector{String})::String 
    s = ' '
    s *= join(array)
    return s
end
using Test

@testset begin

candidate = f;
	@test(candidate([" ", "  ", "    ", "   "]) == "           ")
end
