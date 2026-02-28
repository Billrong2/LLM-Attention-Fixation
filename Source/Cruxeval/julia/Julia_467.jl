function f(nums::Dict{String, String})::Dict{String, Int64}
    copy = deepcopy(nums)
    newDict = Dict{String, Int64}()
    for k in keys(copy)
        newDict[k] = length(copy[k])
    end
    return newDict
end

using Test

@testset begin

candidate = f;
	@test(candidate(Dict{String, String}()) == Dict{String, Int64}())
end
