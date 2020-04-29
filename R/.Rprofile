# Cool quotes on startup:
#if(interactive()){
	#suppressMessages(require(devtools))
	#suppressMessages(require(tidyverse))
	#try(fortunes::fortune(), silent=TRUE)
#}

# Set CRAN mirror:
local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cloud.r-project.org/"
  options(repos = r)
})

# Sc-im viewer hack:
scim <- function(x, n = 1000 ){
	if (is.data.frame(x)) {
		if (nrow(x) > n) x <- x[1:n,]
	}
	file_name <- paste0("/tmp/",deparse(substitute(x)), ".csv")
	write.csv(x, file_name)
	system(paste("sc-im", file_name))
}

# Easily add package citations to bib file
add_citation<- function(package){
	bib_file <- Sys.getenv("BIB")
	name <- deparse(substitute(package))
	write(toBibtex(citation(name)), file=bib_file, append=TRUE)
}

