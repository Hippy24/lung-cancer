library(shiny)
library(bslib)
library(dplyr)
library(plotly)
library(DT)

# ── Données ───────────────────────────────────────────────────
df_raw <- read.csv("lung_cancer_dataset.csv", stringsAsFactors = FALSE)
df_raw$Is_Child <- df_raw$Age < 18

STAGE_COLORS  <- c("Stage I"="#70AD47","Stage II"="#4A9EDB",
                   "Stage III"="#ED7D31","Stage IV"="#C00000")
GENDER_COLORS <- c("Male"="#4A9EDB","Female"="#ED7D31")
SURV_COLORS   <- c("Yes"="#70AD47","No"="#C00000")

fmt_pct <- function(x) paste0(round(x * 100, 1), "%")

`%||%` <- function(a, b) if (!is.null(a) && length(a) > 0) a else b

# ── Traductions ────────────────────────────────────────────────
i18n <- list(
  fr = list(
    app_title        = "Lung Cancer Dashboard",
    lang_btn         = "EN",
    dark_btn_on      = "\u2600 Mode clair",
    dark_btn_off     = "\u263e Mode sombre",
    tab_overview     = " Vue globale",
    tab_geo          = " G\u00e9ographie",
    tab_treat        = " Traitements",
    tab_data         = " Donn\u00e9es",
    filters          = "Filtres",
    who_region       = "R\u00e9gion OMS",
    country          = "Pays",
    all_regions      = "Toutes",
    all_countries    = "Tous",
    all_years        = "Toutes",
    cancer_stage     = "Stade du cancer",
    gender           = "Genre",
    age_range        = "Tranche d'\u00e2ge",
    diag_year        = "Ann\u00e9e de diagnostic",
    reset_filters    = "R\u00e9initialiser les filtres",
    kpi_total        = "Total patients",
    kpi_surv         = "Taux de survie",
    kpi_men          = "Hommes",
    kpi_women        = "Femmes",
    kpi_children     = "Enfants (<18)",
    kpi_meta         = "Avec m\u00e9tastases",
    kpi_surv_sub     = "survivants",
    kpi_child_sub    = "dans la s\u00e9lection",
    kpi_meta_sub     = "patients",
    plot_stage_gender= "R\u00e9partition par stade et genre",
    plot_surv_stage  = "Taux de survie par stade",
    plot_age_dist    = "Distribution par \u00e2ge et genre",
    plot_smoke_surv  = "Statut tabagique & survie",
    geo_filters      = "Filtres g\u00e9ographiques",
    geo_metric       = "Indicateur affich\u00e9",
    geo_map_title    = "Carte mondiale \u2013 indicateur par pays",
    geo_rank_title   = "Classement par pays",
    metric_total     = "Nb total patients",
    metric_surv_rate = "Taux de survie (%)",
    metric_women     = "Nb femmes",
    metric_men       = "Nb hommes",
    metric_children  = "Nb enfants (<18 ans)",
    metric_tumor     = "Taille tumorale moy. (cm)",
    metric_surv_mo   = "Survie moyenne (mois)",
    stage_label      = "Stade",
    col_country      = "Pays",
    col_region       = "R\u00e9gion",
    col_total        = "Total",
    col_women        = "Femmes",
    col_men          = "Hommes",
    col_children     = "Enfants (<18)",
    col_survived     = "Survivants",
    col_surv_rate    = "Taux survie (%)",
    col_surv_mo      = "Survie moy (mois)",
    col_tumor        = "Taille tumor (cm)",
    col_metastasis   = "Avec m\u00e9tastases",
    plot_treat_surv  = "Taux de survie par traitement",
    plot_mutations   = "Mutations g\u00e9n\u00e9tiques",
    plot_cancer_type = "Type de cancer",
    plot_heatmap     = "Survie moy. (mois) par traitement et stade",
    plot_diag        = "M\u00e9thodes de diagnostic",
    data_title       = "Donn\u00e9es filtr\u00e9es",
    download_btn     = "T\u00e9l\u00e9charger CSV filtr\u00e9",
    nb_patients      = "Nb patients",
    surv_rate_pct    = "Taux de survie (%)",
    age_range_lbl    = "Tranche d'\u00e2ge",
    surv_months_lbl  = "mois",
    surv_hover       = "Survie",
    total_pts_hover  = "Total patients",
    type_sclc        = "SCLC",
    type_adeno       = "NSCLC \u2013 Ad\u00e9nocarcinome",
    type_squam       = "NSCLC \u2013 Cellules squameuses",
    type_large       = "NSCLC \u2013 Grandes cellules",
    type_other       = "NSCLC \u2013 Autre"
  ),
  en = list(
    app_title        = "Lung Cancer Dashboard",
    lang_btn         = "FR",
    dark_btn_on      = "\u2600 Light mode",
    dark_btn_off     = "\u263e Dark mode",
    tab_overview     = " Overview",
    tab_geo          = " Geography",
    tab_treat        = " Treatments",
    tab_data         = " Data",
    filters          = "Filters",
    who_region       = "WHO Region",
    country          = "Country",
    all_regions      = "All",
    all_countries    = "All",
    all_years        = "All",
    cancer_stage     = "Cancer stage",
    gender           = "Gender",
    age_range        = "Age range",
    diag_year        = "Diagnosis year",
    reset_filters    = "Reset filters",
    kpi_total        = "Total patients",
    kpi_surv         = "Survival rate",
    kpi_men          = "Men",
    kpi_women        = "Women",
    kpi_children     = "Children (<18)",
    kpi_meta         = "With metastasis",
    kpi_surv_sub     = "survivors",
    kpi_child_sub    = "in selection",
    kpi_meta_sub     = "patients",
    plot_stage_gender= "Distribution by stage and gender",
    plot_surv_stage  = "Survival rate by stage",
    plot_age_dist    = "Age distribution by gender",
    plot_smoke_surv  = "Smoking status & survival",
    geo_filters      = "Geographic filters",
    geo_metric       = "Displayed indicator",
    geo_map_title    = "World map \u2013 indicator by country",
    geo_rank_title   = "Country ranking",
    metric_total     = "Total patients",
    metric_surv_rate = "Survival rate (%)",
    metric_women     = "Women count",
    metric_men       = "Men count",
    metric_children  = "Children count (<18)",
    metric_tumor     = "Avg tumor size (cm)",
    metric_surv_mo   = "Avg survival (months)",
    stage_label      = "Stage",
    col_country      = "Country",
    col_region       = "Region",
    col_total        = "Total",
    col_women        = "Women",
    col_men          = "Men",
    col_children     = "Children (<18)",
    col_survived     = "Survived",
    col_surv_rate    = "Survival rate (%)",
    col_surv_mo      = "Avg survival (mo)",
    col_tumor        = "Tumor size (cm)",
    col_metastasis   = "With metastasis",
    plot_treat_surv  = "Survival rate by treatment",
    plot_mutations   = "Genetic mutations",
    plot_cancer_type = "Cancer type",
    plot_heatmap     = "Avg survival (months) by treatment & stage",
    plot_diag        = "Diagnosis methods",
    data_title       = "Filtered data",
    download_btn     = "Download filtered CSV",
    nb_patients      = "No. of patients",
    surv_rate_pct    = "Survival rate (%)",
    age_range_lbl    = "Age range",
    surv_months_lbl  = "months",
    surv_hover       = "Survival",
    total_pts_hover  = "Total patients",
    type_sclc        = "SCLC",
    type_adeno       = "NSCLC \u2013 Adenocarcinoma",
    type_squam       = "NSCLC \u2013 Squamous Cell",
    type_large       = "NSCLC \u2013 Large Cell",
    type_other       = "NSCLC \u2013 Other"
  )
)

# ── Mode clair de la page ─────────────────────────────────────────────────
css_light <- "
  body {
    background-color: #F8F9FA !important;
    background-image:
      linear-gradient(rgba(248,249,250,0.92), rgba(248,249,250,0.92)),
      url('https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Blausen_0864_TracheaLungs.png/800px-Blausen_0864_TracheaLungs.png');
    background-size: 55%;
    background-position: center center;
    background-repeat: no-repeat;
    background-attachment: fixed;
  }
  .navbar { background: linear-gradient(90deg,#1F4E79,#2E75B6) !important; }
  .navbar-brand, .nav-link, .navbar .btn { color:#fff !important; }
  .kpi-box { background:#fff; border-left:5px solid #2E75B6; border-radius:10px;
              padding:16px 20px; box-shadow:0 2px 8px rgba(0,0,0,.08); margin-bottom:14px; }
  .kpi-box.green  { border-color:#70AD47; }
  .kpi-box.red    { border-color:#C00000; }
  .kpi-box.orange { border-color:#ED7D31; }
  .kpi-box.purple { border-color:#7030A0; }
  .kpi-label { font-size:12px; color:#6c757d; text-transform:uppercase; letter-spacing:.06em; margin-bottom:4px; }
  .kpi-value { font-size:28px; font-weight:700; color:#1F4E79; }
  .kpi-sub   { font-size:12px; color:#888; margin-top:3px; }
  .section-title { font-size:15px; font-weight:600; color:#1F4E79; margin-bottom:10px;
                   border-bottom:2px solid #EBF3FB; padding-bottom:6px;
                   text-align:center; }
  .card { background:#fff; border-radius:12px; box-shadow:0 2px 10px rgba(0,0,0,.06);
          border:none; padding:18px; margin-bottom:16px; }
  .sidebar-panel { background:#fff; border-radius:12px; box-shadow:0 2px 10px rgba(0,0,0,.06);
                   border:none; padding:18px; }
  hr.filter-sep { border-color:#EBF3FB; margin:12px 0; }
  .lang-toggle { border-radius:20px !important; font-size:12px !important;
                 padding:4px 14px !important; font-weight:600;
                 background:#fff !important; color:#1F4E79 !important;
                 border:1.5px solid #fff !important; }
  .dark-toggle  { border-radius:20px !important; font-size:12px !important;
                  padding:4px 14px !important; font-weight:600;
                  background:transparent !important; color:#fff !important;
                  border:1.5px solid rgba(255,255,255,.5) !important; }
  .tab-link { color:#fff !important; opacity:.7; padding:6px 12px; cursor:pointer;
              text-decoration:none; font-size:14px; border-bottom:2px solid transparent; }
  .tab-link.active { opacity:1; border-bottom:2px solid #fff; font-weight:600; }
"

# ── Mode sombre de la page ────────────────────────────────────────────────
css_dark <- "
  body {
    background-color: #0F1923 !important;
    background-image:
      linear-gradient(rgba(15,25,35,0.90), rgba(15,25,35,0.90)),
      url('https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Blausen_0864_TracheaLungs.png/800px-Blausen_0864_TracheaLungs.png');
    background-size: 55%;
    background-position: center center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    color: #E2EAF4 !important;
  }
  .navbar { background: linear-gradient(90deg,#0d2137,#1a3d5c) !important; }
  .navbar-brand, .nav-link, .navbar .btn { color:#E2EAF4 !important; }
  .kpi-box { background:#1A2A3A; border-left:5px solid #4A9EDB; border-radius:10px;
              padding:16px 20px; box-shadow:0 2px 8px rgba(0,0,0,.3); margin-bottom:14px; }
  .kpi-box.green  { border-color:#70AD47; }
  .kpi-box.red    { border-color:#E05555; }
  .kpi-box.orange { border-color:#ED7D31; }
  .kpi-box.purple { border-color:#9B59D0; }
  .kpi-label { font-size:12px; color:#8BA7C2; text-transform:uppercase; letter-spacing:.06em; margin-bottom:4px; }
  .kpi-value { font-size:28px; font-weight:700; color:#7EC8F5; }
  .kpi-sub   { font-size:12px; color:#6A8FA8; margin-top:3px; }
  .section-title { font-size:15px; font-weight:600; color:#7EC8F5; margin-bottom:10px;
                   border-bottom:2px solid #1E3448; padding-bottom:6px;
                   text-align:center; }
  .card { background:#152030; border-radius:12px; box-shadow:0 2px 10px rgba(0,0,0,.3);
          border:1px solid #1E3448; padding:18px; margin-bottom:16px; }
  .sidebar-panel { background:#152030; border-radius:12px; box-shadow:0 2px 10px rgba(0,0,0,.3);
                   border:1px solid #1E3448; padding:18px; }
  hr.filter-sep { border-color:#1E3448; margin:12px 0; }
  label, .control-label, h6 { color:#B0CCE4 !important; }
  .form-check-label { color:#B0CCE4 !important; }
  input[type=checkbox] { accent-color:#4A9EDB; }
  .irs--shiny .irs-bar { background:#4A9EDB !important; border-color:#4A9EDB !important; }
  .irs--shiny .irs-handle { border-color:#4A9EDB !important; }
  .selectize-input { background:#1A2A3A !important; color:#E2EAF4 !important;
                     border-color:#2A4A6A !important; }
  .lang-toggle { border-radius:20px !important; font-size:12px !important;
                 padding:4px 14px !important; font-weight:600;
                 background:#1A3050 !important; color:#7EC8F5 !important;
                 border:1.5px solid #4A9EDB !important; }
  .dark-toggle  { border-radius:20px !important; font-size:12px !important;
                  padding:4px 14px !important; font-weight:600;
                  background:transparent !important; color:#E2EAF4 !important;
                  border:1.5px solid rgba(255,255,255,.3) !important; }
  .tab-link { color:#E2EAF4 !important; opacity:.6; padding:6px 12px; cursor:pointer;
              text-decoration:none; font-size:14px; border-bottom:2px solid transparent; }
  .tab-link.active { opacity:1; border-bottom:2px solid #7EC8F5; font-weight:600; }
  table.dataTable tbody tr { background:#152030 !important; color:#E2EAF4 !important; }
  table.dataTable tbody tr:hover { background:#1E3448 !important; }
  .dataTables_wrapper, .dataTables_info, .dataTables_length,
  .dataTables_filter, .dataTables_paginate { color:#B0CCE4 !important; }
"
