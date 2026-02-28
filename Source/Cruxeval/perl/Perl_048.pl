# 
sub f {
    my($names) = @_;
    if (scalar @$names == 0) {
        return "";
    }
    my $smallest = $names->[0];
    foreach my $name (@$names[1..$#$names]) {
        if ($name lt $smallest) {
            $smallest = $name;
        }
    }
    @$names = grep { $_ ne $smallest } @$names;
    return join('', $smallest);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([]),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
