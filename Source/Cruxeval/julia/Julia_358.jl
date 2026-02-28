function f(text::String, value::String)::String
    indexes = Int64[]
    for i in 1:length(text)
        if text[i] == value[1] && (i == 1 || text[i-1] != value[1])
            push!(indexes, i)
        end
    end
    if length(indexes) % 2 != 0
        return text
    else
        return text[indexes[1]+1:indexes[end]-1]
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("btrburger", "b") == "tr")
end
