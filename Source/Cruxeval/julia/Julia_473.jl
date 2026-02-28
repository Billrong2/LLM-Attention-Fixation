function f(text::String, value::String)::String
    indexes = Int[]
    for i in 1:length(text)
        if text[i] == value[1]
            push!(indexes, i)
        end
    end
    new_text = collect(text)
    for i in reverse(indexes)
        deleteat!(new_text, i)
    end
    return join(new_text, "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("scedvtvotkwqfoqn", "o") == "scedvtvtkwqfqn")
end
