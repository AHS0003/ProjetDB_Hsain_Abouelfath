USE CHU_Paris;

ALTER TABLE Patient
ADD CONSTRAINT chk_Sexe CHECK (Sexe = 'M' OR Sexe = 'F');

ALTER TABLE Patient
ADD CONSTRAINT chk_Telephone CHECK (LENGTH(Telephone) BETWEEN 8 AND 15);

ALTER TABLE Praticien
ADD CONSTRAINT chk_Specialite CHECK (Specialite <> '');

ALTER TABLE Facturation
ADD CONSTRAINT chk_Montant CHECK (Montant > 0);

ALTER TABLE Facturation
ADD CONSTRAINT chk_ModePaiement CHECK (ModePaiement <> '');

ALTER TABLE Rendez_Vous
ADD CONSTRAINT chk_DateRdv CHECK (DateRdv >= '2000-01-01');

ALTER TABLE Rendez_Vous
ADD CONSTRAINT unique_Rdv UNIQUE (NumSecu, NumRPPS, CodeService, DateRdv);

ALTER TABLE Prescription
ADD CONSTRAINT chk_Duree CHECK (Duree > 0);

ALTER TABLE Prescription
ADD CONSTRAINT chk_Medicament CHECK (Medicament <> '');

ALTER TABLE Praticien
ADD CONSTRAINT chk_SelfSupervision CHECK (NumRPPS <> NumRPPS_1);
