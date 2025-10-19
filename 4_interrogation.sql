-- Liste des patients triés par nom
SELECT NumSecu, Nom, Prenom, Sexe, DateNaissance
FROM Patient
ORDER BY Nom ASC;

--  Liste des rendez-vous prévus après 2024
SELECT NumSecu, DateRdv, Motif
FROM Rendez_Vous
WHERE DateRdv > '2024-01-01';

--  Patients masculins habitant à Casablanca ou Rabat
SELECT Nom, Prenom, Adresse, Sexe
FROM Patient
WHERE Sexe = 'M' AND Adresse IN ('Casablanca', 'Rabat');

--  Montants de facturation entre 1000 et 4000 MAD
SELECT Id_Facturation, Montant, ModePaiement
FROM Facturation
WHERE Montant BETWEEN 1000 AND 4000;

--  Praticiens spécialisés en chirurgie ou anesthésie
SELECT Nom, Prenom, Specialite
FROM Praticien
WHERE Specialite IN ('Chirurgie', 'Anesthesie');



--  Nombre total de patients
SELECT COUNT(*) AS NbPatients FROM Patient;

--  Montant moyen par mode de paiement
SELECT ModePaiement, AVG(Montant) AS Moyenne
FROM Facturation
GROUP BY ModePaiement;

--  Nombre de rendez-vous par service
SELECT CodeService, COUNT(*) AS NbRendezVous
FROM Rendez_Vous
GROUP BY CodeService;

--  Total des montants facturés par mutuelle
SELECT Mutuelle, SUM(Montant) AS TotalFacture
FROM Facturation
GROUP BY Mutuelle;

--  Spécialités ayant plus d’un praticien
SELECT Specialite, COUNT(*) AS NbPraticiens
FROM Praticien
GROUP BY Specialite
HAVING COUNT(*) > 1;


--  Patients et leur praticien lors des rendez-vous
SELECT Patient.Nom AS NomPatient, Praticien.Nom AS NomPraticien, Rendez_Vous.DateRdv, Rendez_Vous.Motif
FROM Rendez_Vous
JOIN Patient ON Rendez_Vous.NumSecu = Patient.NumSecu
JOIN Praticien ON Rendez_Vous.NumRPPS = Praticien.NumRPPS;

--  Factures et patients associés
SELECT Facturation.Id_Facturation, Facturation.Montant, Patient.Nom, Patient.Prenom
FROM Facturation
JOIN Patient ON Patient.Id_Facturation = Facturation.Id_Facturation;

--  Liste des prescriptions avec le nom du praticien
SELECT Praticien.Nom AS Praticien, Patient.Nom AS Patient, Prescription.Medicament, Prescription.Posologie
FROM Prescription
JOIN Praticien ON Prescription.NumRPPS = Praticien.NumRPPS
JOIN Patient ON Prescription.NumSecu = Patient.NumSecu;

--  Tous les services même sans rendez-vous (jointure externe)
SELECT Service.NomService, Rendez_Vous.Motif
FROM Service
LEFT JOIN Rendez_Vous ON Service.CodeService = Rendez_Vous.CodeService;

--  Patients, facturation et mutuelle (jointure multiple)
SELECT Patient.Nom, Patient.Prenom, Facturation.Montant, Facturation.Mutuelle
FROM Patient
JOIN Facturation ON Patient.Id_Facturation = Facturation.Id_Facturation;

--  Patients ayant un rendez-vous avec un praticien en chirurgie
SELECT Patient.Nom, Patient.Prenom
FROM Patient
WHERE Patient.NumSecu IN (
    SELECT Rendez_Vous.NumSecu
    FROM Rendez_Vous
    WHERE Rendez_Vous.NumRPPS IN (
        SELECT Praticien.NumRPPS
        FROM Praticien
        WHERE Praticien.Specialite = 'Chirurgie'
    )
);

--  Praticiens sans rendez-vous planifié
SELECT Praticien.Nom, Praticien.Prenom
FROM Praticien
WHERE Praticien.NumRPPS NOT IN (
    SELECT Rendez_Vous.NumRPPS
    FROM Rendez_Vous
);

--  Mutuelles utilisées par plus d’un patient
SELECT Facturation.Mutuelle
FROM Facturation
WHERE Facturation.Id_Facturation IN (
    SELECT Patient.Id_Facturation
    FROM Patient
    GROUP BY Patient.Id_Facturation
    HAVING COUNT(*) > 1
);

--  Patients ayant une facture supérieure à la moyenne générale
SELECT Patient.Nom, Patient.Prenom
FROM Patient
WHERE Patient.Id_Facturation IN (
    SELECT Facturation.Id_Facturation
    FROM Facturation
    WHERE Facturation.Montant > (
        SELECT AVG(Facturation.Montant)
        FROM Facturation
    )
);

--  Services où au moins un rendez-vous existe (EXISTS)
SELECT Service.NomService
FROM Service
WHERE EXISTS (
    SELECT 1
    FROM Rendez_Vous
    WHERE Rendez_Vous.CodeService = Service.CodeService
);
