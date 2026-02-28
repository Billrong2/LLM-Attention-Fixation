function f()::Vector{String}
    d = Dict(
        "Russia" => [("Moscow", "Russia"), ("Vladivostok", "Russia")],
        "Kazakhstan" => [("Astana", "Kazakhstan")]
    )
    return ["Russia", "Kazakhstan"]
end

using Test

@testset begin

candidate = f;
	@test(candidate() == ["Russia", "Kazakhstan"])
end
