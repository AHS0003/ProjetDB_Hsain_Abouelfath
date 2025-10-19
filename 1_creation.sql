
CREATE DATABASE CHU_Paris;
USE CHU_Paris;


CREATE TABLE Praticien (
    NumRPPS VARCHAR(50) PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    Specialite VARCHAR(50),
    NumRPPS_1 VARCHAR(50),
    FOREIGN KEY (NumRPPS_1) REFERENCES Praticien(NumRPPS)
);


CREATE TABLE Service (
    CodeService VARCHAR(50) PRIMARY KEY,
    NomService VARCHAR(50)
);


CREATE TABLE Facturation (
    Id_Facturation INT AUTO_INCREMENT PRIMARY KEY,
   Montant DECIMAL(10,2),
    ModePaiement VARCHAR(50),
    Reference VARCHAR(50),
    CouvertureSociale VARCHAR(50),
    Mutuelle VARCHAR(50)
);


CREATE TABLE Patient (
    NumSecu VARCHAR(50) PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    DateNaissance VARCHAR(50),
    Sexe VARCHAR(50),
    Adresse VARCHAR(50),
    Telephone VARCHAR(50),
    Id_Facturation INT,
    FOREIGN KEY (Id_Facturation) REFERENCES Facturation(Id_Facturation)
);


CREATE TABLE Rendez_Vous (
    NumSecu VARCHAR(50),
    NumRPPS VARCHAR(50),
    CodeService VARCHAR(50),
    DateRdv DATE,
    Motif VARCHAR(50),
    Heure TIME,
    PRIMARY KEY (NumSecu, NumRPPS, CodeService, DateRdv),
    FOREIGN KEY (NumSecu) REFERENCES Patient(NumSecu),
    FOREIGN KEY (NumRPPS) REFERENCES Praticien(NumRPPS),
    FOREIGN KEY (CodeService) REFERENCES Service(CodeService)
);


CREATE TABLE Prescription (
    NumSecu VARCHAR(50),
    NumRPPS VARCHAR(50),
    Medicament VARCHAR(50),
    Posologie VARCHAR(50),
    Duree INT,
    PRIMARY KEY (NumSecu, NumRPPS, Medicament),
    FOREIGN KEY (NumSecu) REFERENCES Patient(NumSecu),
    FOREIGN KEY (NumRPPS) REFERENCES Praticien(NumRPPS)
);
