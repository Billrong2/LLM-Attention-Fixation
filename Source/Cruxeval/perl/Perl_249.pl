# 
sub f {
    my($s) = @_;
    my %count;
    foreach my $i (split(//, $s)) {
        if ($i =~ /[a-z]/) {
            $count{lc($i)} = () = $s =~ /$i/g + $count{lc($i)};
        } else {
            $count{lc($i)} = () = $s =~ /$i/g + $count{lc($i)};
        }
    }
    return \%count;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("FSA"),{"f" => 1, "s" => 1, "a" => 1})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
