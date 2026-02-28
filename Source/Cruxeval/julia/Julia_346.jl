function f(filename::String)::Bool 
    suffix = split(filename, '.')[end]
    f2 = filename * reverse(suffix)
    return endswith(f2, suffix)
end
using Test

@testset begin

candidate = f;
	@test(candidate("docs.doc") == false)
end
