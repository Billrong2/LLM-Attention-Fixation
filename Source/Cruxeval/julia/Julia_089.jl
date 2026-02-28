function f(char::String)::Union{String,Nothing}
    if char[1] ∉ ('a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U')
        return nothing
    end
    if char[1] ∈ ('A', 'E', 'I', 'O', 'U')
        return lowercase(char)
    end
    return uppercase(char)
end
using Test

@testset begin

candidate = f;
	@test(candidate("o") == "O")
end
