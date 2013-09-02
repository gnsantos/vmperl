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
	$stk->insertItem($_);
	$cont++;
}

our $k = $stk->removeItem();

print "Item removido : $k \n";

$stk->printaStack($cont);




