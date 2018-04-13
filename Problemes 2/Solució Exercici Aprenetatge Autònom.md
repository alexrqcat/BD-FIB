Negeta: **primary key**  
Cursiva: _foreign key_  
Negreta + Cursiva: **_primary and foreign key_**  

>Marcades les Classes Associatives.  

---

Pais(**Nom País**)

Ciutat(**Nom Ciutat, _Nom País_**)  
{Nom País} Referencia País

Companyia(**Nom Companyia**)

> Representació(**_Nom Ciutat, Nom País, Nom Companyia_**, Adreça)  
{Nom Ciutat} Referencia Ciutat   
{Nom País} Referencia País  
{Nom Companyia} Referencia Companyia  

Pel·lícula (**Codi Pel·lícula**, Nom Pel·lícula, Any, Pressupost, *Nom Companyia, Num Cinéfil, Nom Tema*)  
{Nom Companyia} Referencia Companyia NOT NULL   
{Num Cinéfil} Referencia Director NOT NULL   
{Nom Tema} Referencia Tema NOT NULL  

Tema(**Nom Tema**)  

Actor(**_Num Cinéfil_**)  
{Num Cinéfil} Referencia Cinéfil

Director(**_Num Cinéfil_**)   
{Num Cinéfil} Referencia Cinéfil

>Rols(**_Codi Pel·lícula, Num Cinéfil_**, Paper)  
{Codi Pel·lícula} Referencia Pel·lícula  
{Num Cinéfil} Referencia Actor  

>Substitució(**_Num Cinéfil A, Num Cinéfil B_**, Grau Substitució)  
{Num Cinéfil A} Referencia Actor  
{Num Cinéfil B} Referencia Actor

Cinéfil(**Num Cinéfil**, Nom Cinéfil, Any Naixement, Sexe)

Data(**Data alta**)  

>Contractació(**_Num Cinéfil, Data Alta, Nom Companyia_**, Data Baixa)  
{Num Cinéfil} Referencia Cinéfil  
{Data Alta} Referencia Data   
{Nom Companyia} Referencia Companyia   

>Habilitat(**_Nom Tema, Num Cinéfil_**, Grau Habilitat)  
{Nom Tema} Referencia Tema  
{Num Cinéfil} Referencia Actor
