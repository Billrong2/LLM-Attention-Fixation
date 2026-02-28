function f(phrase::String)::String 
    result = ""
    for i in phrase
        if !islowercase(i)
            result *= i
        end
    end
    return result
end
using Test

@testset begin

candidate = f;
	@test(candidate("serjgpoDFdbcA.") == "DFA.")
end
