# 
sub f {
    my($strings) = @_;
    my %occurances;
    foreach my $string (@$strings) {
        if (not exists $occurances{$string}) {
            $occurances{$string} = scalar(grep { $_ eq $string } @$strings);
        }
    }
    return \%occurances;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["La", "Q", "9", "La", "La"]),{"La" => 3, "Q" => 1, "9" => 1})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
