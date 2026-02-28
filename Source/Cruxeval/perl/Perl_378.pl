# 
sub f {
    my($dic, $key) = @_;
    my %dic = %$dic;
    my $v = delete $dic{$key};
    if (!defined $v) {
        return 'No such key!';
    }
    while (keys %dic > 0) {
        my ($k, $v) = each %dic;
        delete $dic{$k};
        $dic{$v} = $k;
    }
    my ($k) = each %dic;
    return int($k);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"did" => 0}, "u"),"No such key!")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
