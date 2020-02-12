# pacotes necessários
library(magrittr); library(tidyverse)

listar_arquivos_siasus <- function(TIPO, ANO, MES, ...){
  
  MES <- if(nchar(MES) == 1){paste0("0", MES)}else{MES}
  ANO <- if(nchar(ANO)== 4){substr(ANO, 3, 4)}else(ANO)
  TIPO<- if(!TIPO %in% c("PA", "AD", "AM", "AN", "AQ", "AR", "AB", "AC", "AT", "PS", "BI" )){
    warning("Tipo de Arquivo não reconhecido. Verificar Informe Técnico SIASUS no link: ftp://ftp.datasus.gov.br/dissemin/publicos/SIASUS/200801_/Doc/Informe_Tecnico_SIASUS_2019_07.pdf ")
    break
    }else(TIPO) 
  
  # Lista de Arquivos do SIASUS
  arq =tibble( TIPO = c("PA", "AD", "AM", "AN", "AQ", "AR", "AB", "AC", "AT", "PS", "BI" ),
               TIPO_DESC =  c("Procedimento Ambulatorial", 
                              "Laudos Diversos",
                              "Medicamentos", 
                              "Nefrologia", 
                              "Quimioterapia", 
                              "Radioterapia",
                              "Cirurgia Bariátrica", 
                              "Confecção de Fístula Arteriovenosa", 
                              "Dialítico", 
                              "Psicossocial", 
                              "Boletim Individualizado"))
        
  # listar arquivos no ftp do SIHSUS
  caminho <- "ftp://ftp.datasus.gov.br/dissemin/publicos/SIASUS/200801_/Dados/"
  
  # captar informações da página
  result <- RCurl::getURL(caminho)
  
  # Listar arquivos
  resultado <-strsplit(result, "\r*\n")[[1]] %>% tibble()
  
  # Renomear colunas
  colnames(resultado) <- "arquivo"
  
  # Extrair nomes exatos dos arquivos
  arquivos <- resultado %>%
    mutate( arquivo = substr(arquivo, nchar(arquivo) - 11, nchar(arquivo)))
  
  # Apenas arquivos RD
  arquivos <<- arquivos %>% 
    filter(grepl(paste0("^", TIPO), arquivo)) %>% 
    filter(grepl(paste0(ANO), arquivo))
  
  print( paste("Arquivos",  arq[arq$TIPO == TIPO, 2], "baixados"))
}

