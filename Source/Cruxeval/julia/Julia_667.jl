function f(text::String)::Vector{String} 
    new_text = []
    for i in 1:div(length(text), 3)
        push!(new_text, "< $(text[(i-1)*3+1:i*3]) level=$(i-1) >")
    end
    last_item = text[div(length(text), 3)*3+1:end]
    push!(new_text, "< $last_item level=$(div(length(text), 3)) >")
    return new_text
end
using Test

@testset begin

candidate = f;
	@test(candidate("C7") == ["< C7 level=0 >"])
end
