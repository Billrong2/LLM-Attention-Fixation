function f(dct::Dict{String, String})::Dict{String, String}
    result = Dict{String, String}()
    for value in values(dct)
        item = split(value, '.')[1] * "@pinc.uk"
        result[value] = item
    end
    return result
end

using Test

@testset begin

candidate = f;
	@test(candidate(Dict{String, String}()) == Dict{String, String}())
end
