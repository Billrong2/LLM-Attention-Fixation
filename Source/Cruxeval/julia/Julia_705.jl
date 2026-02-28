function f(cities::Vector{String}, name::String)::Vector{String} 
    if name == ""
        return cities
    end
    
    if name != "" && name != "cities"
        return String[]
    end
    
    return [name * city for city in cities]
end
using Test

@testset begin

candidate = f;
	@test(candidate(["Sydney", "Hong Kong", "Melbourne", "Sao Paolo", "Istanbul", "Boston"], "Somewhere ") == Vector{String}([]))
end
