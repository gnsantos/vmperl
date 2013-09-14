#!/usr/bin/perl
use v5.14;
package main;

#Pragmas
use strict;
use warnings;

#Modulos
use stack ;

# print "ok doke \n";

our $stk = new stack();
# our $cont = 0;

while (<>){
	$stk->makeOperation('PUSH',$_);
}
# $stk->makeOperation('STO',2);
# $stk->makeOperation('STO',4);
# $stk->makeOperation('STO',1);
# $stk->printaMem();
# $stk->makeOperation('RCL',4);
$stk->printaStack();

our $x = $stk->makeOperation('JIT',1);

$stk->printaStack();

print "\n\n valor de X = $x \n";
# #our $k = $stk->unstack();
# #$stk->dup();
# #print "Item removido : $k \n";

# #$stk->printaStack();

# #$stk->shiftStack();

# my $last = $stk->showTop();

# print ">> My last = $last \n";

# $stk->printaStack();

#my $teste = new operation();
#my $op = "DIV";
# $teste->makeOpt(4,0,$op);

#print "----------\n";
#(a,b,opt) =>> a <=> b
#$teste->makeOpt(3,2,"NE");






