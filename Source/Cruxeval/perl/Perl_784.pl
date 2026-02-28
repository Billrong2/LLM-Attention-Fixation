# 
sub f {
    my($key, $value) = @_;
    my %dict_ = ($key => $value);
    return (keys %dict_)[0] => (delete %dict_{(keys %dict_)[0]});
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("read", "Is"),["read", "Is"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
