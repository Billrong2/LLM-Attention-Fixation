function f(mylist::Vector{Int64})::Bool 
    revl = copy(mylist)
    reverse!(revl)
    sort!(mylist, rev=true)
    return mylist == revl
end
using Test

@testset begin

candidate = f;
	@test(candidate([5, 8]) == true)
end
