# 
sub f {
    my($multi_string) = @_;
    my @words = split(" ", $multi_string);
    my @cond_string = map { $_ =~ /^[[:ascii:]]+$/ } @words;
    if (grep { $_ } @cond_string) {
        return join(', ', grep { $_ =~ /^[[:ascii:]]+$/ } @words);
    }
    return '';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("I am hungry! eat food."),"I, am, hungry!, eat, food.")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
