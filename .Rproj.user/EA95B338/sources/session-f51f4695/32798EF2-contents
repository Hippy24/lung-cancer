# global.R est chargé automatiquement avant ui.R et server.R

ui <- fluidPage(
  theme = bs_theme(
    bg = "#F8F9FA", fg = "#1C2B4A",
    primary = "#1F4E79", secondary = "#2E75B6",
    base_font = font_google("Inter"),
    heading_font = font_google("Inter")
  ),
  
  # CSS injecté dynamiquement par le server selon le thème
  uiOutput("dynamic_css"),
  
  # ── Navbar ─────────────────────────────────────────────────
  tags$nav(class = "navbar navbar-expand-lg mb-3",
           tags$div(class = "container-fluid",
                    tags$div(
                      tags$span(class = "navbar-brand fw-bold d-block",
                                style = "font-size:17px; line-height:1.2;",
                                "\U0001fac1 Analyse Mondiale du Cancer du Poumon | Global Lung Cancer Analysis"
                      ),
                      tags$span(
                        style = "font-size:11px; color:rgba(255,255,255,.75); padding-left:4px; letter-spacing:.03em;",
                        "2015\u20132025 \u00b7 60 pays / countries \u00b7 1 500 patients \u00b7 6 r\u00e9gions OMS / WHO regions"
                      )
                    ),
                    tags$div(class = "d-flex align-items-center gap-3 ms-auto",
                             uiOutput("nav_tabs_ui"),
                             actionButton("btn_lang", "EN",  class = "btn btn-sm lang-toggle"),
                             actionButton("btn_dark", "\u263e Mode sombre", class = "btn btn-sm dark-toggle")
                    )
           )
  ),
  
  # ── Contenu ────────────────────────────────────────────────
  tags$div(style = "padding:0 16px 16px;",
           uiOutput("main_content")
  )
)