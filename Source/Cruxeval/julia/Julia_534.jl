function f(sequence::String, value::String)::String
    i = max(findfirst(value, sequence).start - div(length(sequence), 3), 0)
    result = ""
    for j in enumerate(sequence[i:end])
        if j[2] == '+'
            result *= value
        else
            result *= sequence[i + j[1] - 1]
        end
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate("hosu", "o") == "hosu")
end
