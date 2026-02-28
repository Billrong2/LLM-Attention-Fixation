function f(forest::String, animal::String)::String
    index = findfirst(==('m'), forest)
    if index === nothing
        return forest
    end
    index = index[1]
    result = collect(forest)
    while index < length(forest)
        if index < length(forest)
            result[index] = forest[index + 1]
        end
        index += 1
    end
    if index == length(forest)
        result[index] = '-'
    end
    return join(result)
end

using Test

@testset begin

candidate = f;
	@test(candidate("2imo 12 tfiqr.", "m") == "2io 12 tfiqr.-")
end
