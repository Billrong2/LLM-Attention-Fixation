using Base.Iterators: count

function f(names::Vector{String})::Int64 
    count = length(names)
    numberOfNames = 0
    for name in names
        if all(isletter, name)
            numberOfNames += 1
        end
    end
    return numberOfNames
end
using Test

@testset begin

candidate = f;
	@test(candidate(["sharron", "Savannah", "Mike Cherokee"]) == 2)
end
