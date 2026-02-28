function f(text::String, delim::String)::String 
    parts = split(text, delim)
    return parts[2] * delim * parts[1]
end
using Test

@testset begin

candidate = f;
	@test(candidate("bpxa24fc5.", ".") == ".bpxa24fc5")
end
