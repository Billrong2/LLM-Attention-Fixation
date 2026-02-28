# 
sub f {
    my($seq, $value) = @_;
    my %roles = map { $_ => 'north' } @$seq;
    if ($value) {
        my @keys = map { $_ => 1 } map { split ', ' } split /, /, $value;
        @roles{keys @keys} = values @keys;
    }
    return \%roles;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["wise king", "young king"], ""),{"wise king" => "north", "young king" => "north"})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
