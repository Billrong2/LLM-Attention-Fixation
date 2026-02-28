# 
sub f {
    my($text) = @_;
    my $a = length($text);
    my $count = 0;
    while ($text) {
        if ($text =~ /^a/) {
            $count += index($text, ' ');
        } else {
            $count += index($text, "\n");
        }
        $text = substr($text, index($text, "\n")+1, index($text, "\n")+$a+1);
    }
    return $count;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("a
kgf
asd
"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
