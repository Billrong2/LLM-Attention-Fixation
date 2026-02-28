function f(text::String, c::String)::String
    ls = collect(text)
    if !occursin(c, text)
        throw(ArgumentError("Text has no $c"))
    end
    idx = findlast(x -> x == c[1], ls)
    if idx !== nothing
        deleteat!(ls, idx)
    end
    return join(ls)
end

using Test

@testset begin

candidate = f;
	@test(candidate("uufhl", "l") == "uufh")
end
