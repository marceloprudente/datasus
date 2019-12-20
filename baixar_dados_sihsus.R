library(magrittr); library(tidyverse)
# listar arquivos no ftp do SIHSUS
caminho <- "ftp://ftp.datasus.gov.br/dissemin/publicos/SIHSUS/200801_/Dados/"
result <- RCurl::getURL(caminho)

resultado <-strsplit(result, "\r*\n")[[1]] %>% tibble()

colnames(resultado) <- "arquivo"

arquivos <- resultado %>% mutate(
    arquivo = substr(arquivo, nchar(arquivo) - 11, nchar(arquivo)))


arquivos_rd <- arquivos %>% filter(grepl("^RD", arquivo))

path <- getwd()

setwd(paste0(path, "/sihsus/rd/"))

for(i in 1:10){
  
  tryCatch(download.file(paste0(caminho, arquivos_rd[i, 1]), 
              destfile = paste0("C:/reg_saude/sihsus/rd/", arquivos_rd[i,1]), 
              mode = "wb"), 
              error = function(e) print(paste(arquivos_rd[i, 1], 'não funcionou')))
}

