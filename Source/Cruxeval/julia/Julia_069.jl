function f(student_marks::Dict{String, Int}, name::String)::Union{Int, String} 
    if haskey(student_marks, name)
        value = pop!(student_marks, name)
        return value
    end
    return "Name unknown"
end
using Test

@testset begin

candidate = f;
	@test(candidate(Dict("882afmfp" => 56), "6f53p") == "Name unknown")
end
