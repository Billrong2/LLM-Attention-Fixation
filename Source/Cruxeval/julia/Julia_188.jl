function f(strings::Vector{String})::Vector{String}
    new_strings = String[]
    for string in strings
        first_two = string[1:min(2, end)]
        if startswith(first_two, 'a') || startswith(first_two, 'p')
            push!(new_strings, first_two)
        end
    end
    return new_strings
end

using Test

@testset begin

candidate = f;
	@test(candidate(["a", "b", "car", "d"]) == ["a"])
end
