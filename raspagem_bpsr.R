## webscrpaping artigos Dados. BPRS, OP


library(XML)
## função que extrai links de um site
pegaLinks1 <- function ( url.inicial, padrao.inicial, arg.xpath="//a/@href") {
  #browser()
  doc <- htmlParse( url.inicial)   # parseia url
  linksAux <- xpathSApply(doc, arg.xpath)   # coleta os links
  linksMandato <- unique(linksAux[grep(padrao.inicial, linksAux)]) # me traz apenas os links certos
  free(doc)
  return(linksMandato)
}

## url da BPSR
url <- "http://www.scielo.br/scielo.php?script=sci_issues&pid=1981-3821&lng=en&nrm=iso"
years_bpsr <- c("2016", "2015", "2014", "2013","2012")
url_bpsr <- paste(url, years_bpsr, sep="")

## vamos acessar as páginas com links pros papers, e retornar conteúdo de todas as edições da revista

## primeiro, pegando o link de cada edição/ano
lista_bpsr <- list()
for ( i in  1:length(years_bpsr)) lista_bpsr[[i]] <- pegaLinks1(url_bpsr[i], years_bpsr[i])

## agora, pegando os links de cada paper
vec_bpsr <- unlist(lista_bpsr)
n <- length(vec_bpsr)
text <- list()
for ( i in 1:n) text[[i]] <- pegaLinks1(vec_bpsr[i], "text")

text1 <- unlist(text) ## alguma coisa errada, pois aparentemente tem 465 papers. Parece muito. Checar depois.

## primeiro elemento de text tem as urls de cada paper da edição respectiva

## falta agora pegar as tabelas

## pra testar algoritmos

## text[[1]] vários papers sem tabela de regressão, mas têm tabelas (ver se vem como falso positivo)
## http://www.scielo.br/scielo.php?script=sci_arttext&pid=S1981-38212013000100003&lng=en&nrm=iso2014&tlng=en
## tem tabela, mas estão como imagem... pra BPSR ficou zuado, vai ter que pegar na mão. 
# Tem que pelo menos identificar os papers automaticamente

