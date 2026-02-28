# 
sub f {
    my($l1, $l2) = @_;
    if (@$l1 != @$l2) {
        return {};
    }
    return {map {$_ => $l2} @$l1};
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["a", "b"], ["car", "dog"]),{"a" => ["car", "dog"], "b" => ["car", "dog"]})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
