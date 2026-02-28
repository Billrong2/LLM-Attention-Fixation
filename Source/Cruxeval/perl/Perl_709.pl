# 
sub f {
    my($text) = @_;
    my @my_list = split(' ', $text);
    @my_list = sort {$b cmp $a} @my_list;
    return join(' ', @my_list);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("a loved"),"loved a")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
