function f(line::String)::String
    count = 0
    a = []
    for i in 1:length(line)
        count += 1
        if count%2==0
            push!(a, islowercase(line[i]) ? uppercase(line[i]) : lowercase(line[i]))
        else
            push!(a, line[i])
        end
    end
    return join(a)
end
using Test

@testset begin

candidate = f;
	@test(candidate("987yhNSHAshd 93275yrgSgbgSshfbsfB") == "987YhnShAShD 93275yRgsgBgssHfBsFB")
end
