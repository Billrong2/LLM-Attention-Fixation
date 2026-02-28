function f(string::String)::String
    count_colons = count(c -> c == ':', string)
    if count_colons > 1
        return replace(string, ':' => "", count=count_colons - 1)
    else
        return string
    end
end

using Test

@testset begin

candidate = f;
	@test(candidate("1::1") == "1:1")
end
