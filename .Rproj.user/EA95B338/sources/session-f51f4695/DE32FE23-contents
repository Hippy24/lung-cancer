# global.R est chargé automatiquement — i18n, css_light, css_dark, df_raw, etc. sont disponibles

server <- function(input, output, session) {
  
  # ── État réactif ──────────────────────────────────────────
  lang       <- reactiveVal("fr")
  dark_mode  <- reactiveVal(FALSE)
  active_tab <- reactiveVal("overview")
  
  tr <- reactive({ i18n[[lang()]] })
  
  txt_color  <- reactive({ if (dark_mode()) "#E2EAF4" else "#1C2B4A" })
  grid_color <- reactive({ if (dark_mode()) "#1E3448" else "#F0F0F0" })
  
  # ── Toggles ───────────────────────────────────────────────
  observeEvent(input$btn_lang, {
    lang(if (lang() == "fr") "en" else "fr")
    updateActionButton(session, "btn_lang", label = tr()$lang_btn)
  })
  
  observeEvent(input$btn_dark, {
    dark_mode(!dark_mode())
    updateActionButton(session, "btn_dark",
                       label = if (dark_mode()) tr()$dark_btn_on else tr()$dark_btn_off)
  })
  
  observeEvent(input$active_tab_click, {
    active_tab(input$active_tab_click)
  })
  
  # ── CSS dynamique ─────────────────────────────────────────
  output$dynamic_css <- renderUI({
    tags$head(tags$style(HTML(if (dark_mode()) css_dark else css_light)))
  })
  
  # ── Navigation ────────────────────────────────────────────
  output$nav_tabs_ui <- renderUI({
    tabs <- list(
      list(id="overview", label=tr()$tab_overview),
      list(id="geo",      label=tr()$tab_geo),
      list(id="treat",    label=tr()$tab_treat),
      list(id="data",     label=tr()$tab_data)
    )
    do.call(tags$div, c(list(class="d-flex gap-1 align-items-center"),
                        lapply(tabs, function(tab) {
                          cls <- paste("tab-link", if (active_tab() == tab$id) "active" else "")
                          tags$span(class=cls,
                                    onclick=paste0("Shiny.setInputValue('active_tab_click','",
                                                   tab$id, "',{priority:'event'})"),
                                    tab$label)
                        })
    ))
  })
  
  # ── Contenu principal (routing) ───────────────────────────
  output$main_content <- renderUI({
    switch(active_tab(),
           "overview" = uiOutput("tab_overview_ui"),
           "geo"      = uiOutput("tab_geo_ui"),
           "treat"    = uiOutput("tab_treat_ui"),
           "data"     = uiOutput("tab_data_ui")
    )
  })
  
  # ═══════════════════════════════════════════════════════════
  # ONGLET 1 – VUE GLOBALE
  # ═══════════════════════════════════════════════════════════
  # Valeurs statiques des listes (calculées une fois)
  region_choices <- reactive({
    c(setNames("all", tr()$all_regions),
      setNames(sort(unique(df_raw$WHO_Region)), sort(unique(df_raw$WHO_Region))))
  })
  year_choices <- reactive({
    yrs <- sort(unique(df_raw$Diagnosis_Year))
    c(setNames("all", tr()$all_years), setNames(as.character(yrs), as.character(yrs)))
  })
  country_choices <- reactive({
    base <- if (is.null(input$sel_region) || input$sel_region == "all") df_raw
    else filter(df_raw, WHO_Region == input$sel_region)
    ctrs <- sort(unique(base$Country))
    c(setNames("all", tr()$all_countries), setNames(ctrs, ctrs))
  })
  
  output$tab_overview_ui <- renderUI({
    fluidRow(
      column(2,
             div(class="sidebar-panel",
                 h6(tr()$filters, style="font-weight:700;font-size:14px;margin-bottom:14px;"),
                 selectInput("sel_region",  tr()$who_region,
                             choices=region_choices(),
                             selected=isolate(input$sel_region) %||% "all", width="100%"),
                 selectInput("sel_country", tr()$country,
                             choices=country_choices(),
                             selected=isolate(input$sel_country) %||% "all", width="100%"),
                 hr(class="filter-sep"),
                 checkboxGroupInput("sel_stage", tr()$cancer_stage,
                                    choices=c("Stage I","Stage II","Stage III","Stage IV"),
                                    selected=isolate(input$sel_stage) %||% c("Stage I","Stage II","Stage III","Stage IV")),
                 hr(class="filter-sep"),
                 checkboxGroupInput("sel_gender", tr()$gender,
                                    choices=c("Male","Female"),
                                    selected=isolate(input$sel_gender) %||% c("Male","Female")),
                 hr(class="filter-sep"),
                 sliderInput("sel_age", tr()$age_range, min=30, max=89,
                             value=isolate(input$sel_age) %||% c(30,89), step=1),
                 hr(class="filter-sep"),
                 selectInput("sel_year", tr()$diag_year,
                             choices=year_choices(),
                             selected=isolate(input$sel_year) %||% "all", width="100%"),
                 actionButton("btn_reset", tr()$reset_filters,
                              class="btn btn-outline-secondary btn-sm w-100 mt-2")
             )
      ),
      column(10,
             fluidRow(
               column(2, uiOutput("kpi_total")),
               column(2, uiOutput("kpi_surv")),
               column(2, uiOutput("kpi_men")),
               column(2, uiOutput("kpi_women")),
               column(2, uiOutput("kpi_children")),
               column(2, uiOutput("kpi_meta"))
             ),
             fluidRow(
               column(6, div(class="card",
                             div(class="section-title", tr()$plot_stage_gender),
                             plotlyOutput("plot_stage_gender", height="260px")
               )),
               column(6, div(class="card",
                             div(class="section-title", tr()$plot_surv_stage),
                             plotlyOutput("plot_surv_stage", height="260px")
               ))
             ),
             fluidRow(
               column(6, div(class="card",
                             div(class="section-title", tr()$plot_age_dist),
                             plotlyOutput("plot_age_dist", height="240px")
               )),
               column(6, div(class="card",
                             div(class="section-title", tr()$plot_smoke_surv),
                             plotlyOutput("plot_smoke_surv", height="240px")
               ))
             )
      )
    )
  })
  
  observeEvent(input$btn_reset, {
    updateSelectInput(session, "sel_region",  selected="all")
    updateSelectInput(session, "sel_country", selected="all")
    updateSelectInput(session, "sel_year",    selected="all")
    updateCheckboxGroupInput(session, "sel_stage",
                             selected=c("Stage I","Stage II","Stage III","Stage IV"))
    updateCheckboxGroupInput(session, "sel_gender", selected=c("Male","Female"))
    updateSliderInput(session, "sel_age", value=c(30,89))
  })
  
  # ── Données filtrées ──────────────────────────────────────
  df_filtered <- reactive({
    req(input$sel_stage, input$sel_gender, input$sel_age)
    d <- df_raw
    if (!is.null(input$sel_region)  && input$sel_region  != "all")
      d <- filter(d, WHO_Region == input$sel_region)
    if (!is.null(input$sel_country) && input$sel_country != "all")
      d <- filter(d, Country    == input$sel_country)
    if (!is.null(input$sel_year)    && input$sel_year    != "all")
      d <- filter(d, Diagnosis_Year == as.integer(input$sel_year))
    filter(d,
           Cancer_Stage %in% input$sel_stage,
           Gender       %in% input$sel_gender,
           Age >= input$sel_age[1], Age <= input$sel_age[2]
    )
  })
  
  # ── KPIs ─────────────────────────────────────────────────
  kpi_box <- function(label, value, sub=NULL, color="") {
    div(class=paste("kpi-box", color),
        div(class="kpi-label", label),
        div(class="kpi-value", value),
        if (!is.null(sub)) div(class="kpi-sub", sub)
    )
  }
  
  output$kpi_total    <- renderUI({ d <- df_filtered()
  kpi_box(tr()$kpi_total, format(nrow(d), big.mark=" ")) })
  output$kpi_surv     <- renderUI({ d <- df_filtered(); s <- sum(d$Survived=="Yes")
  kpi_box(tr()$kpi_surv, fmt_pct(s/nrow(d)), paste(s, tr()$kpi_surv_sub), "green") })
  output$kpi_men      <- renderUI({ d <- df_filtered()
  kpi_box(tr()$kpi_men, format(sum(d$Gender=="Male"), big.mark=" "),
          fmt_pct(mean(d$Gender=="Male"))) })
  output$kpi_women    <- renderUI({ d <- df_filtered()
  kpi_box(tr()$kpi_women, format(sum(d$Gender=="Female"), big.mark=" "),
          fmt_pct(mean(d$Gender=="Female")), "orange") })
  output$kpi_children <- renderUI({ d <- df_filtered()
  kpi_box(tr()$kpi_children, format(sum(d$Is_Child), big.mark=" "),
          tr()$kpi_child_sub, "purple") })
  output$kpi_meta     <- renderUI({ d <- df_filtered()
  kpi_box(tr()$kpi_meta, fmt_pct(mean(d$Metastasis=="Yes")),
          paste(sum(d$Metastasis=="Yes"), tr()$kpi_meta_sub), "red") })
  
  # ── Graphiques onglet 1 ───────────────────────────────────
  output$plot_stage_gender <- renderPlotly({
    d <- df_filtered() %>% group_by(Cancer_Stage, Gender) %>% summarise(n=n(), .groups="drop")
    plot_ly(d, x=~Cancer_Stage, y=~n, color=~Gender, colors=GENDER_COLORS, type="bar",
            text=~n, textposition="inside",
            hovertemplate="<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>") %>%
      layout(barmode="group", paper_bgcolor="rgba(0,0,0,0)", plot_bgcolor="rgba(0,0,0,0)",
             legend=list(orientation="h", y=-0.18, font=list(color=txt_color())),
             xaxis=list(title="", tickfont=list(color=txt_color())),
             yaxis=list(title=tr()$nb_patients, gridcolor=grid_color(), tickfont=list(color=txt_color())),
             font=list(family="Inter", color=txt_color()))
  })
  
  output$plot_surv_stage <- renderPlotly({
    d <- df_filtered() %>%
      group_by(Cancer_Stage) %>%
      summarise(total=n(), rate=round(mean(Survived=="Yes")*100,1), .groups="drop") %>%
      arrange(Cancer_Stage)
    plot_ly(d, x=~Cancer_Stage, y=~rate, type="bar",
            marker=list(color=unname(STAGE_COLORS[d$Cancer_Stage])),
            text=~paste0(rate,"%"), textposition="outside",
            customdata=~total,
            hovertemplate=paste0("<b>%{x}</b><br>",tr()$surv_hover,
                                 ": %{y}%<br>n=%{customdata}<extra></extra>")) %>%
      layout(paper_bgcolor="rgba(0,0,0,0)", plot_bgcolor="rgba(0,0,0,0)",
             xaxis=list(title="", tickfont=list(color=txt_color())),
             yaxis=list(title=tr()$surv_rate_pct, range=c(0,115),
                        gridcolor=grid_color(), tickfont=list(color=txt_color())),
             font=list(family="Inter", color=txt_color()))
  })
  
  output$plot_age_dist <- renderPlotly({
    d <- df_filtered()
    d$bin <- cut(d$Age, breaks=c(30,40,50,60,70,80,90),
                 labels=c("30-39","40-49","50-59","60-69","70-79","80-89"), right=FALSE)
    summ <- d %>% group_by(bin, Gender) %>% summarise(n=n(), .groups="drop")
    plot_ly(summ, x=~bin, y=~n, color=~Gender, colors=GENDER_COLORS, type="bar",
            hovertemplate="<b>%{x}</b> · %{fullData.name}: %{y}<extra></extra>") %>%
      layout(barmode="stack", paper_bgcolor="rgba(0,0,0,0)", plot_bgcolor="rgba(0,0,0,0)",
             legend=list(orientation="h", y=-0.22, font=list(color=txt_color())),
             xaxis=list(title=tr()$age_range_lbl, tickfont=list(color=txt_color())),
             yaxis=list(title=tr()$nb_patients, gridcolor=grid_color(), tickfont=list(color=txt_color())),
             font=list(family="Inter", color=txt_color()))
  })
  
  output$plot_smoke_surv <- renderPlotly({
    d <- df_filtered() %>% group_by(Smoking_Status, Survived) %>% summarise(n=n(), .groups="drop")
    plot_ly(d, x=~Smoking_Status, y=~n, color=~Survived, colors=SURV_COLORS, type="bar",
            hovertemplate="<b>%{x}</b><br>%{fullData.name}: %{y}<extra></extra>") %>%
      layout(barmode="stack", paper_bgcolor="rgba(0,0,0,0)", plot_bgcolor="rgba(0,0,0,0)",
             legend=list(orientation="h", y=-0.25, font=list(color=txt_color())),
             xaxis=list(title="", tickfont=list(color=txt_color())),
             yaxis=list(title=tr()$nb_patients, gridcolor=grid_color(), tickfont=list(color=txt_color())),
             font=list(family="Inter", color=txt_color()))
  })
  
  # ═══════════════════════════════════════════════════════════
  # ONGLET 2 – GÉOGRAPHIE
  # ═══════════════════════════════════════════════════════════
  output$tab_geo_ui <- renderUI({
    fluidRow(
      column(3,
             div(class="sidebar-panel",
                 h6(tr()$geo_filters, style="font-weight:700;font-size:14px;margin-bottom:12px;"),
                 selectInput("geo_region", tr()$who_region,
                             choices=region_choices(),
                             selected=isolate(input$geo_region) %||% "all", width="100%"),
                 selectInput("geo_metric", tr()$geo_metric,
                             choices=c(
                               setNames("total",       tr()$metric_total),
                               setNames("surv_rate",   tr()$metric_surv_rate),
                               setNames("women",       tr()$metric_women),
                               setNames("men",         tr()$metric_men),
                               setNames("children",    tr()$metric_children),
                               setNames("tumor",       tr()$metric_tumor),
                               setNames("surv_months", tr()$metric_surv_mo)
                             ), width="100%"),
                 hr(class="filter-sep"),
                 checkboxGroupInput("geo_stage", tr()$stage_label,
                                    choices=c("Stage I","Stage II","Stage III","Stage IV"),
                                    selected=c("Stage I","Stage II","Stage III","Stage IV"))
             )
      ),
      column(9,
             div(class="card",
                 div(class="section-title", tr()$geo_map_title),
                 plotlyOutput("plot_map", height="380px")
             ),
             div(class="card",
                 div(class="section-title", tr()$geo_rank_title),
                 DTOutput("tbl_country_rank")
             )
      )
    )
  })
  
  df_geo <- reactive({
    req(input$geo_stage)
    d <- df_raw
    if (!is.null(input$geo_region) && input$geo_region != "all")
      d <- filter(d, WHO_Region == input$geo_region)
    filter(d, Cancer_Stage %in% input$geo_stage)
  })
  
  output$plot_map <- renderPlotly({
    d <- df_geo() %>%
      group_by(Country) %>%
      summarise(total=n(), surv_rate=round(mean(Survived=="Yes")*100,1),
                women=sum(Gender=="Female"), men=sum(Gender=="Male"),
                children=sum(Is_Child), tumor=round(mean(Tumor_Size_cm,na.rm=TRUE),2),
                surv_months=round(mean(Survival_Months,na.rm=TRUE),1), .groups="drop")
    metric <- input$geo_metric %||% "total"
    d$value <- d[[metric]]
    ml <- c(total=tr()$metric_total, surv_rate=tr()$metric_surv_rate,
            women=tr()$metric_women, men=tr()$metric_men,
            children=tr()$metric_children, tumor=tr()$metric_tumor,
            surv_months=tr()$metric_surv_mo)
    plot_ly(d, type="choropleth", locations=~Country, locationmode="country names",
            z=~value,
            text=~paste0("<b>",Country,"</b><br>",ml[metric],": ",value,
                         "<br>",tr()$total_pts_hover,": ",total),
            hoverinfo="text", colorscale="Reds",
            marker=list(line=list(color="white", width=0.5))) %>%
      layout(
        geo=list(showframe=FALSE, showcoastlines=TRUE, coastlinecolor="#aaa",
                 projection=list(type="natural earth"), bgcolor="rgba(0,0,0,0)",
                 landcolor =if(dark_mode()) "#1A2A3A" else "#EAF0F8",
                 oceancolor=if(dark_mode()) "#0F1923"  else "#EEF4FF"),
        paper_bgcolor="rgba(0,0,0,0)", margin=list(l=0,r=0,t=0,b=0),
        font=list(family="Inter", color=txt_color()))
  })
  
  output$tbl_country_rank <- renderDT({
    d <- df_geo() %>%
      group_by(Country, WHO_Region) %>%
      summarise(a=n(), b=sum(Gender=="Female"), c=sum(Gender=="Male"),
                d2=sum(Is_Child), e=sum(Survived=="Yes"),
                f=round(mean(Survived=="Yes")*100,1),
                g=round(mean(Survival_Months),1),
                h=round(mean(Tumor_Size_cm),2),
                i=sum(Metastasis=="Yes"), .groups="drop") %>%
      arrange(desc(a))
    names(d) <- c(tr()$col_country, tr()$col_region, tr()$col_total,
                  tr()$col_women, tr()$col_men, tr()$col_children,
                  tr()$col_survived, tr()$col_surv_rate,
                  tr()$col_surv_mo, tr()$col_tumor, tr()$col_metastasis)
    col_sr <- tr()$col_surv_rate
    datatable(d,
              options=list(pageLength=10, scrollX=TRUE, dom="lftip",
                           columnDefs=list(list(className="dt-center", targets="_all"))),
              rownames=FALSE, class="table table-hover table-sm"
    ) %>%
      formatStyle(col_sr,
                  background=styleColorBar(c(0,100),"#70AD47"),
                  backgroundSize="100% 80%", backgroundRepeat="no-repeat",
                  backgroundPosition="center")
  })
  
  # ═══════════════════════════════════════════════════════════
  # ONGLET 3 – TRAITEMENTS
  # ═══════════════════════════════════════════════════════════
  output$tab_treat_ui <- renderUI({
    tagList(
      fluidRow(
        column(4, div(class="card",
                      div(class="section-title", tr()$plot_treat_surv),
                      plotlyOutput("plot_treat_surv", height="300px"))),
        column(4, div(class="card",
                      div(class="section-title", tr()$plot_mutations),
                      plotlyOutput("plot_mutations", height="300px"))),
        column(4, div(class="card",
                      div(class="section-title", tr()$plot_cancer_type),
                      plotlyOutput("plot_cancer_type", height="300px")))
      ),
      fluidRow(
        column(6, div(class="card",
                      div(class="section-title", tr()$plot_heatmap),
                      plotlyOutput("plot_treat_heatmap", height="280px"))),
        column(6, div(class="card",
                      div(class="section-title", tr()$plot_diag),
                      plotlyOutput("plot_diag_method", height="280px")))
      )
    )
  })
  
  output$plot_treat_surv <- renderPlotly({
    d <- df_raw %>%
      group_by(Treatment) %>%
      summarise(n=n(), rate=round(mean(Survived=="Yes")*100,1), .groups="drop") %>%
      arrange(rate)
    plot_ly(d, y=~reorder(Treatment,rate), x=~rate, type="bar", orientation="h",
            marker=list(color="#4A9EDB"),
            text=~paste0(rate,"%"), textposition="outside", customdata=~n,
            hovertemplate=paste0("<b>%{y}</b><br>",tr()$surv_hover,
                                 ": %{x}%<br>n=%{customdata}<extra></extra>")) %>%
      layout(paper_bgcolor="rgba(0,0,0,0)", plot_bgcolor="rgba(0,0,0,0)",
             xaxis=list(title=tr()$surv_rate_pct, range=c(0,115),
                        gridcolor=grid_color(), tickfont=list(color=txt_color())),
             yaxis=list(title="", tickfont=list(color=txt_color())),
             font=list(family="Inter", color=txt_color()))
  })
  
  output$plot_mutations <- renderPlotly({
    d <- df_raw %>%
      group_by(Genetic_Mutation) %>%
      summarise(n=n(), .groups="drop") %>% arrange(desc(n))
    plot_ly(d, labels=~Genetic_Mutation, values=~n, type="pie", hole=0.45,
            textinfo="label+percent",
            hovertemplate="<b>%{label}</b><br>n=%{value}<br>%{percent}<extra></extra>",
            marker=list(colors=c("#1F4E79","#4A9EDB","#70AD47","#ED7D31","#C00000",
                                 "#7030A0","#00B0F0","#FF0066","#92D050","#FFC000"))) %>%
      layout(showlegend=FALSE, paper_bgcolor="rgba(0,0,0,0)",
             font=list(family="Inter", size=11, color=txt_color()))
  })
  
  output$plot_cancer_type <- renderPlotly({
    d <- df_raw %>%
      mutate(Type_detail=case_when(
        Cancer_Type=="SCLC"             ~ tr()$type_sclc,
        NSCLC_Subtype=="Adenocarcinoma" ~ tr()$type_adeno,
        NSCLC_Subtype=="Squamous Cell"  ~ tr()$type_squam,
        NSCLC_Subtype=="Large Cell"     ~ tr()$type_large,
        TRUE                            ~ tr()$type_other
      )) %>%
      group_by(Type_detail) %>% summarise(n=n(), .groups="drop")
    plot_ly(d, labels=~Type_detail, values=~n, type="pie", hole=0.4,
            textinfo="label+percent",
            marker=list(colors=c("#1F4E79","#4A9EDB","#70AD47","#ED7D31","#C00000"))) %>%
      layout(showlegend=FALSE, paper_bgcolor="rgba(0,0,0,0)",
             font=list(family="Inter", size=11, color=txt_color()))
  })
  
  output$plot_treat_heatmap <- renderPlotly({
    d <- df_raw %>%
      group_by(Treatment, Cancer_Stage) %>%
      summarise(avg=round(mean(Survival_Months),1), .groups="drop")
    treats <- sort(unique(d$Treatment))
    stages <- c("Stage I","Stage II","Stage III","Stage IV")
    mat <- matrix(NA, nrow=length(treats), ncol=length(stages),
                  dimnames=list(treats, stages))
    for (i in seq_len(nrow(d))) mat[d$Treatment[i], d$Cancer_Stage[i]] <- d$avg[i]
    plot_ly(z=mat, x=stages, y=treats, type="heatmap",
            colorscale=if(dark_mode()) "Viridis" else "Blues",
            text=mat,
            texttemplate=paste0("%{text} ", tr()$surv_months_lbl),
            hovertemplate=paste0("<b>%{y}</b><br>%{x}<br>",tr()$surv_hover,
                                 ": %{z} ",tr()$surv_months_lbl,"<extra></extra>")) %>%
      layout(paper_bgcolor="rgba(0,0,0,0)", plot_bgcolor="rgba(0,0,0,0)",
             xaxis=list(title="", tickfont=list(color=txt_color())),
             yaxis=list(title="", tickfont=list(color=txt_color())),
             font=list(family="Inter", size=11, color=txt_color()))
  })
  
  output$plot_diag_method <- renderPlotly({
    d <- df_raw %>%
      group_by(Diagnosis_Method) %>%
      summarise(n=n(), rate=round(mean(Survived=="Yes")*100,1), .groups="drop") %>%
      arrange(desc(n))
    plot_ly(d, x=~Diagnosis_Method, y=~n, type="bar",
            marker=list(color="#7030A0"),
            text=~paste0(rate,"% ",tr()$surv_hover), textposition="outside",
            hovertemplate="<b>%{x}</b><br>n=%{y}<br>%{text}<extra></extra>") %>%
      layout(paper_bgcolor="rgba(0,0,0,0)", plot_bgcolor="rgba(0,0,0,0)",
             xaxis=list(title="", tickangle=-20, tickfont=list(color=txt_color())),
             yaxis=list(title=tr()$nb_patients, gridcolor=grid_color(), tickfont=list(color=txt_color())),
             font=list(family="Inter", size=11, color=txt_color()))
  })
  
  # ═══════════════════════════════════════════════════════════
  # ONGLET 4 – DONNÉES
  # ═══════════════════════════════════════════════════════════
  output$tab_data_ui <- renderUI({
    div(class="card",
        div(class="section-title", tr()$data_title),
        div(style="margin-bottom:10px;",
            downloadButton("btn_download", tr()$download_btn, class="btn btn-primary btn-sm")),
        DTOutput("tbl_raw")
    )
  })
  
  output$tbl_raw <- renderDT({
    datatable(df_filtered(),
              options=list(pageLength=15, scrollX=TRUE, dom="lftip"),
              rownames=FALSE, class="table table-hover table-sm")
  })
  
  output$btn_download <- downloadHandler(
    filename=function() paste0("lung_cancer_", Sys.Date(), ".csv"),
    content =function(file) write.csv(df_filtered(), file, row.names=FALSE)
  )
}