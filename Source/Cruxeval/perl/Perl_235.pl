# 
sub f {
    my($array, $arr) = @_;
    my @result;
    foreach my $s (@$arr) {
        push @result, grep { $_ ne '' } split($arr->[$array->index($s)], $s);
    }
    return \@result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([], []),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
