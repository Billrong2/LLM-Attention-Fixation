function f(messages::Vector{Vector{String}})::String 
    phone_code = "+353"
    result = []
    for message in messages
        append!(message, split(phone_code, ""))
        push!(result, join(message, ";"))
    end
    return join(result, ". ")
end
using Test

@testset begin

candidate = f;
	@test(candidate([["Marie", "Nelson", "Oscar"]]) == "Marie;Nelson;Oscar;+;3;5;3")
end
