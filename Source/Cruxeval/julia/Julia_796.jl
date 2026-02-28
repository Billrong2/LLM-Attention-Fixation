function f(str::String, toget::String)::String 
    if startswith(str, toget)
        return str[length(toget) + 1:end]
    else
        return str
    end
end
using Test

@testset begin

candidate = f;
	@test(candidate("fnuiyh", "ni") == "fnuiyh")
end
