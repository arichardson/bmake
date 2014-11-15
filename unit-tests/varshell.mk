# $Id: varshell.mk,v 1.2 2014/11/06 02:05:28 sjg Exp $
#
# Test VAR != shell command

EXEC_FAILED		!= /bin/no/such/command 2> /dev/null
TERMINATED_BY_SIGNAL	!= kill -ALRM $$$$
ERROR_NO_OUTPUT		!= false
ERROR_WITH_OUTPUT	!= echo "output before the error"; false
NO_ERROR_NO_OUTPUT	!= true
NO_ERROR_WITH_OUTPUT	!= echo "this is good"

allvars= EXEC_FAILED TERMINATED_BY_SIGNAL ERROR_NO_OUTPUT ERROR_WITH_OUTPUT \
	NO_ERROR_NO_OUTPUT NO_ERROR_WITH_OUTPUT

all:
.for v in ${allvars}
	@echo ${v}=\'${${v}}\'
.endfor
