function f(doc::String)::String
    for x in doc
        if isletter(x)
            return uppercase(string(x))
        end
    end
    return "-"
end

using Test

@testset begin

candidate = f;
	@test(candidate("raruwa") == "R")
end
