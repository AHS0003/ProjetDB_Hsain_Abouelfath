-- 1) Tables sans clés étrangères: Planète, Ressource
INSERT INTO Planete (pl_id, pl_nom, pl_climat, pl_population) VALUES
  (1,'Coruscant','tempéré',1500000000),
  (2,'Tatooine','désertique',200000),
  (3,'Hoth','glacial',0),
  (4,'Endor','tempéré',3000000),
  (5,'Naboo','océanique',450000000),
  (6,'Mustafar','aride',10000),
  (7,'Kamino','océanique',1000000),
  (8,'Kashyyyk','tropical',450000000),
  (9,'Bespin','inconnu',50000),
  (10,'Alderaan','tempéré',200000000);

INSERT INTO Ressource (re_id, re_nom, re_categorie, `re_unité`) VALUES
  (1,'Duracier','minérale','tonne'),
  (2,'Beskar','minérale','tonne'),
  (3,'Gaz Tibanna','énergétique','m3'),
  (4,'Hypercarburant (Coaxium)','énergétique','baril'),
  (5,'Cristaux kyber','technologique','unité'),
  (6,'Bacta','biologique','m3'),
  (7,'Eau douce','autre','m3'),
  (8,'Bois','biologique','tonne'),
  (9,'Fer','minérale','tonne'),
  (10,'Cuivre','minérale','tonne'),
  (11,'Silicium','minérale','tonne'),
  (12,'Titane','minérale','tonne'),
  (13,'Énergie solaire','énergétique','kWh'),
  (14,'Épices','biologique','kg'),
  (15,'Circuits intégrés','technologique','unité'),
  (16,'Droides de service','technologique','unité'),
  (17,'Logiciels de navigation','technologique','unité'),
  (18,'Hélium-3','énergétique','kg'),
  (19,'Grains','biologique','tonne'),
  (20,'Plastacier','autre','tonne');

-- 2) Tables avec FKs vers tables déjà remplies: Faction
-- Point de vue impérial: Empire et organes = alliés ; République/Rebelles = hostiles
INSERT INTO Faction (fa_id, fa_nom, fa_alignement, pl_id) VALUES
  (1,'Empire Galactique','alliée',1),
  (2,'République Galactique','hostile',1),
  (3,'Alliance Rebelle','hostile',10),
  (4,'Cartel Hutt','neutre',2),
  (5,'Guilde des Chasseurs de Primes','neutre',9),
  (6,'Bureau de Sécurité Impériale (ISB)','alliée',1),
  (7,'Clonistes Kaminoans','neutre',7),
  (8,'Réseau de Résistance Wookiee','hostile',8),
  (9,'Administration Impériale de Naboo','alliée',5),
  (10,'Administration de Bespin','neutre',9),
  (11,'Inquisiteurs Impériaux','alliée',6),
  (12,'Commandement Sectoriel de Mustafar','alliée',6),
  (13,'Autorité Impériale d’Alderaan','alliée',10),
  (14,'Garnison Impériale d’Endor','alliée',4),
  (15,'Flotte Impériale du Noyau','alliée',1);

-- 3) Installations (FKs vers Ressource, Faction, Planète)
INSERT INTO Installation (in_id, in_type, in_capacite, in_statut, in_date_mise_service, re_id, fa_id, pl_id) VALUES
  (1,'Chantier naval orbital',250000.00,'active','2243-04-12',15,1,1),
  (2,'Raffinerie de coaxium',180000.00,'en_maintenance','2244-10-30',4,4,2),
  (3,'Base rebelle',5000.00,'active','2243-11-17',16,3,10),
  (4,'Usine de droides',90000.00,'planifiée','2246-02-05',16,6,6),
  (5,'Ferme hydroponique',60000.00,'active','2242-06-09',19,13,10),
  (6,'Station de bacta',12000.00,'active','2241-03-21',6,2,1),
  (7,'Extracteur de Tibanna',700000.00,'active','2240-09-01',3,10,9),
  (8,'Mine de beskar',15000.00,'hors_service','2242-01-28',2,5,9),
  (9,'Complexe kyber',800.00,'en_maintenance','2244-08-03',5,12,6),
  (10,'Usine de plastacier',110000.00,'active','2243-02-15',20,1,1),
  (11,'Parc solaire',1500000.00,'active','2244-05-20',13,8,8),
  (12,'Scierie forestière',40000.00,'active','2241-12-07',8,14,4),
  (13,'Fonderie de duracier',95000.00,'planifiée','2246-06-18',1,1,1),
  (14,'Station de dessalement',500000.00,'active','2240-07-23',7,7,7),
  (15,'Mine de titane',20000.00,'active','2243-09-29',12,9,5);

-- 4) Contrôle des planètes (15 enregistrements, dont 10 sans date de fin)
-- Interprétés “côté Empire” (alliés = structures impériales, hostiles = opposants)
INSERT INTO Controle_Planete (pl_id, fa_id, cp_date_debut, cp_date_fin, cp_niveau) VALUES
  (1,1,'2239-01-01',NULL,85),
  (1,2,'2235-01-01','2239-01-01',60),
  (1,11,'2244-03-01',NULL,40),
  (2,4,'2238-06-15',NULL,55),
  (2,1,'2242-02-10',NULL,35),
  (3,1,'2240-12-01','2242-12-01',20),
  (4,14,'2241-04-10',NULL,70),
  (5,9,'2240-05-05',NULL,65),
  (5,2,'2237-01-01','2240-05-05',50),
  (6,12,'2241-08-22',NULL,75),
  (7,7,'2239-09-09',NULL,80),
  (8,8,'2238-03-03',NULL,78),
  (9,10,'2240-01-20',NULL,72),
  (10,13,'2238-07-14','2243-08-30',85),
  (10,3,'2243-09-01',NULL,68);

-- 5) Contient_Ressource (30 enregistrements)
INSERT INTO Contient_Ressource (pl_id, re_id, cr_reserve_estimee, cr_diff_extraction, `cr_qualité`) VALUES
  -- Coruscant (1)
  (1,20,9000000.00,2,'moyenne'),
  (1,6,120000.00,2,'élevée'),
  (1,15,500000.00,1,'élevée'),
  -- Tatooine (2)
  (2,14,80000.00,2,'élevée'),
  (2,7,3000000.00,3,'faible'),
  (2,4,150000.00,4,'moyenne'),
  -- Hoth (3)
  (3,7,7000000.00,5,'faible'),
  (3,11,22000.00,4,'faible'),
  (3,13,90000000.00,2,'moyenne'),
  -- Endor (4)
  (4,8,1200000.00,1,'élevée'),
  (4,19,450000.00,1,'élevée'),
  (4,1,35000.00,3,'moyenne'),
  -- Naboo (5)
  (5,12,50000.00,2,'moyenne'),
  (5,9,90000.00,2,'moyenne'),
  (5,7,12000000.00,1,'élevée'),
  (5,19,800000.00,1,'élevée'),
  -- Mustafar (6)
  (6,5,1200.00,5,'moyenne'),
  (6,1,60000.00,3,'moyenne'),
  (6,11,40000.00,4,'faible'),
  -- Kamino (7)
  (7,7,950000000.00,1,'élevée'),
  (7,6,300000.00,2,'élevée'),
  (7,18,25000.00,3,'moyenne'),
  -- Kashyyyk (8)
  (8,8,2500000.00,2,'élevée'),
  (8,10,110000.00,3,'moyenne'),
  (8,13,140000000.00,1,'élevée'),
  -- Bespin (9)
  (9,3,600000000.00,2,'élevée'),
  (9,18,52000.00,4,'moyenne'),
  -- Alderaan (10)
  (10,19,1200000.00,1,'élevée'),
  (10,12,18000.00,2,'moyenne'),
  (10,15,90000.00,2,'élevée');

