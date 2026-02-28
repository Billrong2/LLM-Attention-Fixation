function f(items::Vector{String}, target::String)::Int64
    if target in items
        return findfirst(isequal(target), items) - 1
    end
    return -1
end
using Test

@testset begin

candidate = f;
	@test(candidate(["1", "+", "-", "**", "//", "*", "+"], "**") == 3)
end
