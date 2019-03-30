
library(datasus)
# nascidos sergipe
nas_se <- sinasc_nv_uf(uf = "se",
             periodo = c(2011:2015),
             coluna = "Ano do nascimento")
