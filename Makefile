# $Id$
PERL=perl
CVS=cvs

CHECK_URLS=bin/check_urls.pl
TOC_PL=bin/perlfaq_toc.pl

SPLIT_DIR=faqs
FILES=perlfaq1.pod perlfaq2.pod perlfaq3.pod perlfaq4.pod perlfaq5.pod \
	perlfaq6.pod perlfaq7.pod perlfaq8.pod perlfaq9.pod
TOC=perlfaq.toc

help:
	@ echo "Available targets:"
	@ echo
	@ echo "    checkurls   -- extract and validate URLs in the perlfaq POD"
	@ echo "    perlfaq.pod -- create a new perlfaq.pod from the perlfaq POD"
	@ echo "    split       -- split up the faq answers for usenet autoposter"
	@ echo "    test        -- run each .pod file through Test::Pod"
	@ echo

echo:
	@ echo $(FILES)

perlfaq.pod:
	${PERL} ${TOC_PL} > perlfaq.pod

checkurls: 
	${PERL} ${CHECK_URLS} $(FILES)
	@ touch $@

split:
	${CVS} update -d
	${PERL} bin/splitfaq ${SPLIT_DIR} ${FILES}
	rm -f ${SPLIT_DIR}/perlfaq.00.00.txt
	touch ${SPLIT_DIR}/*
	
splitquiet:
	@ ${CVS} update -d
	@ ${PERL} bin/splitfaq -q ${SPLIT_DIR} ${FILES}
	@ rm -f ${SPLIT_DIR}/perlfaq.00.00.txt
	@ touch ${SPLIT_DIR}/*  

test:
	${PERL} t/pod.t
