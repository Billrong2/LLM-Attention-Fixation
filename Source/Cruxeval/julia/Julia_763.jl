function f(values::String, text::String, markers::String)::String
    return rstrip(rstrip(text, collect(values)), collect(markers))
end
using Test

@testset begin

candidate = f;
	@test(candidate("2Pn", "yCxpg2C2Pny2", "") == "yCxpg2C2Pny")
end
