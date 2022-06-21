CREATE TABLE job_function /*
  * Job Function = CSS, DSP, ...
  * Type Ressources = CSS, DSP, ..
  */
(
  code VARCHAR(255) not null,
  description VARCHAR(255),
  PRIMARY KEY (code)
);

CREATE TABLE job_qualif
(
  code VARCHAR(255) not null,
  description VARCHAR(255),
  job_function VARCHAR(255) FOREIGN KEY REFERENCES job_function(code),
  PRIMARY KEY (code)
);

CREATE TABLE type_collaborateur /*
  * Employee Type
  * Own - Int - Ext - GDC
  */
(
  code VARCHAR(255) not null,
  description VARCHAR(255),
  PRIMARY KEY (code)
);

/* CREATE TABLE type_ressource
(
  code VARCHAR(255) not null,
  description VARCHAR(255),
  PRIMARY KEY (code)
);
*/

-- CREATE TABLE prod_unit
-- (
--   code VARCHAR(255) not null,
--   description VARCHAR(255),
--   PRIMARY KEY (code)
-- );

CREATE TABLE ssl_portfolio /*
  * Microsoft, Google, DATA, ...
  */
(
  code VARCHAR(255) not null,
  description VARCHAR(255),
  PRIMARY KEY (code)
);

CREATE TABLE market_unit
(
  code VARCHAR(255) not null,
  description VARCHAR(255),
  PRIMARY KEY (code)
);

CREATE TABLE market_segment
(
  code VARCHAR(255) not null,
  description VARCHAR(255),
  market_unit VARCHAR(255) FOREIGN KEY REFERENCES market_unit(code),
  PRIMARY KEY (code)
);

CREATE TABLE categorie_projet
(
  /*
  * Type Projet Level1
  * Type Projet Level2
  */
  code VARCHAR(255) not null,
  description VARCHAR(255),
  PRIMARY KEY (code)
);

CREATE TABLE type_projet /*
  * Project Type
*/
(
  code VARCHAR(255) not null,
  description VARCHAR(255),
  categorie_projet VARCHAR(255) FOREIGN KEY REFERENCES categorie_projet(code),
  PRIMARY KEY (code)
);

CREATE TABLE categorie_secteur_activite
(
  code VARCHAR(255) not null,
  description VARCHAR(255),
  PRIMARY KEY (code)
);

CREATE TABLE type_secteur_activite
(
  code VARCHAR(255) not null,
  description VARCHAR(255),
  PRIMARY KEY (code),
  categorie_secteur_activite VARCHAR(255) FOREIGN KEY REFERENCES categorie_secteur_activite(code),
);


CREATE TABLE grade
(
  code VARCHAR(255) not null,
  description VARCHAR(255),
  PRIMARY KEY (code)
);

CREATE TABLE collaborateur
(
  matricule VARCHAR(255) not null,
  nom VARCHAR(255),
  type VARCHAR(255),
  internal_pu BIT,
  PRIMARY KEY(matricule),
  job_qualif VARCHAR(255) FOREIGN KEY REFERENCES job_qualif(code),
  grade VARCHAR(255) FOREIGN KEY REFERENCES grade(code),
  type_collaborateur VARCHAR(255) FOREIGN KEY REFERENCES type_collaborateur(code),
  --type_ressource VARCHAR(255) FOREIGN KEY REFERENCES type_ressource(code),
  -- prod_unit VARCHAR(255) FOREIGN KEY REFERENCES prod_unit(code),
  ssl_portfolio VARCHAR(255) FOREIGN KEY REFERENCES ssl_portfolio(code),
  market_segment VARCHAR(255) FOREIGN KEY REFERENCES market_segment(code)
)

CREATE TABLE categorie_depense
(
  code VARCHAR(255) not null,
  description VARCHAR(255),
  PRIMARY KEY (code)
);

CREATE TABLE type_depense
(
  code VARCHAR(255) not null,
  description VARCHAR(255),
  PRIMARY KEY (code),
  categorie_depense VARCHAR(255) FOREIGN KEY REFERENCES categorie_depense(code),

);

CREATE TABLE depense
(
  id INT identity(1,1) not null,
  nom VARCHAR(255),
  description VARCHAR(255),
  commentaire VARCHAR(255),
  PRIMARY KEY(id),
  type_depense VARCHAR(255) FOREIGN KEY REFERENCES type_depense(code)
);

CREATE TABLE covid_inno
(
  code VARCHAR(255) not null,
  description VARCHAR(255),
  PRIMARY KEY (code)
);


CREATE TABLE sites
(
  code VARCHAR(255) not null,
  description VARCHAR(255),
  PRIMARY KEY (code)
);

CREATE TABLE grand_compte
(
  nom VARCHAR(255),
  is_compte_nomme BIT,
  is_group_account BIT,
  PRIMARY KEY (nom)
);

CREATE TABLE client
(
  numero INT not null,
  nom VARCHAR(255),
  type_client BIT, -- 1 == External | 0 = Internal
  PRIMARY KEY (numero),
  grand_compte VARCHAR(255) FOREIGN KEY REFERENCES grand_compte(nom)
);

CREATE TABLE projet
(
  code_projet VARCHAR(255) not null,
  nom VARCHAR(255),
  billable_flag BIT,
  code_attente BIT, -- not sure
  date_projet DATE,
  icb_bl VARCHAR(255), -- not sure
  pnl_dbc VARCHAR(255), -- not sure
  prod_unit_c4_brut VARCHAR(255),
  PRIMARY KEY (code_projet),
  prod_unit_projet VARCHAR(255) FOREIGN KEY REFERENCES market_segment(code),
  pnl_projet VARCHAR(255) FOREIGN KEY REFERENCES market_segment(code),
  bizz VARCHAR(255) FOREIGN KEY REFERENCES ssl_portfolio(code), -- not sure
  type_projet VARCHAR(255) FOREIGN KEY REFERENCES type_projet(code),
  type_secteur_activite VARCHAR(255) FOREIGN KEY REFERENCES type_secteur_activite(code),
  site_projet VARCHAR(255) FOREIGN KEY REFERENCES sites(code),
  client_facture INT FOREIGN KEY REFERENCES client(numero),
  client_final INT FOREIGN KEY REFERENCES client(numero),
  ssl_portfolio VARCHAR(255) FOREIGN KEY REFERENCES ssl_portfolio(code),
  tag_shadow VARCHAR(255) FOREIGN KEY REFERENCES market_segment(code),
  covid_inno VARCHAR(255) FOREIGN KEY REFERENCES covid_inno(code),
);

CREATE TABLE mission
(
  id INT not null IDENTITY(1,1),
  costed_days INT,
  billable_days INT,
  unbilled_days INT,
  cost_of_remuneration INT,
  daily_cost INT,
  revenu_own INT,
  tp_amount_provider INT,
  cor INT,
  charged_expenses INT,
  billed_expenses INT,
  unbilled_expenses INT,
  total_direct_costs INT,
  contributions INT,
  PRIMARY KEY(id),
  projet VARCHAR(255) FOREIGN KEY REFERENCES projet(code_projet),
  collaborateur VARCHAR(255) FOREIGN KEY REFERENCES collaborateur(matricule),
  depense INT FOREIGN KEY REFERENCES depense(id)
);