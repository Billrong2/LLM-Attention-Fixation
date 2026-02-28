function f(dic::Dict{String, Int64}, key::String)::Union{String, Int64}
    dic = copy(dic)
    v = get(dic, key, 0)
    if v == 0
        return "No such key!"
    end
    while length(dic) > 0
        k, v = popitem(dic)
        dic[v] = k
    end
    k, v = popitem(dic)
    return parse(Int64, k)
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("did" => 0), "u") == "No such key!")
end
