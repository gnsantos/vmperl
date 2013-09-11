#!/usr/bin/perl
use v5.14;
package main;

#Pragmas
use strict;
use warnings;

#Modulos
use stack ;
use operation ;

# print "ok doke \n";

# our $stk = new stack();
# our $cont = 0;

# while (<>){
# 	$stk->pile($_);
# 	$cont++;
# }

# #our $k = $stk->unstack();
# #$stk->dup();
# #print "Item removido : $k \n";

# #$stk->printaStack();

# #$stk->shiftStack();

# my $last = $stk->showTop();

# print ">> My last = $last \n";

# $stk->printaStack();

my $teste = new operation();
my $op = "DIV";
# $teste->makeOpt(4,0,$op);

print "----------\n";
#(a,b,opt) =>> a <=> b
$teste->makeOpt(3,2,"NE");






