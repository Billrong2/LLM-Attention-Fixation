function f(text::String, sub::String)::Vector{Int64}
    index = Int[]
    starting = 1
    while true
        starting = findnext(sub, text, starting)
        if isnothing(starting)
            break
        else
            push!(index, starting.start - 1)
            starting += length(sub)
        end
    end
    return index
end
using Test

@testset begin

candidate = f;
	@test(candidate("egmdartoa", "good") == Vector{Int64}([]))
end
