function f(text::String, search::String)::Int64 
    result = lowercase(text)
    search_lowercase = lowercase(search)
    return isnothing(findfirst(search_lowercase, result)) ? -1 : first(findfirst(search_lowercase, result)) - 1
end

using Test

@testset begin

candidate = f;
	@test(candidate("car hat", "car") == 0)
end
