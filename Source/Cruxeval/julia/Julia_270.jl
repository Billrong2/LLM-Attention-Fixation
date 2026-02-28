function f(dic::Dict{Int64, Int64})::Dict{Int64, Int64}
    d = Dict{Int64, Int64}()
    keys_list = collect(keys(dic))
    for key in keys_list
        first_key = first(keys(dic))
        d[key] = dic[first_key]
        delete!(dic, first_key)
    end
    return d
end

using Test

@testset begin

candidate = f;
	@test(candidate(Dict{Int64, Int64}()) == Dict{Int64, Int64}())
end
