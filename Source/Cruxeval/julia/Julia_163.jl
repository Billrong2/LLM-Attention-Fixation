function f(text::String, space_symbol::String, size::Int64)::String 
    spaces = repeat(space_symbol, size - length(text))
    return text * spaces
end
using Test

@testset begin

candidate = f;
	@test(candidate("w", "))", 7) == "w))))))))))))")
end
