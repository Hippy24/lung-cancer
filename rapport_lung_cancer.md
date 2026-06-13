# Rapport Académique — Analyse du Cancer du Poumon à l'Échelle Mondiale (2015–2025)
# Academic Report — Global Lung Cancer Analysis (2015–2025)

**Auteurs / Authors :** Analyse réalisée sur la base du dataset *Lung Cancer Global Clinical & Risk Factor Dataset* (v2.0.0) — Khurram Shahzad, sous la supervision du Dr. Aammar Tufail.

**Date :** Juin 2026

**Outil de visualisation / Visualization tool :** Tableau de bord interactif R Shiny (FR/EN, mode clair/sombre)

---

## Table des matières / Table of Contents

1. [Résumé / Abstract](#1-résumé--abstract)
2. [Introduction](#2-introduction)
3. [Données et Méthodologie / Data and Methodology](#3-données-et-méthodologie--data-and-methodology)
4. [Résultats / Results](#4-résultats--results)
5. [Discussion](#5-discussion)
6. [Conclusion](#6-conclusion)
7. [Références / References](#7-références--references)

---

## 1. Résumé / Abstract

### Résumé (Français)

Ce rapport présente une analyse exhaustive d'un dataset clinique mondial sur le cancer du poumon, couvrant 1 500 patients répartis dans 60 pays et 6 régions de l'Organisation Mondiale de la Santé (OMS), sur la période 2015–2025. L'étude porte sur les facteurs de risque, les caractéristiques démographiques, les types de cancer, les stades de diagnostic, les traitements administrés et les taux de survie. Un tableau de bord interactif R Shiny, bilingue (français/anglais) et disponible en mode clair et sombre, a été développé pour faciliter l'exploration visuelle et dynamique des données. Les résultats montrent un taux de survie global de 36,9 %, fortement corrélé au stade de diagnostic : 71,3 % au Stade I contre seulement 3,6 % au Stade IV. La chirurgie s'avère le traitement le plus efficace avec un taux de survie de 65,5 %. Ces résultats soulignent l'importance cruciale du dépistage précoce dans la prise en charge du cancer pulmonaire.

**Mots-clés :** cancer du poumon, survie, facteurs de risque, R Shiny, analyse exploratoire, OMS, NSCLC, SCLC, stade, traitement.

---

### Abstract (English)

This report presents a comprehensive analysis of a global clinical dataset on lung cancer, covering 1,500 patients across 60 countries and 6 World Health Organization (WHO) regions over the period 2015–2025. The study examines risk factors, demographic characteristics, cancer types, diagnostic stages, administered treatments, and survival rates. An interactive R Shiny dashboard — bilingual (French/English) with light and dark mode support — was developed to enable dynamic visual exploration of the data. Results show an overall survival rate of 36.9%, strongly correlated with the stage at diagnosis: 71.3% at Stage I versus only 3.6% at Stage IV. Surgery proves to be the most effective treatment with a survival rate of 65.5%. These findings underscore the critical importance of early screening in lung cancer management.

**Keywords:** lung cancer, survival, risk factors, R Shiny, exploratory analysis, WHO, NSCLC, SCLC, stage, treatment.

---

## 2. Introduction

### 2.1 Contexte / Background

#### Français

Le cancer du poumon représente la première cause de mortalité par cancer dans le monde, avec environ 1,8 million de décès par an, soit 18 % de l'ensemble des décès liés au cancer (GLOBOCAN 2020). Malgré les avancées thérapeutiques significatives des dernières décennies — notamment l'immunothérapie et les thérapies ciblées — le pronostic global demeure sombre, avec un taux de survie à 5 ans d'environ 22 %. Cette réalité épidémiologique justifie la nécessité d'analyses multidimensionnelles portant sur les déterminants de la survie, les disparités géographiques et l'efficacité comparative des traitements.

La présente étude s'inscrit dans une démarche d'exploration de données cliniques synthétiques, inspirées des statistiques réelles de l'OMS et de l'IARC (International Agency for Research on Cancer). Elle vise à identifier les principaux facteurs associés à la survie des patients atteints de cancer pulmonaire, à l'échelle mondiale.

#### English

Lung cancer is the leading cause of cancer-related mortality worldwide, accounting for approximately 1.8 million deaths per year — 18% of all cancer deaths (GLOBOCAN 2020). Despite significant therapeutic advances over recent decades — notably immunotherapy and targeted therapies — the overall prognosis remains poor, with a 5-year survival rate of approximately 22%. This epidemiological reality justifies the need for multidimensional analyses examining determinants of survival, geographic disparities, and comparative treatment efficacy.

This study is part of an exploratory approach to synthetic clinical data, inspired by real-world WHO and IARC (International Agency for Research on Cancer) statistics. It aims to identify the main factors associated with survival in patients with lung cancer at the global level.

---

### 2.2 Objectifs / Objectives

#### Français

Les objectifs de ce projet sont les suivants :

1. **Décrire** les caractéristiques démographiques et cliniques de la population étudiée.
2. **Analyser** la distribution des types de cancer, des stades de diagnostic et des facteurs de risque.
3. **Évaluer** l'impact du stade et du traitement sur la survie des patients.
4. **Comparer** les indicateurs cliniques entre régions géographiques et pays.
5. **Développer** un outil de visualisation interactif (tableau de bord R Shiny) permettant l'exploration dynamique des données.

#### English

The objectives of this project are as follows:

1. **Describe** the demographic and clinical characteristics of the studied population.
2. **Analyze** the distribution of cancer types, diagnostic stages, and risk factors.
3. **Evaluate** the impact of stage and treatment on patient survival.
4. **Compare** clinical indicators across geographic regions and countries.
5. **Develop** an interactive visualization tool (R Shiny dashboard) enabling dynamic data exploration.

---

## 3. Données et Méthodologie / Data and Methodology

### 3.1 Source des données / Data Source

#### Français

Le dataset utilisé est le *Lung Cancer Global Clinical & Risk Factor Dataset* (version 2.0.0), un jeu de données synthétiques conçu à des fins éducatives et de recherche, inspiré des statistiques réelles de l'OMS, du GLOBOCAN 2020, de l'American Cancer Society et du National Cancer Institute (NCI). Il comprend **1 500 enregistrements patients** et **41 variables** couvrant la période **2015 à 2025**.

Ce dataset est distribué sous licence **CC BY-SA 4.0** et ne contient aucune valeur manquante.

#### English

The dataset used is the *Lung Cancer Global Clinical & Risk Factor Dataset* (version 2.0.0), a synthetic dataset designed for educational and research purposes, inspired by real-world WHO, GLOBOCAN 2020, American Cancer Society, and National Cancer Institute (NCI) statistics. It includes **1,500 patient records** and **41 variables** covering the period **2015 to 2025**.

This dataset is distributed under **CC BY-SA 4.0** license and contains no missing values.

---

### 3.2 Description des variables / Variable Description

| Catégorie / Category | Variables |
|---|---|
| Identification | Patient_ID, Diagnosis_Year, Diagnosis_Date |
| Géographie / Geography | WHO_Region, Country |
| Démographie / Demographics | Age, Gender |
| Facteurs de risque / Risk Factors | Smoking_Status, Cigarettes_Per_Day, Years_Smoking, Secondhand_Smoke, Family_History, Occupational_Hazard, Air_Pollution_Exposure, Alcohol_Use, BMI, Exercise_Frequency, Chronic_Lung_Disease, Asbestos_Exposure, Radon_Exposure, Previous_Cancer_History |
| Génétique / Genetics | Genetic_Mutation (EGFR, ALK, KRAS, TP53, ROS1, BRAF, MET, HER2, RET, No Mutation) |
| Symptômes / Symptoms | Coughing, Shortness_of_Breath, Chest_Pain, Coughing_Blood, Fatigue, Weight_Loss, Wheezing, Recurrent_Infections, Swallowing_Difficulty, Finger_Clubbing |
| Clinique / Clinical | Cancer_Type, NSCLC_Subtype, Cancer_Stage, Tumor_Size_cm, Metastasis, Diagnosis_Method |
| Traitement / Treatment | Treatment |
| Pronostic / Prognosis | Survival_Months, Survived (variable cible / target variable) |

---

### 3.3 Méthodologie / Methodology

#### Français

L'analyse a été conduite en trois phases :

**Phase 1 — Exploration et nettoyage des données**
Le dataset ne présentant aucune valeur manquante, le prétraitement s'est limité à la vérification des types de variables, à la création de variables dérivées (catégorie d'âge, indicateur enfant < 18 ans) et à la validation de la cohérence des données.

**Phase 2 — Analyse exploratoire (EDA)**
Des statistiques descriptives ont été calculées pour chaque variable. Des analyses bivariées et multivariées ont été réalisées pour explorer les relations entre les facteurs de risque, les caractéristiques cliniques et la survie.

**Phase 3 — Développement du tableau de bord R Shiny**
Un tableau de bord interactif a été développé en R, utilisant les packages `shiny`, `bslib`, `plotly`, `dplyr` et `DT`. L'application propose quatre onglets thématiques (Vue globale, Géographie, Traitements, Données), un système de filtres dynamiques, une interface bilingue français/anglais, ainsi qu'un mode d'affichage clair et sombre.

#### English

The analysis was conducted in three phases:

**Phase 1 — Data Exploration and Cleaning**
As the dataset contained no missing values, preprocessing was limited to variable type verification, creation of derived variables (age category, child indicator < 18 years), and data consistency validation.

**Phase 2 — Exploratory Data Analysis (EDA)**
Descriptive statistics were calculated for each variable. Bivariate and multivariate analyses were performed to explore relationships between risk factors, clinical characteristics, and survival.

**Phase 3 — R Shiny Dashboard Development**
An interactive dashboard was developed in R using the `shiny`, `bslib`, `plotly`, `dplyr`, and `DT` packages. The application features four thematic tabs (Global Overview, Geography, Treatments, Data), a dynamic filter system, a bilingual French/English interface, and both light and dark display modes.

---

## 4. Résultats / Results

### 4.1 Caractéristiques démographiques / Demographic Characteristics

#### Français

La cohorte comprend **1 500 patients** diagnostiqués entre 2015 et 2025, répartis dans **60 pays** et **6 régions OMS**. L'âge moyen au diagnostic est de **60,7 ans** (étendue : 30–89 ans). La population est composée de **62,3 % d'hommes** (n = 934) et **37,7 % de femmes** (n = 566).

La région du **Pacifique occidental** est la plus représentée avec 465 patients (31,0 %), suivie de l'Europe (298 patients, 19,9 %) et des Amériques (255 patients, 17,0 %). La région Afrique est la moins représentée avec 90 patients (6,0 %).

#### English

The cohort includes **1,500 patients** diagnosed between 2015 and 2025, distributed across **60 countries** and **6 WHO regions**. The mean age at diagnosis is **60.7 years** (range: 30–89 years). The population consists of **62.3% men** (n = 934) and **37.7% women** (n = 566).

The **Western Pacific** region is the most represented with 465 patients (31.0%), followed by Europe (298 patients, 19.9%) and the Americas (255 patients, 17.0%). The Africa region is the least represented with 90 patients (6.0%).

---

### 4.2 Types de cancer et stades / Cancer Types and Stages

#### Français

Le **cancer du poumon non à petites cellules (NSCLC)** représente la grande majorité des cas avec **89,0 %** des patients (n = 1 335), contre **11,0 %** pour le cancer du poumon à petites cellules (SCLC, n = 165). Parmi les sous-types NSCLC, l'adénocarcinome est le plus fréquent (n = 850, 56,7 % du total), suivi du carcinome épidermoïde (n = 282, 18,8 %) et du carcinome à grandes cellules (n = 203, 13,5 %).

La répartition par stade au diagnostic est relativement équilibrée :

| Stade | Nb patients | % | Taux de survie |
|---|---|---|---|
| Stage I  | 436 | 29,1 % | **71,3 %** |
| Stage II | 356 | 23,7 % | **50,0 %** |
| Stage III | 351 | 23,4 % | **14,5 %** |
| Stage IV | 357 | 23,8 % | **3,6 %** |

Le gradient de survie entre le Stade I et le Stade IV est particulièrement saisissant, avec un écart de **67,7 points de pourcentage**.

#### English

**Non-small cell lung cancer (NSCLC)** represents the vast majority of cases with **89.0%** of patients (n = 1,335), versus **11.0%** for small cell lung cancer (SCLC, n = 165). Among NSCLC subtypes, adenocarcinoma is the most frequent (n = 850, 56.7% of total), followed by squamous cell carcinoma (n = 282, 18.8%) and large cell carcinoma (n = 203, 13.5%).

The distribution by stage at diagnosis is relatively balanced:

| Stage | No. patients | % | Survival rate |
|---|---|---|---|
| Stage I  | 436 | 29.1% | **71.3%** |
| Stage II | 356 | 23.7% | **50.0%** |
| Stage III | 351 | 23.4% | **14.5%** |
| Stage IV | 357 | 23.8% | **3.6%** |

The survival gradient between Stage I and Stage IV is particularly striking, with a gap of **67.7 percentage points**.

---

### 4.3 Facteurs de risque / Risk Factors

#### Français

Contrairement à l'épidémiologie classique, la majorité des patients de ce dataset n'a jamais fumé (**65,3 %**, n = 979). Les fumeurs actifs représentent 24,3 % (n = 364) et les anciens fumeurs 10,5 % (n = 157). Cette distribution peut refléter des tendances émergentes liées à d'autres facteurs de risque environnementaux et génétiques.

Concernant les mutations génétiques, **37,1 %** des patients ne présentent aucune mutation identifiée (n = 556). Parmi les mutations détectées, les plus fréquentes sont :

- **EGFR** : 18,6 % (n = 279)
- **KRAS** : 13,7 % (n = 205)
- **ALK** : 9,5 % (n = 143)
- **TP53** : 8,5 % (n = 128)

Le taux de métastases s'élève à **28,2 %** (n = 423), avec une taille tumorale moyenne de **4,59 cm** au diagnostic.

#### English

Contrary to classical epidemiology, the majority of patients in this dataset have never smoked (**65.3%**, n = 979). Current smokers represent 24.3% (n = 364) and former smokers 10.5% (n = 157). This distribution may reflect emerging trends related to other environmental and genetic risk factors.

Regarding genetic mutations, **37.1%** of patients present no identified mutation (n = 556). Among detected mutations, the most frequent are:

- **EGFR**: 18.6% (n = 279)
- **KRAS**: 13.7% (n = 205)
- **ALK**: 9.5% (n = 143)
- **TP53**: 8.5% (n = 128)

The metastasis rate is **28.2%** (n = 423), with a mean tumor size of **4.59 cm** at diagnosis.

---

### 4.4 Traitements et survie / Treatments and Survival

#### Français

Le taux de survie global de la cohorte est de **36,9 %**, avec une durée médiane de survie post-diagnostic de **31,2 mois**. L'analyse par modalité thérapeutique révèle des disparités considérables :

| Traitement | Taux de survie |
|---|---|
| Chirurgie (Surgery) | **65,5 %** |
| Chirurgie + Chimiothérapie | **51,6 %** |
| Radiothérapie | **44,4 %** |
| Thérapie ciblée | **29,9 %** |
| Immunothérapie | **24,1 %** |
| Chimiothérapie | **17,8 %** |
| Soins palliatifs | **13,5 %** |
| Chimio + Radiothérapie | **9,0 %** |

La chirurgie, utilisée généralement pour les stades précoces, présente le meilleur pronostic. À l'inverse, la combinaison chimiothérapie + radiothérapie, souvent réservée aux stades avancés, affiche le taux le plus faible.

#### English

The overall survival rate of the cohort is **36.9%**, with a median post-diagnosis survival of **31.2 months**. Analysis by treatment modality reveals considerable disparities:

| Treatment | Survival rate |
|---|---|
| Surgery | **65.5%** |
| Surgery + Chemotherapy | **51.6%** |
| Radiotherapy | **44.4%** |
| Targeted Therapy | **29.9%** |
| Immunotherapy | **24.1%** |
| Chemotherapy | **17.8%** |
| Palliative Care | **13.5%** |
| Chemo + Radiation | **9.0%** |

Surgery, generally used for early-stage disease, shows the best prognosis. Conversely, the chemo + radiation combination, typically reserved for advanced stages, shows the lowest rate.

---

### 4.5 Tableau de bord R Shiny / R Shiny Dashboard

#### Français

Dans le cadre de ce projet, un tableau de bord interactif a été développé sous R Shiny. Il est structuré en **3 fichiers** (`global.R`, `ui.R`, `server.R`) et **4 onglets** :

- **Vue globale** : KPIs dynamiques (total patients, taux de survie, hommes, femmes, enfants, métastases), filtres croisés (région OMS, pays, stade, genre, âge, année), et 4 graphiques interactifs.
- **Géographie** : Carte choroplèthe mondiale (7 indicateurs au choix), classement interactif des 60 pays.
- **Traitements** : Analyse comparative des traitements, mutations génétiques (donut), types de cancer, heatmap survie × traitement × stade, méthodes de diagnostic.
- **Données** : Table filtrée exportable en CSV.

L'application propose une **interface bilingue** (FR/EN) et un **mode sombre/clair**, tous deux activables par bouton en temps réel, sans rechargement de la page.

**Packages utilisés :** `shiny`, `bslib`, `dplyr`, `plotly`, `DT`

#### English

As part of this project, an interactive dashboard was developed in R Shiny. It is structured into **3 files** (`global.R`, `ui.R`, `server.R`) and **4 tabs**:

- **Global Overview**: Dynamic KPIs (total patients, survival rate, men, women, children, metastases), cross-filters (WHO region, country, stage, gender, age, year), and 4 interactive charts.
- **Geography**: World choropleth map (7 selectable indicators), interactive ranking of 60 countries.
- **Treatments**: Comparative treatment analysis, genetic mutations (donut), cancer types, survival × treatment × stage heatmap, diagnosis methods.
- **Data**: Filtered table exportable as CSV.

The application features a **bilingual interface** (FR/EN) and **dark/light mode**, both togglable in real time without page reload.

**Packages used:** `shiny`, `bslib`, `dplyr`, `plotly`, `DT`

---

## 5. Discussion

### Français

Les résultats de cette analyse confirment plusieurs tendances établies dans la littérature oncologique mondiale. Le gradient de survie en fonction du stade de diagnostic constitue la relation la plus robuste identifiée : un patient diagnostiqué au Stade I a près de **20 fois plus de chances de survivre** qu'un patient diagnostiqué au Stade IV (71,3 % vs 3,6 %). Ce constat plaide en faveur de stratégies de dépistage précoce, notamment le scanner thoracique à faible dose (LDCT) recommandé pour les populations à risque.

La prédominance de l'adénocarcinome parmi les sous-types NSCLC (56,7 %) est cohérente avec les tendances épidémiologiques modernes, en particulier dans les populations non fumeuses où ce sous-type est le plus fréquent. La forte prévalence de la mutation EGFR (18,6 %) revêt une importance clinique particulière, dans la mesure où elle constitue une cible privilégiée pour les thérapies ciblées (inhibiteurs de tyrosine kinase).

Sur le plan thérapeutique, la supériorité de la chirurgie en termes de survie (65,5 %) doit être interprétée avec prudence, car elle reflète en partie un biais de sélection : les patients éligibles à la chirurgie sont généralement diagnostiqués à des stades précoces et présentent un meilleur état général.

La distribution géographique montre une surrepréentation de la région Pacifique occidental, cohérente avec la prévalence élevée du cancer pulmonaire en Asie de l'Est, notamment en lien avec la pollution atmosphérique et des facteurs génétiques spécifiques.

### English

The results of this analysis confirm several established trends in global oncological literature. The survival gradient according to diagnostic stage represents the most robust relationship identified: a patient diagnosed at Stage I has nearly **20 times greater survival chances** than a patient diagnosed at Stage IV (71.3% vs 3.6%). This finding argues for early screening strategies, particularly low-dose computed tomography (LDCT) recommended for at-risk populations.

The predominance of adenocarcinoma among NSCLC subtypes (56.7%) is consistent with modern epidemiological trends, particularly in non-smoking populations where this subtype is most frequent. The high prevalence of EGFR mutation (18.6%) is of particular clinical importance, as it constitutes a preferred target for targeted therapies (tyrosine kinase inhibitors).

Regarding treatment, the superiority of surgery in terms of survival (65.5%) should be interpreted cautiously, as it partly reflects a selection bias: patients eligible for surgery are generally diagnosed at earlier stages and present better general health status.

The geographic distribution shows over-representation of the Western Pacific region, consistent with the high prevalence of lung cancer in East Asia, notably linked to air pollution and specific genetic factors.

---

## 6. Conclusion

### Français

Cette étude a permis d'analyser de manière exhaustive un dataset mondial sur le cancer du poumon regroupant 1 500 patients issus de 60 pays. Les principaux enseignements sont les suivants :

- Le **stade au diagnostic** est le déterminant le plus puissant de la survie, avec des taux passant de 71,3 % (Stade I) à 3,6 % (Stade IV).
- La **chirurgie** est le traitement associé au meilleur pronostic (65,5 % de survie).
- Le **NSCLC** représente 89 % des cas, avec une nette prédominance de l'adénocarcinome.
- La mutation **EGFR** est la plus fréquente (18,6 %), ouvrant des perspectives importantes pour les thérapies ciblées.
- Le tableau de bord R Shiny développé offre un outil d'exploration interactif, bilingue et adaptatif, facilitant l'analyse pour des utilisateurs aux profils variés.

Ces résultats confirment l'impératif du **dépistage précoce** comme levier principal d'amélioration du pronostic du cancer pulmonaire. Des études futures devraient intégrer des analyses de survie formelles (courbes de Kaplan-Meier, modèle de Cox) et des approches de machine learning pour la prédiction de la survie.

### English

This study provided a comprehensive analysis of a global lung cancer dataset comprising 1,500 patients from 60 countries. The key findings are as follows:

- **Stage at diagnosis** is the most powerful determinant of survival, with rates ranging from 71.3% (Stage I) to 3.6% (Stage IV).
- **Surgery** is the treatment associated with the best prognosis (65.5% survival).
- **NSCLC** represents 89% of cases, with a clear predominance of adenocarcinoma.
- The **EGFR** mutation is the most frequent (18.6%), opening significant prospects for targeted therapies.
- The R Shiny dashboard developed provides an interactive, bilingual, and adaptive exploration tool, facilitating analysis for users with diverse profiles.

These results confirm the imperative of **early screening** as the primary lever for improving lung cancer prognosis. Future studies should incorporate formal survival analyses (Kaplan-Meier curves, Cox model) and machine learning approaches for survival prediction.

---

## 7. Références / References

1. **GLOBOCAN 2020** — Global Cancer Statistics 2020. IARC, International Agency for Research on Cancer. *CA: A Cancer Journal for Clinicians*, 71(3), 209–249. https://doi.org/10.3322/caac.21660

2. **World Health Organization (WHO)** — Lung Cancer Fact Sheet. https://www.who.int/news-room/fact-sheets/detail/lung-cancer

3. **American Cancer Society** — Lung Cancer Statistics. https://www.cancer.org/cancer/lung-cancer/about/key-statistics.html

4. **National Cancer Institute (NCI)** — Lung Cancer — Patient Version. https://www.cancer.gov/types/lung

5. **Shahzad, K.** — *Lung Cancer Global Clinical & Risk Factor Dataset* (v2.0.0), 2026. Superviseur : Dr. Aammar Tufail. Disponible sur Kaggle : https://www.kaggle.com/zkskhurram

6. **Chang, W., Cheng, J., Allaire, J.J., et al.** (2023). *shiny: Web Application Framework for R*. R package version 1.7.5. https://CRAN.R-project.org/package=shiny

7. **Sievert, C.** (2020). *Interactive Web-Based Data Visualization with R, plotly, and shiny*. Chapman and Hall/CRC. https://plotly-r.com

8. **Wickham, H., et al.** (2023). *dplyr: A Grammar of Data Manipulation*. R package version 1.1.3. https://CRAN.R-project.org/package=dplyr

9. **Travis, W.D., et al.** (2015). The 2015 World Health Organization Classification of Lung Tumors. *Journal of Thoracic Oncology*, 10(9), 1243–1260.

10. **Siegel, R.L., Miller, K.D., & Jemal, A.** (2023). Cancer Statistics, 2023. *CA: A Cancer Journal for Clinicians*, 73(1), 17–48.

---

*Rapport généré dans le cadre d'un projet d'analyse de données cliniques. / Report generated as part of a clinical data analysis project.*

*Données synthétiques à usage éducatif uniquement. / Synthetic data for educational use only.*