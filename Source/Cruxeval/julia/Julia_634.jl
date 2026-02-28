function f(input_string::String)::String 
    table = Dict('a'=>'i', 'i'=>'o', 'o'=>'u', 'e'=>'a')
    while occursin('a', input_string) || occursin('A', input_string)
        input_string = replace(input_string, table)
    end
    return input_string
end
using Test

@testset begin

candidate = f;
	@test(candidate("biec") == "biec")
end
