# $Id: options.mk,v 1.4 2012/11/11 22:36:00 sjg Exp $
#
#	@(#) Copyright (c) 2012, Simon J. Gerraty
#
#	This file is provided in the hope that it will
#	be of use.  There is absolutely NO WARRANTY.
#	Permission to copy, redistribute or otherwise
#	use this file is hereby granted provided that 
#	the above copyright notice and this notice are
#	left intact. 
#      
#	Please send copies of changes and bug-fixes to:
#	sjg@crufty.net
#

# Inspired by FreeBSD bsd.own.mk, but intentionally simpler.

# Options are listed in either OPTIONS_DEFAULT_{YES,NO}
# A makefile may set NO_* (or NO*) to indicate it cannot do something.
# User sets WITH_* and WITHOUT_* to indicate what they want.
# We set MK_* which is then all we need care about.

# Pocess NO options first so they can take precedence.
# User/site may add an option to OPTIONS_DEFAULT_NO that
# we have in OPTIONS_DEFAULT_YES.
.for o in ${OPTIONS_DEFAULT_NO:O:u}
.if defined(WITH_$o) && !defined(NO_$o) && !defined(NO$o)
MK_$o ?= yes
.else
MK_$o ?= no
.endif
.endfor

.for o in ${OPTIONS_DEFAULT_YES:O:u}
.if defined(WITHOUT_$o) || defined(NO_$o) || defined(NO$o)
MK_$o ?= no
.else
MK_$o ?= yes
.endif
.endfor

# OPTIONS_DEFAULT_DEPENDENT += FOO_UTILS/FOO
# if neither WITH[OUT]_FOO_UTILS is set, use value of MK_FOO
.for o in ${OPTIONS_DEFAULT_DEPENDENT:M*/*:O:u}
.if defined(WITH_${o:H}) && !defined(NO_${o:H}) && !defined(NO${o:H})
MK_${o:H} ?= yes
.elif defined(WITHOUT_${o:H}) || defined(NO_${o:H}) || defined(NO${o:H})
MK_${o:H} ?= no
.else
MK_${o:H} ?= ${MK_${o:T}}
.endif
.endfor
