is_valid_identifier(s::AbstractString) = all(isletter(c) || c in ['_', '!'] for c in s)

function f(text::String)::String 
    if is_valid_identifier(text)
        return join(c for c in text if isdigit(c))
    else
        return join(text)
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("816") == "816")
end
