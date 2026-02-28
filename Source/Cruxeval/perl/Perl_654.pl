# 
sub f {
    my($s, $from_c, $to_c) = @_;
    my %table;
    @table{split //, $from_c} = split //, $to_c;
    return join '', map { $table{$_} // $_ } split //, $s;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("aphid", "i", "?"),"aph?d")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
