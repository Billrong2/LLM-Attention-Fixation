function f(text::String, characters::String)::String 
    character_list = collect(characters) |> (x -> push!(x, ' ', '_'))
    
    i = 1
    while i <= length(text) && in(text[i], character_list)
        i += 1
    end
    
    return text[i:end]
end
using Test

@testset begin

candidate = f;
	@test(candidate("2nm_28in", "nm") == "2nm_28in")
end
