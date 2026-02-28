# 
sub f {
    my($item) = @_;
    my $modified = $item;
    $modified =~ s/\. / , /g;
    $modified =~ s/&#33; /! /g;
    $modified =~ s/\. /? /g;
    $modified =~ s/\. /\. /g;
    $modified = ucfirst(substr($modified, 0, 1)) . substr($modified, 1);
    
    return $modified;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(".,,,,,. منبت"),".,,,,, , منبت")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
