function f(array::Vector{Int64})::Vector{Int64} 
    prev = array[1]
    newArray = copy(array)
    for i in 2:length(array)
        if prev != array[i]
            newArray[i] = array[i]
        else
            deleteat!(newArray, i)
        end
        prev = array[i]
    end
    return newArray
end
using Test

@testset begin

candidate = f;
	@test(candidate([1, 2, 3]) == [1, 2, 3])
end
