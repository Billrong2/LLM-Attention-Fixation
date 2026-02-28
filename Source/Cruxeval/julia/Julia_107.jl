function f(text::String)::String
    result = []
    for i in text
        if isletter(i) || isdigit(i)
            push!(result, uppercase(i))
        else
            push!(result, i)
        end
    end
    return join(result)
end

using Test

@testset begin

candidate = f;
	@test(candidate("ua6hajq") == "UA6HAJQ")
end
