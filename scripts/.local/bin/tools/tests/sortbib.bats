@test "sortbib alphebetizes correctly" {
	sed -n 27,35p resources/sample_bib > /tmp/shuffled_bib
	sed -n 14,26p resources/sample_bib >> /tmp/shuffled_bib
	sed -n 1,13p resources/sample_bib >> /tmp/shuffled_bib

	sortbib /tmp/shuffled_bib
	DIFFERENCES=`diff resources/sample_bib /tmp/shuffled_bib`
	[ "$DIFFERENCES" = "" ]
}
@test "sortbib deletes duplicates" {
	sed -n 27,35p resources/sample_bib > /tmp/shuffled_bib
	sed -n 14,26p resources/sample_bib >> /tmp/shuffled_bib
	sed -n 14,26p resources/sample_bib >> /tmp/shuffled_bib
	sed -n 1,13p resources/sample_bib >> /tmp/shuffled_bib

	sortbib /tmp/shuffled_bib
	DIFFERENCES=`diff resources/sample_bib /tmp/shuffled_bib`
	[ "$DIFFERENCES" = "" ]
}
