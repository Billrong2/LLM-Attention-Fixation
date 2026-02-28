# 
sub f {
    my($cities, $name) = @_;
    if (!$name) {
        return $cities;
    }
    if ($name and $name ne 'cities') {
        return [];
    }
    return map { $name . $_ } @$cities;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["Sydney", "Hong Kong", "Melbourne", "Sao Paolo", "Istanbul", "Boston"], "Somewhere "),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
