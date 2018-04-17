## EXERCICI 5 APARTAT d) EXAMEN 18.1.2013  

Negeta: **primary key**  
Cursiva: _foreign key_  
Negreta + Cursiva: **_primary and foreign key_**  

>Marcades les Classes Associatives.  

---

Categoria(**Nom Categoria**)  
Festival(**Nom Festival**)  
Any(**Any Edició**)  

>Premi(**_Nom Categoria, Nom Festival, Any Edició_**, *Nom Pel·lícula*, Nom Premi)  
{Nom Caregoria} Referencia Categoria  
{Nom Festival} Referencia Festival  
{Any Edició} Referencia Any  
{Nom Pel·lícula} Referencia Pel·lícula NOT NULL  

Pel·lícula(**Nom Pel·lícula**)  

>Nominades(**_Nom Pel·lícula, Nom Premi_**)  
{Nom Pel·lícula} Referencia Pel·lícula  
{Nom Premi} Referencia Premi
