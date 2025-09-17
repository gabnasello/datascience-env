options(unzip = 'internal') # not sure it is necessary, put it here after looking at https://github.com/r-lib/devtools/issues/1722#issuecomment-370019534
options(install.packages.compile.from.source = 'always')
update.packages(ask=FALSE, repos='https://ftp.gwdg.de/pub/misc/cran/')

install.packages('IRkernel',repos = 'http://cran.us.r-project.org')
IRkernel::installspec(user = FALSE)

install.packages('devtools',repos = 'http://cran.us.r-project.org')
install.packages('repr',repos = 'http://cran.us.r-project.org')

## Basic Statistical Tests
install.packages('rstatix',repos = 'http://cran.us.r-project.org')
## Tests in Linear Mixed Effects Models
install.packages('lmerTest',repos = 'http://cran.us.r-project.org')
install.packages('emmeans',repos = 'http://cran.us.r-project.org')

# Graphics
install.packages('svglite',repos = 'http://cran.us.r-project.org')
install.packages('latex2exp',repos = 'http://cran.us.r-project.org')
install.packages('ggpubr',repos = 'http://cran.us.r-project.org')
install.packages('ggsci',repos = 'http://cran.us.r-project.org')
install.packages('ggraph',repos = 'http://cran.us.r-project.org')

# Data science
install.packages('tidyverse',repos = 'http://cran.us.r-project.org')
install.packages('plyr',repos = 'http://cran.us.r-project.org')
install.packages('investr',repos = 'http://cran.us.r-project.org')
#install.packages('reshape',repos = 'http://cran.us.r-project.org')

# Install ggplotUtils
devtools::build("ggplotUtils")
devtools::install("ggplotUtils")

# Install statsUtils
devtools::build("statsUtils")
devtools::install("statsUtils")

# Install dataprepUtils
devtools::build("dataprepUtils")
devtools::install("dataprepUtils")