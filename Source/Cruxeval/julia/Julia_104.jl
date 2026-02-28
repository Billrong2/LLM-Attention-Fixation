function f(text::String)::Dict{String, Int64}
    dic = Dict()
    for char in text
        dic[string(char)] = get(dic, string(char), 0) + 1
    end
    for key in keys(dic)
        if dic[key] > 1
            dic[key] = 1
        end
    end
    return dic
end
using Test

@testset begin

candidate = f;
	@test(candidate("a") == Dict("a" => 1))
end
