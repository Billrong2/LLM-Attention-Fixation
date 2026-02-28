function f(names::Vector{String})::String 
    if names == []
        return ""
    end
    smallest = names[1]
    for name in names[2:end]
        if name < smallest
            smallest = name
        end
    end
    deleteat!(names, findfirst(x -> x == smallest, names))
    return join(smallest)
end
using Test

@testset begin

candidate = f;
	@test(candidate(Vector{String}([])) == "")
end
