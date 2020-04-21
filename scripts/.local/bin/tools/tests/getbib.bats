@test "getbib fetches correct results" {
	echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1
	if [ $? -ne 0 ]; then
	    skip "Not connected to internet"
	fi

expected="@article{Aspelmeyer_2009,
	doi = {10.1038/nphys1170},
	url = {https://doi.org/10.1038%2Fnphys1170},
	year = 2009,
	month = {jan},
	publisher = {Springer Science and Business Media {LLC}},
	volume = {5},
	number = {1},
	pages = {11--12},
	author = {Markus Aspelmeyer},
	title = {Measured measurement},
	journal = {Nature Physics}
}"

	result=`getbib doi:10.1038/nphys1170`
	[ "$result" == "$expected" ]
}

@test "getbib extracts from PDFS" {
expected="@article{Price_2005,
	doi = {10.1016/j.evolhumbehav.2004.08.009},
	url = {https://doi.org/10.1016%2Fj.evolhumbehav.2004.08.009},
	year = 2005,
	month = {may},
	publisher = {Elsevier {BV}},
	volume = {26},
	number = {3},
	pages = {279--287},
	author = {Michael E. Price},
	title = {Punitive sentiment among the Shuar and in industrialized societies: cross-cultural similarities},
	journal = {Evolution and Human Behavior}
}"
	result=`getbib resources/sample_pdf.pdf`
	[ "$result" == "$expected" ]
}

@test "getbib does not output if unsuccessful" {
	skip "this will work later"
	result=`getbib NOT_A_DOI`
	[ -z result ]
}

