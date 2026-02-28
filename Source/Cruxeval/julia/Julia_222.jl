function f(mess::String, char::String)::String 
    while findnext(char, mess, findlast(char, mess)[1] + 1) != nothing
        mess = mess[1:prevind(mess, findlast(char, mess)[1])] * mess[nextind(mess, findlast(char, mess)[1]):end]
    end
    return mess
end
using Test

@testset begin

candidate = f;
	@test(candidate("0aabbaa0b", "a") == "0aabbaa0b")
end
