function f(float_number::Float64)::String 
    number = string(float_number)
    dot = findfirst('.', number)
    if dot != nothing
        return number[1:dot-1] * "." * lpad(number[dot+1:end], 2, '0')
    end
    return number * ".00"
end
using Test

@testset begin

candidate = f;
	@test(candidate(3.121) == "3.121")
end
