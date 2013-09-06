#!/usr/bin/perl
package main;

#Pragmas
use strict;
use warnings;

#Modulos
use stack ;


print "ok doke \n";

our $stk = new stack();
our $cont = 0;

while (<>){
	$stk->pile($_);
	$cont++;
}

#our $k = $stk->unstack();
#$stk->dup();
#print "Item removido : $k \n";

#$stk->printaStack();

#$stk->shiftStack();

my $last = $stk->showTop();

print ">> My last = $last \n";

$stk->printaStack();







