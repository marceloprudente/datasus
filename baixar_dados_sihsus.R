# pacotes necessários
library(magrittr); library(tidyverse)
# listar arquivos no ftp do SIHSUS
caminho <- "ftp://ftp.datasus.gov.br/dissemin/publicos/SIHSUS/200801_/Dados/"

# captar informações da página
result <- RCurl::getURL(caminho)

# Listar arquivos
resultado <-strsplit(result, "\r*\n")[[1]] %>% tibble()

# Renomear colunas
colnames(resultado) <- "arquivo"

# Extrair nomes exatos dos arquivos
arquivos <- resultado %>% mutate(
    arquivo = substr(arquivo, nchar(arquivo) - 11, nchar(arquivo)))

# Apenas arquivos RD
arquivos_rd <- arquivos %>% filter(grepl("^RD", arquivo))

# Diretório atual
path <- getwd()

# Fixar diretório
setwd(paste0(path, "/sihsus/rd/"))

# Loop para baixar dados
for(i in 1:nrow(arquivos){
  
  tryCatch(download.file(paste0(caminho, arquivos_rd[i, 1]), 
              destfile = paste0("C:/reg_saude/sihsus/rd/", arquivos_rd[i,1]), 
              mode = "wb"), 
              error = function(e) print(paste(arquivos_rd[i, 1], 'não funcionou')))
}

