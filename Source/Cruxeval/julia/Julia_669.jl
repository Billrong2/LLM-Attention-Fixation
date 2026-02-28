function f(t::String)::String 
    parts = split(t, '-')
    a = join(parts[1:end-1], '-')
    b = parts[end]
    if length(b) == length(a)
        return "imbalanced"
    end
    return a * replace(b, "-" => "")
end
using Test

@testset begin

candidate = f;
	@test(candidate("fubarbaz") == "fubarbaz")
end
