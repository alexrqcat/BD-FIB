Pais(**Nom País**)

Ciutat(**Nom Ciutat, _Nom País_**)  
{Nom País} Referencia País

Companyia(**Nom Companyia**)

Representació(**_Nom Ciutat, Nom País, Nom Companyia_**, Adreça)  
{Nom Ciutat} Referencia Ciutat   
{Nom País} Referencia País  
{Nom Companyia} Referencia Companyia  

Pel·lícula (**Codi Pel·lícula**, Nom Pel·lícula, Any, Pressupost, Nom Companyia, Num Cinéfil, Nom Tema)  
{Nom Companyia} Referencia Companyia NOT NULL   
{Num Cinéfil} Referencia Director NOT NULL   
{Nom Tema} Referencia Tema NOT NULL  
