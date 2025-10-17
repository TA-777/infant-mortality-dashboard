# ----------------------- Packages -------------------------------------------
library(shiny)
library(readxl)
library(dplyr)
library(tidyr)
library(stringr)
library(purrr)
library(janitor)
library(ggplot2)
library(plotly)
library(DT)
library(bslib)
library(shinycssloaders)
library(scales)
library(tibble)
library(shinyWidgets)

# ----------------------- Helpers --------------------------------------------
enhanced_css <- "
/* Professional Dashboard Styling - Enhanced Version */

/* === LANDING PAGE ENHANCEMENTS === */
#splash {
  position: fixed;
  inset: 0;
  background: 
    linear-gradient(
      135deg,
      rgba(15, 23, 42, 0.4) 0%,
      rgba(30, 41, 59, 0.6) 25%,
      rgba(15, 23, 42, 0.8) 50%,
      rgba(6, 78, 59, 0.4) 75%,
      rgba(15, 23, 42, 0.6) 100%
    ),
    url('hero.png') center center / cover no-repeat fixed;
  z-index: 10000;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  overflow: hidden;
}

/* Animated background particles */
#splash::before {
  content: '';
  position: absolute;
  width: 100%;
  height: 100%;
  background-image: 
    radial-gradient(circle at 20% 80%, rgba(120, 213, 250, 0.08) 0%, transparent 50%),
    radial-gradient(circle at 80% 20%, rgba(77, 163, 255, 0.06) 0%, transparent 50%),
    radial-gradient(circle at 40% 40%, rgba(147, 197, 253, 0.04) 0%, transparent 50%);
  animation: floatParticles 20s ease-in-out infinite alternate;
}

@keyframes floatParticles {
  0% { transform: translateY(0px) rotate(0deg); opacity: 0.3; }
  100% { transform: translateY(-20px) rotate(5deg); opacity: 0.8; }
}

.splash-inner {
  text-align: center;
  color: white;
  max-width: 700px;
  padding: 60px 40px;
  background: 
    linear-gradient(135deg, 
      rgba(255, 255, 255, 0.1) 0%,
      rgba(255, 255, 255, 0.05) 100%);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-radius: 24px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  box-shadow: 
    0 32px 80px rgba(0, 0, 0, 0.3),
    0 8px 32px rgba(0, 0, 0, 0.2),
    inset 0 1px 0 rgba(255, 255, 255, 0.1);
  position: relative;
  transform: translateY(-20px);
  animation: slideInUp 1s ease-out;
}

@keyframes slideInUp {
  from { 
    opacity: 0; 
    transform: translateY(60px); 
  }
  to { 
    opacity: 1; 
    transform: translateY(-20px); 
  }
}

.splash-inner::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 2px;
  background: linear-gradient(90deg, transparent, #60a5fa, #4da3ff, #3b82f6, transparent);
  border-radius: 24px 24px 0 0;
}

.splash-inner h1 {
  font-size: clamp(2.5rem, 5vw, 4rem);
  font-weight: 800;
  margin-bottom: 24px;
  background: linear-gradient(135deg, #ffffff 0%, #e0f2fe 30%, #81d4fa 60%, #4fc3f7 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  line-height: 1.1;
  text-shadow: 0 8px 32px rgba(77, 163, 255, 0.3);
  animation: titleGlow 3s ease-in-out infinite alternate;
}

@keyframes titleGlow {
  0% { filter: brightness(1) drop-shadow(0 0 20px rgba(77, 163, 255, 0.3)); }
  100% { filter: brightness(1.1) drop-shadow(0 0 30px rgba(77, 163, 255, 0.5)); }
}

.splash-inner p {
  font-size: 1.2rem;
  line-height: 1.7;
  margin-bottom: 40px;
  color: rgba(255, 255, 255, 0.9);
  font-weight: 400;
  text-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
}

.splash-stats {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
  gap: 20px;
  margin: 40px 0;
  padding: 20px 0;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.splash-stat {
  text-align: center;
  animation: fadeInScale 1s ease-out;
  animation-delay: calc(var(--delay, 0) * 0.2s);
}

.splash-stat-number {
  font-size: 1.8rem;
  font-weight: 700;
  color: #60a5fa;
  display: block;
  margin-bottom: 4px;
}

.splash-stat-label {
  font-size: 0.9rem;
  color: rgba(255, 255, 255, 0.8);
  font-weight: 500;
}

@keyframes fadeInScale {
  from { 
    opacity: 0; 
    transform: scale(0.8); 
  }
  to { 
    opacity: 1; 
    transform: scale(1); 
  }
}

#enterBtn {
  background: linear-gradient(135deg, #4da3ff 0%, #3b82f6 50%, #2563eb 100%);
  border: none;
  padding: 16px 48px;
  font-size: 1.1rem;
  font-weight: 600;
  color: white;
  border-radius: 50px;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  box-shadow: 
    0 8px 32px rgba(77, 163, 255, 0.4),
    0 4px 16px rgba(0, 0, 0, 0.2),
    inset 0 1px 0 rgba(255, 255, 255, 0.2);
  position: relative;
  overflow: hidden;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  animation: buttonPulse 2s ease-in-out infinite;
}

@keyframes buttonPulse {
  0%, 100% { box-shadow: 0 8px 32px rgba(77, 163, 255, 0.4), 0 4px 16px rgba(0, 0, 0, 0.2); }
  50% { box-shadow: 0 12px 40px rgba(77, 163, 255, 0.6), 0 6px 20px rgba(0, 0, 0, 0.3); }
}

#enterBtn::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
  transition: left 0.5s;
}

#enterBtn:hover {
  transform: translateY(-4px) scale(1.05);
  box-shadow: 
    0 16px 48px rgba(77, 163, 255, 0.6),
    0 8px 24px rgba(0, 0, 0, 0.3),
    inset 0 1px 0 rgba(255, 255, 255, 0.3);
}

#enterBtn:hover::before {
  left: 100%;
}

#enterBtn:active {
  transform: translateY(-2px) scale(1.02);
}

/* === ENHANCED MAIN LAYOUT === */

/* Professional gradient background with subtle animation */
#page-bg {
  position: fixed; 
  inset: 0;
  background: 
    linear-gradient(135deg, 
      rgba(77, 163, 255, 0.03) 0%, 
      rgba(96, 165, 250, 0.05) 25%,
      rgba(147, 197, 253, 0.03) 50%,
      rgba(59, 130, 246, 0.04) 70%,
      rgba(77, 163, 255, 0.03) 100%
    ),
    url('infant.jpg') center center / cover no-repeat fixed;
  z-index: -2;
  filter: brightness(1.05) contrast(0.98);
  animation: backgroundShift 30s ease-in-out infinite alternate;
}

@keyframes backgroundShift {
  0% { filter: brightness(1.05) contrast(0.98) hue-rotate(0deg); }
  100% { filter: brightness(1.08) contrast(0.95) hue-rotate(5deg); }
}

/* Enhanced hero with micro-animations */
#hero {
  position: relative;
  min-height: 180px;
  border-radius: 20px;
  margin-bottom: 32px;
  background: 
    linear-gradient(135deg, 
      rgba(255,255,255,0.95) 0%, 
      rgba(248,250,252,0.98) 50%,
      rgba(241,245,249,0.95) 100%
    );
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  display: flex;
  align-items: center;
  padding: 40px;
  border: 1px solid rgba(255,255,255,0.3);
  box-shadow: 
    0 24px 80px rgba(0,0,0,0.08),
    0 8px 32px rgba(0,0,0,0.04),
    inset 0 1px 0 rgba(255,255,255,0.9);
  overflow: hidden;
}

#hero::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(90deg, #4da3ff, #60a5fa, #3b82f6, #4da3ff);
  background-size: 300% 100%;
  animation: heroGradient 8s ease-in-out infinite;
}

@keyframes heroGradient {
  0%, 100% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
}

body.dark #hero {
  background: 
    linear-gradient(135deg, 
      rgba(15,23,42,0.95) 0%, 
      rgba(30,41,59,0.98) 50%,
      rgba(15,23,42,0.95) 100%
    );
  border: 1px solid rgba(255,255,255,0.15);
  box-shadow: 
    0 24px 80px rgba(0,0,0,0.4),
    0 8px 32px rgba(0,0,0,0.3),
    inset 0 1px 0 rgba(255,255,255,0.1);
}

#hero .hero-text h1{
  margin: 0 0 16px 0;
  font-weight: 800;
  font-size: clamp(36px, 4.5vw, 64px);
  background: linear-gradient(135deg, #1f2937 0%, #4da3ff 50%, #3b82f6 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  line-height: 1.1;
  animation: titleShimmer 4s ease-in-out infinite;
}

@keyframes titleShimmer {
  0%, 100% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
}

body.dark #hero .hero-text h1{
  background: linear-gradient(135deg, #f9fafb 0%, #60a5fa 50%, #3b82f6 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

#hero .hero-sub{
  font-size: 20px;
  color: #6b7280;
  font-weight: 500;
  opacity: 0.95;
  display: flex;
  align-items: center;
  gap: 12px;
}

#hero .hero-sub::before {
  content: '📊';
  font-size: 24px;
  animation: float 3s ease-in-out infinite;
}

@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-4px); }
}

/* Enhanced tabs with better animations */
.nav-tabs {
  border-bottom: 3px solid rgba(0, 0, 0, 0.1) !important;
  background: transparent !important;
  margin-bottom: 32px;
}

body.dark .nav-tabs {
  border-bottom: 3px solid rgba(255, 255, 255, 0.2) !important;
}

.nav-tabs .nav-link {
  background-color: rgba(255, 255, 255, 0.8) !important;
  backdrop-filter: blur(8px);
  border: 1px solid rgba(0, 0, 0, 0.08) !important;
  border-radius: 12px 12px 0 0 !important;
  color: #6c757d !important;
  font-weight: 600 !important;
  font-size: 16px !important;
  padding: 16px 32px !important;
  margin-right: 6px !important;
  margin-bottom: -3px !important;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94) !important;
  position: relative;
  overflow: hidden;
}

.nav-tabs .nav-link::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(77, 163, 255, 0.1), transparent);
  transition: left 0.5s;
}

.nav-tabs .nav-link:hover::before {
  left: 100%;
}

.nav-tabs .nav-link:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 32px rgba(77, 163, 255, 0.15);
}

.nav-tabs .nav-link.active {
  background-color: rgba(255, 255, 255, 0.98) !important;
  border-color: #4da3ff !important;
  border-bottom-color: transparent !important;
  color: #4da3ff !important;
  font-weight: 700 !important;
  transform: translateY(-6px) !important;
  box-shadow: 0 12px 40px rgba(77, 163, 255, 0.2) !important;
}

/* Enhanced sidebar */
.bslib-sidebar {
  background-color: rgba(255, 255, 255, 0.98) !important;
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  border-right: 1px solid rgba(0, 0, 0, 0.08) !important;
  border-radius: 16px 0 0 16px;
  box-shadow: 4px 0 32px rgba(0, 0, 0, 0.08) !important;
}

body.dark .bslib-sidebar {
  background-color: rgba(15, 23, 42, 0.98) !important;
  border-right: 1px solid rgba(255, 255, 255, 0.1) !important;
  box-shadow: 4px 0 32px rgba(0, 0, 0, 0.4) !important;
}

/* Enhanced KPI cards with animations */
.kpi-card {
  background: linear-gradient(135deg, 
    rgba(255,255,255,0.98) 0%, 
    rgba(248,250,252,0.98) 100%) !important;
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid rgba(0,0,0,0.06);
  border-radius: 20px;
  padding: 32px;
  box-shadow: 
    0 12px 40px rgba(0,0,0,.08),
    0 4px 16px rgba(0,0,0,.04);
  position: relative;
  overflow: hidden;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.kpi-card:hover {
  transform: translateY(-4px) scale(1.02);
  box-shadow: 
    0 20px 60px rgba(0,0,0,.12),
    0 8px 24px rgba(0,0,0,.06);
}

.kpi-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 6px;
  background: linear-gradient(90deg, #4da3ff, #60a5fa, #3b82f6);
  background-size: 300% 100%;
  animation: cardGradient 6s ease-in-out infinite;
}

@keyframes cardGradient {
  0%, 100% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
}

/* Survival Calculator KPI Styling */
.kpi-card .big {
  font-size: 4rem;
  font-weight: 800;
  color: #4da3ff;
  background: linear-gradient(135deg, #4da3ff 0%, #3b82f6 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  line-height: 1;
  margin-bottom: 16px;
  display: block;
  text-align: center;
  animation: valueGlow 3s ease-in-out infinite alternate;
}

@keyframes valueGlow {
  0% { filter: brightness(1) drop-shadow(0 0 10px rgba(77, 163, 255, 0.3)); }
  100% { filter: brightness(1.1) drop-shadow(0 0 20px rgba(77, 163, 255, 0.5)); }
}

.kpi-card .sub {
  font-size: 1.1rem;
  color: #6b7280;
  font-weight: 500;
  text-align: center;
  line-height: 1.4;
  padding: 0 10px;
}

body.dark .kpi-card .sub {
  color: #d1d5db;
}

body.dark .kpi-card .big {
  background: linear-gradient(135deg, #60a5fa 0%, #4da3ff 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

/* Enhanced plot surfaces */
.plot-surface {
  background: 
    linear-gradient(0deg, rgba(0,0,0,.02) 1px, transparent 1px),
    linear-gradient(90deg, rgba(0,0,0,.02) 1px, transparent 1px),
    rgba(255,255,255,0.95);
  background-size: 24px 24px;
  border-radius: 20px;
  box-shadow: 
    0 16px 50px rgba(0,0,0,.08),
    0 6px 20px rgba(0,0,0,.04),
    inset 0 1px 0 rgba(255,255,255,0.9);
  padding: 32px;
  border: 1px solid rgba(0,0,0,0.06);
  position: relative;
  overflow: hidden;
  transition: all 0.3s ease;
}

.plot-surface:hover {
  box-shadow: 
    0 20px 60px rgba(0,0,0,.12),
    0 8px 24px rgba(0,0,0,.06),
    inset 0 1px 0 rgba(255,255,255,0.9);
}

/* Responsive enhancements */
@media (max-width: 768px) {
  .splash-inner {
    padding: 40px 24px;
    margin: 20px;
  }
  
  .splash-inner h1 {
    font-size: 2.5rem;
  }
  
  #hero {
    padding: 24px;
    min-height: 140px;
  }
  
  .nav-tabs .nav-link {
    padding: 12px 20px !important;
    font-size: 14px !important;
  }
}

/* Custom scrollbar enhancements */
::-webkit-scrollbar {
  width: 10px;
  height: 10px;
}

::-webkit-scrollbar-track {
  background: rgba(0, 0, 0, 0.03);
  border-radius: 6px;
}

::-webkit-scrollbar-thumb {
  background: linear-gradient(135deg, rgba(77, 163, 255, 0.6), rgba(59, 130, 246, 0.8));
  border-radius: 6px;
  border: 2px solid rgba(255, 255, 255, 0.3);
}

::-webkit-scrollbar-thumb:hover {
  background: linear-gradient(135deg, rgba(77, 163, 255, 0.8), rgba(59, 130, 246, 1));
}

/* === ENHANCED DROPDOWN VISIBILITY === */
.selectize-dropdown {
  background-color: rgba(255, 255, 255, 0.95) !important;
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
  border: 1px solid rgba(0, 0, 0, 0.2) !important;
  border-radius: 12px !important;
  box-shadow: 
    0 12px 40px rgba(0, 0, 0, 0.15) !important,
    0 4px 16px rgba(0, 0, 0, 0.08) !important;
  z-index: 9999 !important;
  margin-top: 4px;
}

body.dark .selectize-dropdown {
  background-color: rgba(15, 23, 42, 0.92) !important;
  border: 1px solid rgba(255, 255, 255, 0.3) !important;
  color: #e5e7eb !important;
  box-shadow: 
    0 12px 40px rgba(0, 0, 0, 0.4) !important,
    0 4px 16px rgba(0, 0, 0, 0.2) !important;
}

.selectize-dropdown-content {
  max-height: 240px !important;
  overflow-y: auto !important;
}

.selectize-dropdown .option {
  padding: 12px 16px !important;
  color: #1f2937 !important;
  background: transparent !important;
  font-weight: 500 !important;
  transition: all 0.2s ease !important;
}

body.dark .selectize-dropdown .option {
  color: #e5e7eb !important;
}

.selectize-dropdown .option:hover,
.selectize-dropdown .option.active {
  background-color: rgba(77, 163, 255, 0.15) !important;
  color: #1f2937 !important;
  transform: translateX(4px) !important;
}

body.dark .selectize-dropdown .option:hover,
body.dark .selectize-dropdown .option.active {
  background-color: rgba(96, 165, 250, 0.2) !important;
  color: #f9fafb !important;
}

/* Enhanced form inputs */
.form-control, .selectize-input {
  background-color: rgba(255, 255, 255, 0.95) !important;
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
  border: 1px solid rgba(0, 0, 0, 0.12) !important;
  border-radius: 12px !important;
  padding: 12px 16px !important;
  font-size: 15px !important;
  font-weight: 500 !important;
  transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94) !important;
}

body.dark .form-control,
body.dark .selectize-input {
  background-color: rgba(15, 23, 42, 0.92) !important;
  border: 1px solid rgba(255, 255, 255, 0.2) !important;
  color: #e5e7eb !important;
}

.form-control:focus, .selectize-input.focus {
  border-color: #4da3ff !important;
  box-shadow: 
    0 0 0 3px rgba(77, 163, 255, 0.15) !important,
    0 4px 16px rgba(77, 163, 255, 0.1) !important;
  outline: none !important;
  transform: translateY(-2px) !important;
}
"

`%||%` <- function(x, y) if (is.null(x)) y else x
pn <- function(x){
  y <- gsub("\u00A0"," ",as.character(x),fixed=TRUE)
  y <- gsub("[^0-9.-]","",y); y <- trimws(y)
  y[y %in% c("",".","-","NA","na")] <- NA
  suppressWarnings(as.numeric(y))
}
safe_bind_rows <- function(lst){
  if(!length(lst)) return(tibble())
  lst <- lst[!vapply(lst, is.null, logical(1))]
  if(!length(lst)) return(tibble())
  suppressWarnings(dplyr::bind_rows(lst))
}
pick_col <- function(df, ...){
  pats <- c(...); nm <- names(df)
  for(p in pats){
    i <- grep(p, nm, ignore.case=TRUE, perl=TRUE)
    if(length(i)) return(nm[i[1]])
  }
  NA_character_
}
is_bad <- function(x) is.na(x) | !nzchar(x)

# -------- Robust parsing + parametric fitting helpers ------------------------
to_num <- function(x){
  if (is.numeric(x)) return(x)
  x <- gsub("\u00A0", " ", as.character(x), fixed = TRUE)
  x <- gsub("[^0-9.-]", "", x); x[x %in% c("",".","-","NA","na")] <- NA
  suppressWarnings(as.numeric(x))
}
find_col <- function(nms, patterns){
  for (p in patterns){
    ix <- grep(p, nms, ignore.case = TRUE, perl = TRUE)
    if (length(ix) > 0) return(nms[ix[1]])
  }
  stop("Column not found for patterns: ", paste(patterns, collapse=" | "))
}
prep_intervals_from_daily <- function(path_daily, year){
  df <- readxl::read_excel(path_daily, sheet = "1")
  names(df) <- gsub("\\s+", " ", trimws(names(df)))
  col_year   <- find_col(names(df), c("^Year$"))
  col_births <- find_col(names(df), c("^Live\\s*births$"))
  col_u1d    <- find_col(names(df), c("^Early\\s*neonatal\\s*Under\\s*1\\s*day$"))
  col_1d_1w  <- find_col(names(df), c("^Early\\s*neonatal\\s*1\\s*day\\s*and\\s*under\\s*1\\s*week$"))
  col_1w_4w  <- find_col(names(df), c("^Late\\s*neonatal\\s*1\\s*week\\s*and\\s*under\\s*4\\s*weeks$"))
  col_4w_3m  <- find_col(names(df), c("^Postneonatal\\s*4\\s*weeks\\s*and\\s*under\\s*3\\s*months$"))
  col_3m_6m  <- find_col(names(df), c("^Postneonatal\\s*3\\s*months\\s*and\\s*under\\s*6\\s*months$"))
  col_6m_1y  <- find_col(names(df), c("^Postneonatal\\s*6\\s*months\\s*and\\s*under\\s*1\\s*year$"))
  
  row <- df %>%
    mutate(Year = to_num(.data[[col_year]])) %>%
    filter(Year == year)
  if (nrow(row) < 1) stop("Year ", year, " not found in Daily mortality.xlsx.")
  
  B <- to_num(row[[col_births]])[1]
  deaths <- c(
    `Under 1 day`   = to_num(row[[col_u1d]])[1],
    `1<7 days`     = to_num(row[[col_1d_1w]])[1],
    `7<28 days`    = to_num(row[[col_1w_4w]])[1],
    `28<89 days`   = to_num(row[[col_4w_3m]])[1],
    `89<181 days`  = to_num(row[[col_3m_6m]])[1],
    `181<365 days` = to_num(row[[col_6m_1y]])[1]
  )
  
  iv <- tibble(
    interval    = names(deaths),
    t0          = c(0, 1, 7, 28, 89, 181),
    t1          = c(1, 7, 28, 89, 181, 365),
    n_days      = t1 - t0,
    Dx          = as.numeric(deaths)
  ) %>%
    mutate(
      Nx = B - lag(cumsum(Dx), default = 0),
      B  = B
    )
  attr(iv, "infant_deaths_total") <- sum(deaths, na.rm = TRUE)
  iv
}
qx_from_params <- function(model, par, t0, t1){
  eps <- 1e-12
  if (model == "exponential"){
    lambda <- exp(par[1]); H <- pmax(lambda*(t1 - t0), 0)
  } else if (model == "weibull"){
    lambda <- exp(par[1]); k <- exp(par[2]); H <- pmax((lambda*t1)^k - (lambda*t0)^k, 0)
  } else if (model == "gompertz"){
    alpha <- exp(par[1]); beta <- par[2]
    H <- if (abs(beta) < 1e-8) alpha*(t1 - t0) else (alpha/beta)*(exp(beta*t1) - exp(beta*t0))
    H <- pmax(H, 0)
  } else stop("Unknown model")
  q <- 1 - exp(-H)
  pmin(pmax(q, eps), 1 - eps)
}
nll_binom <- function(par, model, Nx, Dx, t0, t1){
  q <- qx_from_params(model, par, t0, t1)
  -sum(Dx*log(q) + (Nx - Dx)*log(1 - q))
}
fit_parametric_grouped <- function(ivls, model){
  q_total <- sum(ivls$Dx)/ivls$B[1]
  lambda0 <- -log(1 - q_total)/365
  init <- switch(model,
                 exponential = c(log(lambda0)),
                 weibull     = c(log(lambda0), 0),
                 gompertz    = c(log(lambda0), 0))
  k_par <- length(init)
  opt <- optim(par = init, fn = nll_binom, method = "BFGS", hessian = TRUE,
               model = model, Nx = ivls$Nx, Dx = ivls$Dx, t0 = ivls$t0, t1 = ivls$t1)
  logLik <- -opt$value; AIC <- 2*k_par - 2*logLik
  qhat <- qx_from_params(model, opt$par, ivls$t0, ivls$t1)
  mu   <- ivls$Nx * qhat
  pearson <- sum((ivls$Dx - mu)^2 / (ivls$Nx * qhat * (1 - qhat)))
  dev <- 2*sum({
    D  <- ivls$Dx; N <- ivls$Nx; M <- mu
    D1 <- ifelse(D == 0, 0, D*log(D/pmax(M,1e-12)))
    D2 <- ifelse(N==D, 0, (N-D)*log((N-D)/pmax(N - M,1e-12)))
    D1 + D2
  })
  S_emp <- c(1, cumprod(1 - ivls$Dx/ivls$Nx))
  S_mod <- c(1, cumprod(1 - qhat))
  list(model=model, par=opt$par, logLik=logLik, AIC=AIC,
       pearson_chisq=pearson, deviance=dev,
       S_times=c(ivls$t0[1], ivls$t1), S_emp=S_emp, S_mod=S_mod,
       convergence=opt$convergence)
}

# ----------------------- Themes (light/dark) ---------------------------------
theme_light <- bs_theme(
  version = 5,
  primary = "lightblue",
  secondary = "#9AA0A6",
  bg = "#F6F8FB",
  fg = "#1F2937",
  base_font = font_google("Inter"),
  heading_font = font_google("Inter")
)
theme_dark <- bs_theme(
  version = 5,
  primary = "lightblue",
  secondary = "#A3A3A3",
  bg = "#0F172A",
  fg = "#E5E7EB",
  base_font = font_google("Inter"),
  heading_font = font_google("Inter")
)

# ----------------------- Canonical labels ------------------------------------
canon_bw <- function(x){
  y <- tolower(gsub("\\s+","_",as.character(x)))
  dplyr::case_when(
    grepl("^(all|all_live_births|all_bw|all_birth)",y) ~ "All birthweight",
    grepl("under[_\\s]?1000|<[_\\s]?1000|^lt[_\\s]?1000",y) ~ "<1000g",
    grepl("1000[_\\s-]?1499",y) ~ "1000-1499g",
    grepl("1500[_\\s-]?1999",y) ~ "1500-1999g", 
    grepl("2000[_\\s-]?2499",y) ~ "2000-2499g",
    grepl("2500[_\\s-]?2999",y) ~ "2500-2999g",
    grepl("3000[_\\s-]?3499",y) ~ "3000-3499g",
    grepl("3500[_\\s-]?3999",y) ~ "3500-3999g",
    grepl("4000.*(plus|over)|>=?[_\\s]?4000|^ge[_\\s]?4000",y) ~ ">4000g",
    grepl("not[_\\s]?stated|unknown|missing",y) ~ "Not stated",
    TRUE ~ as.character(x)  # Ensure character output
  )
}
canon_ga_levels <- c(
  "under 24","24-27","28-31","32-36","37-41","42 and over",
  "low gestational age inconsistent with birthweight",
  "gestational age not stated"
)
canon_ga <- function(x){
  f <- factor(as.character(x), levels = canon_ga_levels)
  if(all(is.na(f))) as.character(x) else f
}
clean_mage <- function(x){
  y <- tolower(gsub("\\s+","_",as.character(x))); y <- gsub("^mothers?_age_","",y)
  dplyr::recode(
    y,
    "all_live_births"="All mothers' ages","all"="All mothers' ages",
    "under_20"="<20","20_24"="20-24","25_29"="25-29","30_34"="30-34",
    "35_39"="35-39","40_and_over"=">40","not_stated"="Not stated",
    .default=x
  )
}



# ----------------------- Readers --------------------------------------------
guess_header_row_sheet1 <- function(path, look_max=80){
  raw <- suppressWarnings(readxl::read_excel(path, sheet=1, col_names=FALSE, n_max=look_max))
  if(is.null(raw) || nrow(raw)==0) return(0L)
  has_hdr <- apply(raw,1,function(r) any(grepl("(month.*birth|neonatal.*rate|infant.*rate)", tolower(paste(r,collapse=" ")), perl=TRUE)))
  idx <- which(has_hdr); if(length(idx)) idx[1]-1L else 0L
}

read_months_clean <- function(path, year_label){
  skip_rows <- guess_header_row_sheet1(path)
  dat <- suppressWarnings(readxl::read_excel(path, sheet=1, skip=skip_rows)) |> janitor::clean_names()
  col_mo <- pick_col(dat, "^month_?of_?birth$")
  c_birth <- pick_col(dat, "^all_?live_?births$")
  c_neo_d <- pick_col(dat, "^all_?neonatal_?deaths$")
  c_post_d<- pick_col(dat, "^all_?postneonatal_?deaths$")
  c_inf_d <- pick_col(dat, "^all_?infant_?deaths$")
  c_imr   <- pick_col(dat, "^all_?infant_?mortality_?rate$")
  c_nmr   <- pick_col(dat, "^all_?neonatal_?mortality_?rate$")
  c_pnmr  <- pick_col(dat, "^all_?postneonatal_?mortality_?rate$")
  c_sbr   <- pick_col(dat, "^all_?stillbirth.*rate$")
  
  need <- c(col_mo,c_birth,c_neo_d,c_post_d,c_inf_d)
  if(any(is_bad(need))) return(tibble())
  
  out <- dat |>
    transmute(
      Month = factor(.data[[col_mo]], levels=c(month.name,"All")),
      births_all = pn(.data[[c_birth]]),
      deaths_neonatal = pn(.data[[c_neo_d]]),
      deaths_postneo  = pn(.data[[c_post_d]]),
      deaths_infant   = pn(.data[[c_inf_d]]),
      rate_infant     = if(!is_bad(c_imr))  pn(.data[[c_imr]])  else NA_real_,
      rate_neonatal   = if(!is_bad(c_nmr))  pn(.data[[c_nmr]])  else NA_real_,
      rate_postneo    = if(!is_bad(c_pnmr)) pn(.data[[c_pnmr]]) else NA_real_,
      rate_stillbirth = if(!is_bad(c_sbr))  pn(.data[[c_sbr]])  else NA_real_,
      Year = year_label
    ) |>
    filter(!is.na(Month)) |>
    mutate(
      rate_infant   = ifelse(is.na(rate_infant)   & births_all>0 & is.finite(deaths_infant),   1000*deaths_infant/births_all, rate_infant),
      rate_neonatal = ifelse(is.na(rate_neonatal) & births_all>0 & is.finite(deaths_neonatal), 1000*deaths_neonatal/births_all, rate_neonatal),
      rate_postneo  = ifelse(is.na(rate_postneo)  & births_all>0 & is.finite(deaths_postneo),  1000*deaths_postneo/births_all, rate_postneo)
    )
  out
}

# ---------- BW x GA (sheet "6") ---------------------------------------------
parse_bw_ga <- function(path, year_label){
  dat <- suppressWarnings(readxl::read_excel(path, sheet = "6")) |> janitor::clean_names()
  if (ncol(dat) < 2) return(tibble())
  ga_col <- names(dat)[1]
  births <- dat |> dplyr::filter(grepl("^live\\s*births", .data[[ga_col]], ignore.case=TRUE)) |> dplyr::rename(ga_label = !!ga_col)
  deaths <- dat |> dplyr::filter(grepl("^infant\\s*deaths", .data[[ga_col]], ignore.case=TRUE)) |> dplyr::rename(ga_label = !!ga_col)
  cols <- names(dat)[-1]
  keep_bw <- grepl("(under[_\\s]?1000|^lt[_\\s]?1000|1000[_\\s-]?1499|1500[_\\s-]?1999|2000[_\\s-]?2499|2500[_\\s-]?2999|3000[_\\s-]?3499|3500[_\\s-]?3999|ge[_\\s]?4000|>=?4000|over[_\\s]?4000|not[_\\s]?stated|all(_birth(weight)?|_live_births)?$)", cols, ignore.case=TRUE)
  bw_cols <- cols[keep_bw]; if (!length(bw_cols)) return(tibble())
  births_long <- births |> dplyr::select(ga_label, dplyr::all_of(bw_cols)) |>
    dplyr::mutate(dplyr::across(-ga_label, pn), ga = sub("^live\\s*births\\s*","",ga_label, ignore.case=TRUE)) |>
    dplyr::select(-ga_label) |> tidyr::pivot_longer(-ga, names_to="bw", values_to="births") |> dplyr::filter(!is.na(births))
  deaths_long <- deaths |> dplyr::select(ga_label, dplyr::all_of(bw_cols)) |>
    dplyr::mutate(dplyr::across(-ga_label, pn), ga = sub("^infant\\s*deaths\\s*","",ga_label, ignore.case=TRUE)) |>
    dplyr::select(-ga_label) |> tidyr::pivot_longer(-ga, names_to="bw", values_to="deaths") |> dplyr::filter(!is.na(deaths))
  births_long |> dplyr::left_join(deaths_long, by=c("ga","bw")) |>
    dplyr::mutate(
      bw = canon_bw(bw), ga = canon_ga(ga),
      births = tidyr::replace_na(births,0), deaths = tidyr::replace_na(deaths,0),
      risk = dplyr::if_else(births>0, deaths/births, NA_real_), Year = year_label
    )
}

# ---------- Mother's age x GA (sheet "7") -----------------------------------
parse_mage_ga <- function(path, year_label){
  dat <- suppressWarnings(readxl::read_excel(path, sheet = "7")) |> janitor::clean_names()
  if (ncol(dat) < 2) return(tibble())
  ga_col <- names(dat)[1]
  births <- dat |> dplyr::filter(grepl("^live\\s*births", .data[[ga_col]], ignore.case=TRUE)) |> dplyr::rename(ga_label = !!ga_col)
  deaths <- dat |> dplyr::filter(grepl("^infant\\s*deaths", .data[[ga_col]], ignore.case=TRUE)) |> dplyr::rename(ga_label = !!ga_col)
  cols <- names(dat)[-1]
  base <- tolower(cols); base <- gsub("^mothers?_age_","",base)
  keep_mage <- grepl("^(all(_live_births)?|under_?20|20_?24|25_?29|30_?34|35_?39|40_?and_?over|not_?stated)$", base)
  mage_cols <- cols[keep_mage]; if (!length(mage_cols)) return(tibble())
  births_long <- births |> dplyr::select(ga_label, dplyr::all_of(mage_cols)) |>
    dplyr::mutate(dplyr::across(-ga_label, pn), ga = sub("^live\\s*births\\s*","",ga_label, ignore.case=TRUE)) |>
    dplyr::select(-ga_label) |> tidyr::pivot_longer(-ga, names_to="mage", values_to="births") |> dplyr::filter(!is.na(births))
  deaths_long <- deaths |> dplyr::select(ga_label, dplyr::all_of(mage_cols)) |>
    dplyr::mutate(dplyr::across(-ga_label, pn), ga = sub("^infant\\s*deaths\\s*","",ga_label, ignore.case=TRUE)) |>
    dplyr::select(-ga_label) |> tidyr::pivot_longer(-ga, names_to="mage", values_to="deaths") |> dplyr::filter(!is.na(deaths))
  births_long |> dplyr::left_join(deaths_long, by=c("ga","mage")) |>
    dplyr::mutate(
      mage = clean_mage(mage), ga = canon_ga(ga),
      births = tidyr::replace_na(births,0), deaths = tidyr::replace_na(deaths,0),
      risk = dplyr::if_else(births>0, deaths/births, NA_real_), Year = year_label
    )
}

# ------------------- Daily mortality ----------------------------------------
read_daily_from_uploaded <- function(path){
  df <- suppressWarnings(readxl::read_excel(path, sheet=1, guess_max=10000))
  if(is.null(df) || nrow(df)==0) return(tibble(Year=integer(), Age=double(), Mortality=double()))
  df <- janitor::clean_names(df)
  if(!"year" %in% names(df)) stop("The uploaded Daily mortality file must contain a 'Year' column.")
  nms <- names(df)
  pick <- function(exact, rx){
    if(exact %in% nms) return(exact)
    hit <- grep(rx, nms, ignore.case=TRUE, perl=TRUE)
    if(length(hit)) nms[hit[1]] else NA_character_
  }
  c_d1   <- pick("early_neonatal_under_1_day_mortality_rate","early.*under_?1_?day.*mortality_rate")
  c_d7   <- pick("early_neonatal_1_day_and_under_1_week_mortality_rate","early.*1_?day.*under_?1_?week.*mortality_rate")
  c_d28  <- pick("late_neonatal_1_week_and_under_4_weeks_mortality_rate","late.*1_?week.*under_?4_?weeks.*mortality_rate")
  c_d91  <- pick("postneonatal_4_weeks_and_under_3_months_mortality_rate","postneonatal.*4_?weeks.*under_?3_?months.*mortality_rate")
  c_d182 <- pick("postneonatal_3_months_and_under_6_months_mortality_rate","postneonatal.*3_?months.*under_?6_?months.*mortality_rate")
  c_d365 <- pick("postneonatal_6_months_and_under_1_year_mortality_rate","postneonatal.*6_?months.*under_?1_?year.*mortality_rate")
  need <- c(c_d1,c_d7,c_d28,c_d91,c_d182,c_d365)
  if(any(is_bad(need))){
    miss <- c("Day1"=c_d1,"Day7"=c_d7,"Day28"=c_d28,"Day91"=c_d91,"Day182"=c_d182,"Day365"=c_d365)
    stop(sprintf("Missing columns in Daily mortality.xlsx: %s", paste(names(miss)[is.na(need)], collapse=", ")))
  }
  long <- df |>
    transmute(
      Year=as.integer(.data[["year"]]),
      `Day 1` = pn(.data[[c_d1]]),
      `Day 7` = pn(.data[[c_d7]])/6,
      `Day 28`= pn(.data[[c_d28]])/21,
      `Day 91` = pn(.data[[c_d91]])/63,
      `Day 182`= pn(.data[[c_d182]])/91,
      `Day 365`= pn(.data[[c_d365]])/182
    ) |>
    pivot_longer(-Year, names_to="age_lab", values_to="Mortality") |>
    mutate(Age=as.integer(dplyr::recode(age_lab,"Day 1"="1","Day 7"="7","Day 28"="28","Day 91"="91","Day 182"="182","Day 365"="365"))) |>
    select(Year,Age,Mortality) |>
    filter(is.finite(Year),is.finite(Age),is.finite(Mortality))
  d17 <- long |> filter(Age==28) |> mutate(Age=17)
  bind_rows(long,d17) |> arrange(Year,Age)
}

# ----------------  Ethnicity parser (sheet "8") -----------------------------
parse_ethnicity_imr <- function(path, year_label){
  dat_raw <- suppressWarnings(readxl::read_excel(path, sheet="8", guess_max=5000))
  if(is.null(dat_raw) || nrow(dat_raw)==0) return(tibble())
  dat <- janitor::clean_names(dat_raw)
  lab_col <- names(dat)[1]
  lab_vals <- tolower(trimws(as.character(dat[[lab_col]])))
  i_births <- which(lab_vals == "all live births")
  i_deaths <- which(lab_vals == "all infant deaths")
  if(!length(i_births) || !length(i_deaths)) return(tibble())
  births_row <- dat[i_births[1], , drop=FALSE] |> select(-all_of(lab_col))
  deaths_row <- dat[i_deaths[1], , drop=FALSE] |> select(-all_of(lab_col))
  keep_cols <- names(births_row)
  keep_cols <- keep_cols[!grepl("^total$", keep_cols, ignore.case=TRUE)]
  keep_cols <- keep_cols[!grepl("mortality_?rate$", keep_cols, ignore.case=TRUE)]
  if(!length(keep_cols)) return(tibble())
  births_vec <- sapply(births_row[keep_cols], pn)
  deaths_vec <- sapply(deaths_row[keep_cols], pn)
  imr <- ifelse(is.finite(births_vec) & births_vec>0, (deaths_vec/births_vec)*1000, NA_real_)
  tibble(
    Ethnicity    = trimws(gsub("\\.+"," ", keep_cols, perl=TRUE)),
    imr_per_1000 = as.numeric(imr),
    Year         = year_label
  ) |>
    filter(!grepl("^total\\b|not\\s*stated|unknown", tolower(Ethnicity))) |>
    filter(is.finite(imr_per_1000))
}

#-----------------------------------------------------------------------------------------------------------------
# ----------------------- UI --------------------------------------------------------------------------------------
ui <- page_fluid(
  theme = theme_light,

  # Load external CSS + page background + hero + dark-class hook
  tags$head(
    # Include the enhanced CSS
    tags$style(HTML(enhanced_css)),
    
    # Add Font Awesome library
    tags$link(
      rel = "stylesheet",
      href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    ),
    
    # Professional page background
    tags$style(HTML("
    /* Professional background */
    :root { --bs-body-bg: transparent !important; }
    .bslib-page, .bslib-page-fill, .bslib-grid, .bslib-navbar-layout,
    .bslib-sidebar-layout, .bslib-sidebar, .bslib-main,
    .container-fluid, .tab-content, .tab-pane, .panel, .card, .well {
      background-color: transparent !important;
    }

    #page-bg{
      position: fixed; 
      inset: 0;
      background: 
        linear-gradient(135deg, 
          rgba(77, 163, 255, 0.02) 0%, 
          rgba(96, 165, 250, 0.03) 25%,
          rgba(147, 197, 253, 0.02) 50%,
          rgba(59, 130, 246, 0.03) 70%,
          rgba(77, 163, 255, 0.02) 100%
        ),
        url('infant.jpg') center center / cover no-repeat fixed;
      z-index: -2;
      filter: brightness(1.05) contrast(0.95);
    }

    #page-bg::after{
      content: '';
      position: absolute;
      inset: 0;
      background: 
        radial-gradient(circle at 20% 50%, rgba(255,255,255,0.08) 0%, transparent 50%),
        radial-gradient(circle at 80% 50%, rgba(77,163,255,0.05) 0%, transparent 50%),
        rgba(255,255,255,0.65);
    }

    body.dark #page-bg::after{
      background: 
        radial-gradient(circle at 20% 50%, rgba(96,165,250,0.06) 0%, transparent 50%),
        radial-gradient(circle at 80% 50%, rgba(15,23,42,0.15) 0%, transparent 50%),
        rgba(15,23,42,0.70);
    }

    #hero {
      position: relative;
      min-height: 160px;
      border-radius: 16px;
      margin-bottom: 24px;
      background: linear-gradient(135deg, rgba(255,255,255,0.9) 0%, rgba(248,250,252,0.95) 100%);
      backdrop-filter: blur(12px);
      -webkit-backdrop-filter: blur(12px);
      display: flex;
      align-items: center;
      padding: 32px;
      border: 1px solid rgba(255,255,255,0.2);
      box-shadow: 
        0 20px 60px rgba(0,0,0,0.08),
        0 8px 24px rgba(0,0,0,0.04),
        inset 0 1px 0 rgba(255,255,255,0.9);
    }

    body.dark #hero {
      background: linear-gradient(135deg, rgba(15,23,42,0.9) 0%, rgba(30,41,59,0.95) 100%);
      border: 1px solid rgba(255,255,255,0.1);
      box-shadow: 
        0 20px 60px rgba(0,0,0,0.3),
        0 8px 24px rgba(0,0,0,0.2),
        inset 0 1px 0 rgba(255,255,255,0.1);
    }

    #hero .hero-text h1{
      margin: 0 0 12px 0;
      font-weight: 700;
      font-size: clamp(32px, 4vw, 52px);
      background: linear-gradient(135deg, #1f2937 0%, #4da3ff 100%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      line-height: 1.2;
    }

    body.dark #hero .hero-text h1{
      background: linear-gradient(135deg, #f9fafb 0%, #60a5fa 100%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }

    #hero .hero-sub{
      font-size: 18px;
      color: #6b7280;
      font-weight: 500;
      opacity: 0.9;
    }
    body.dark #hero .hero-sub{ color: #d1d5db; }

    #splash {
      position: fixed;
      inset: 0;
      background: 
        linear-gradient(135deg, rgba(15, 23, 42, 0.85) 0%, rgba(30, 41, 59, 0.75) 50%, rgba(15, 23, 42, 0.85) 100%),
        url('hero.png') center center / cover no-repeat fixed;
      z-index: 10000;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: all 0.6s cubic-bezier(0.4, 0, 0.2, 1);
      backdrop-filter: blur(2px);
      -webkit-backdrop-filter: blur(2px);
    }

    .splash-inner {
      text-align: center;
      color: white;
      max-width: 700px;
      padding: 60px 40px;
      background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.05) 100%);
      backdrop-filter: blur(20px);
      -webkit-backdrop-filter: blur(20px);
      border-radius: 24px;
      border: 1px solid rgba(255, 255, 255, 0.2);
      box-shadow: 0 32px 80px rgba(0, 0, 0, 0.3), 0 8px 32px rgba(0, 0, 0, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.1);
      position: relative;
    }

    .splash-inner::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 2px;
      background: linear-gradient(90deg, transparent 0%, #4da3ff 20%, #60a5fa 50%, #4da3ff 80%, transparent 100%);
      border-radius: 24px 24px 0 0;
    }

    .splash-inner h1 {
      font-size: clamp(2.5rem, 5vw, 4rem);
      font-weight: 700;
      margin-bottom: 24px;
      background: linear-gradient(135deg, #ffffff 0%, #e5e7eb 100%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      letter-spacing: -0.02em;
      line-height: 1.1;
      text-align: center;
    }

    .splash-inner p {
      font-size: 1.25rem;
      line-height: 1.6;
      margin-bottom: 36px;
      color: rgba(255, 255, 255, 0.9);
      font-weight: 400;
      max-width: 550px;
      margin-left: auto;
      margin-right: auto;
    }

    .splash-features {
      display: flex;
      justify-content: center;
      gap: 32px;
      margin-bottom: 36px;
      flex-wrap: wrap;
    }

    .splash-feature {
      display: flex;
      align-items: center;
      gap: 8px;
      color: rgba(255, 255, 255, 0.8);
      font-size: 0.95rem;
      font-weight: 500;
    }

    .splash-feature i { color: #4da3ff; font-size: 1.1em; }

    #enterBtn {
      background: linear-gradient(135deg, #4da3ff 0%, #357abd 100%);
      border: none;
      color: white;
      padding: 16px 40px;
      font-size: 1.1rem;
      font-weight: 600;
      border-radius: 12px;
      cursor: pointer;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      box-shadow: 0 8px 25px rgba(77, 163, 255, 0.3), 0 4px 12px rgba(0, 0, 0, 0.1);
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    #enterBtn:hover {
      transform: translateY(-3px) scale(1.02);
      box-shadow: 0 12px 35px rgba(77, 163, 255, 0.4), 0 8px 20px rgba(0, 0, 0, 0.15);
    }

    #enterBtn:active { transform: translateY(-1px) scale(1.01); }

    #splash.fade-out {
      opacity: 0;
      transform: scale(0.98);
      backdrop-filter: blur(0px);
      -webkit-backdrop-filter: blur(0px);
    }

    @media (max-width: 768px) {
      .splash-inner { max-width: 90%; padding: 40px 24px; }
      .splash-features { flex-direction: column; gap: 16px; }
      .splash-inner h1 { font-size: 2.5rem; }
      .splash-inner p { font-size: 1.1rem; }
    }
  ")),
    
    tags$script(HTML("
      Shiny.addCustomMessageHandler('setDarkClass', function(isDark){
        document.body.classList.toggle('dark', !!isDark);
      });
      
      document.addEventListener('DOMContentLoaded', function(){
        var btn = document.getElementById('enterBtn');
        var splash = document.getElementById('splash');
        if(btn && splash){
          btn.addEventListener('click', function(){
            splash.style.opacity = '0';
            splash.style.transform = 'scale(0.95)';
            setTimeout(function(){ splash.style.display = 'none'; }, 400);
          });
        }
      });
      
    "))
  ),
  
  #  background layer
  tags$div(id="page-bg"),
  
  # HERO header
  tags$div(
    id = "hero",
    tags$div(
      class = "hero-text",
      tags$h1("Infant Mortality Dashboard"),
      tags$div(class = "hero-sub", "Professional analytics, Interactive insights, Advanced survival modeling")
    )
  ),
  
#splash screen
  tags$div(
    id = "splash",
    tags$div(
      class = "splash-inner",
      tags$h1("Infant Mortality Analytics"),
      tags$p("Comprehensive analysis platform for birth cohort data(UK) from 2019-2022, featuring interactive visualizations, survival modeling, and statistical insights for healthcare and research."),
      tags$div(
        class = "splash-features",
        tags$div(class = "splash-feature", icon("chart-line"), "Interactive Analytics"),
        tags$div(class = "splash-feature", icon("calculator"), "Survival Functions"),
        tags$div(class = "splash-feature", icon("microscope"), "Research Tools")
      ),
      tags$button(id = "enterBtn", class = "btn btn-primary btn-lg", "Launch Platform")
    )
  ),
  
  layout_sidebar(
    sidebar = sidebar(
      id = "controls",
      title = "Upload & Settings",
      width = 320,
      open = "closed",
      
      h5("Upload workbooks"),
      fileInput("file2019","2019 workbook (.xlsx)", accept=c(".xlsx",".xls")),
      fileInput("file2020","2020 workbook (.xlsx)", accept=c(".xlsx",".xls")),
      fileInput("file2021","2021 workbook (.xlsx)", accept=c(".xlsx",".xls")),
      fileInput("file2022","2022 workbook (.xlsx)", accept=c(".xlsx",".xls")),
      hr(),
      fileInput("dailyFile","Daily mortality.xlsx (for the Daily mortality plot)", accept=c(".xlsx",".xls")),
      helpText("Uses daily anchors from interval rates (Day 1, 7, 28, 91, 182, 365). Sheet 1 is NOT used.")
    ),
    
    tabsetPanel(id="main_tabs",
                tabPanel(
                  title = tagList(icon("info-circle"), " Info"),
                  value = "Info",
                  fluidRow(
                    column(
                      12,
                      div(class = "alert alert-primary mb-3",
                          tags$h4("Welcome"),
                          HTML("This dashboard lets you explore infant mortality (birth cohort) data for 2019-2022. 
                     Use the tabs above to browse plots, estimate survival, compare parametric models, 
                     and explore insights.")
                      ),
                      div(class = "frosted", style = "padding:14px; margin-top:10px;",
                          tags$h4("What each tab does"),
                          tags$ul(
                            tags$li(tags$b("Plots:"), " Interactive graphics for:",
                                    tags$ul(
                                      tags$li(tags$b("Interactive Infant Mortality Rate (IMR) (monthly)"), " compare months within or across years; choose line/bar."),
                                      tags$li(tags$b("Daily mortality (age in days)"), " converted daily rates with anchor points to indicate age intervals (1, 7, 28, 91, 182, 365)."),
                                      tags$li(tags$b("IMR by birthweight / mother's age"), " bar charts; optional GA filter(weeks)."),
                                      tags$li(tags$b("Stillbirth vs Neonatal (annual)"), " line comparison of Stillbirth Rates and Neonatal Mortality Rate."),
                                      tags$li(tags$b("Ethnicity IMR (interactive)"), " group IMR with single- or multi-year views.")
                                    )
                            ),
                            tags$li(tags$b("Survival:"), " Quick estimator of surviving to month m, using monthly births/deaths."),
                            tags$li(tags$b("Parametric vs Life-table:"), " Fit a parametric model to interval data and compare the survival functions (S(x))."),
                            tags$li(tags$b("Trends:"), " Auto-generated and static insights that explain what you're seeing.")
                          )
                      ),
                      div(class="text-muted",
                          HTML("<em>Tip:</em> Upload the 2019-2022 ONS workbooks in the left sidebar. 
                     Upload <b>Daily mortality.xlsx</b> to enable the daily and parametric tabs.")
                      ),
                      tags$hr(),
                      div(class = "frosted", style = "padding:14px; margin-top:10px;",
                          tags$h4("Key terms & definitions"),
                          tags$p(tags$b("Infant deaths:"), " deaths under 1 year."),
                          tags$p("Infant deaths (under 1 year) at various ages are defined as:"),
                          tags$ul(
                            tags$li(tags$b("Early neonatal"), " deaths under 7 days"),
                            tags$li(tags$b("Perinatal"), " Stillbirths and early neonatal deaths"),
                            tags$li(tags$b("Late neonatal"), " deaths between 7 and 27 days"),
                            tags$li(tags$b("Neonatal"), " deaths under 28 days"),
                            tags$li(tags$b("Postneonatal"), " deaths between 28 days and 1 year")
                          ),
                          tags$p("Live birth and stillbirth numbers are based on all births that occurred in the reference year."),
                          tags$p("Stillbirths are defined as babies born after 24 or more weeks completed gestation and which did not, at any time, breathe or show signs of life.")
                      )
                    )
                  )
                ),
                
                tabPanel("Plots",
                         title = tagList(icon("chart-line"), " Interactive Plots"),
                         value = "Plots",
                         fluidRow(
                           column(
                             4,
                             wellPanel(
                               shinyWidgets::materialSwitch("darkmode", "Dark mode", inline = TRUE),
                               h5("Choose plot"),
                               selectInput(
                                 "plot_type", NULL,
                                 choices = c("Interactive IMR (monthly)" = "imr",
                                             "Daily mortality (age in days)" = "daily",
                                             "IMR by birthweight (bars)" = "bw",
                                             "IMR by mother's age (bars)" = "mage",
                                             "Stillbirth vs Neonatal (annual)" = "rates",
                                             "Ethnicity IMR (interactive)" = "eth"),
                                 selected = "imr"
                               ),
                               radioButtons("mode","Mode", c("Single year"="single","Compare years"="compare"), inline=TRUE),
                               uiOutput("year_controls"),
                               
                               conditionalPanel("input.plot_type == 'imr'",
                                                radioButtons("imr_geom","Chart type", c("Line"="line","Bar"="bar"), inline=TRUE)
                               ),
                               conditionalPanel("input.plot_type == 'daily'",
                                                uiOutput("daily_year_picker"),
                                                checkboxInput("daily_show_points","Show anchor points", TRUE)
                               ),
                               conditionalPanel("input.plot_type == 'bw' || input.plot_type == 'mage'",
                                                tags$hr(), h5("Filter (optional)"), uiOutput("filters_dynamic")
                               ),
                               helpText("Tip: switch Mode to compare years.")
                             )
                           ),
                           column(
                             8,
                             conditionalPanel("input.plot_type == 'imr'",
                                              div(class="plot-surface", withSpinner(plotlyOutput("imr_plotly", height = 480)))
                             ),
                             conditionalPanel("input.plot_type == 'daily'",
                                              div(class="plot-surface", withSpinner(plotlyOutput("daily_plotly", height = 480)))
                             ),
                             conditionalPanel("input.plot_type == 'eth'",
                                              tagList(
                                                uiOutput("eth_year_picker"),
                                                div(class="plot-surface", withSpinner(plotlyOutput("eth_plotly", height = 480))),
                                                br(), uiOutput("eth_warn")
                                              )
                             ),
                             conditionalPanel("input.plot_type == 'rates'",
                                              div(class="plot-surface", withSpinner(plotOutput("rates_plot", height = 480)))
                             ),
                             conditionalPanel("input.plot_type == 'bw' || input.plot_type == 'mage'",
                                              div(class="plot-surface", withSpinner(plotOutput("viz_plot", height = 480)))
                             ),
                             div(class = "text-end mb-2",
                                 actionButton("go_insights","Insights for this plot", icon = icon("lightbulb"),
                                              class = "btn btn-outline-primary btn-sm")),
                             br(), uiOutput("insight_box")
                           )
                         )
                ),
                
                tabPanel("Survival Analysis",
                         title = tagList(icon("microscope"), " Survival Analysis"),
                         value = "Survival Analysis",
                         fluidRow(
                           column(3,
                                  div(class = "frosted", style = "padding: 20px; margin-bottom: 20px;",
                                      tags$h4("Survival Analysis Suite"),
                                      tags$p("Comprehensive survival analysis tools for infant mortality data with multiple analytical approaches."),
                                      tags$hr(),
                                      
                                      # Main analysis type selector
                                      radioButtons("survival_analysis_type", "Analysis Type:",
                                                   choices = list(
                                                     "Survival Calculator" = "calculator",
                                                     "Parametric Models" = "parametric"
                                                   ),
                                                   selected = "calculator"),
                                      
                                      tags$hr(),
                                      
                                      # Conditional panels for different analysis types
                                      conditionalPanel("input.survival_analysis_type == 'calculator'",
                                                       tags$h5("Quick Survival Calculator"),
                                                       selectInput("surv_year", "Birth cohort year", 
                                                                   choices = c(2019,2020,2021,2022), selected = 2021),
                                                       selectInput("surv_birth_month", "Birth month", 
                                                                   month.name, selected="January"),
                                                       sliderInput("surv_m", "Target survival months", 
                                                                   min=0, max=12, value=12, step=1, ticks=TRUE),
                                                       checkboxInput("show_uniform", "Assume uniform post-neonatal mortality", TRUE)
                                      ),
                                      
                                      conditionalPanel("input.survival_analysis_type == 'lifetables'",
                                                       tags$h5("Life Tables & Cohort Analysis"),
                                                       HTML("<ul style='margin-bottom:0'>
               <li><b>Birth Cohorts:</b> Groups of babies born in same month/year, followed over time</li>
               <li><b>Survival Curves:</b> Show probability of surviving to each age milestone</li>
               <li><b>Life Tables:</b> Detailed mortality risks and survival probabilities by age interval</li>
               <li><b>Confidence Intervals:</b> Statistical uncertainty ranges for robust interpretation</li>
             </ul>")
                                      ),
                                      
                                      
                                      conditionalPanel("input.survival_analysis_type == 'parametric'",
                                                       tags$h5("Parametric Model Fitting"),
                                                       uiOutput("param_controls_unified"),
                                                       tags$p(class = "text-muted", style = "font-size: 12px;",
                                                              "Requires Daily mortality.xlsx upload")
                                      )
                                  )
                           ),
                           
                           column(9,
                                  # Calculator Results
                                  conditionalPanel("input.survival_analysis_type == 'calculator'",
                                                   fluidRow(
                                                     column(6,
                                                            div(class="kpi-card",
                                                                tags$h5("Survival Probability Result"),
                                                                htmlOutput("surv_kpi"),
                                                                tags$hr(),
                                                                htmlOutput("surv_explain")
                                                            )
                                                     ),
                                                     column(6,
                                                            div(class = "frosted", style = "padding: 20px;",
                                                                tags$h5("Calculator Guide"),
                                                                tags$ul(
                                                                  tags$li(tags$b("0 months:"), " Probability of surviving birth"),
                                                                  tags$li(tags$b("1 month:"), " Surviving critical neonatal period"),
                                                                  tags$li(tags$b("12 months:"), " Surviving entire first year")
                                                                ),
                                                                tags$p(class = "text-muted", 
                                                                       "Uses empirical mortality data with uniform distribution assumption for post-neonatal deaths.")
                                                            )
                                                     )
                                                   )
                                  ),
                                  
                                 
                                  
                                  # Parametric Models Results
                                  conditionalPanel("input.survival_analysis_type == 'parametric'",
                                                   div(class="plot-surface", 
                                                       withSpinner(plotOutput("param_surv_plot", height = 400))
                                                   ),
                                                   br(),
                                                   div(class="plot-surface", 
                                                       withSpinner(DTOutput("param_gof"))
                                                   )
                                  ),
                                  
                                  # Contextual Information
                                  div(class = "alert alert-info", style = "margin-top: 20px;",
                                      conditionalPanel("input.survival_analysis_type == 'calculator'",
                                                       tags$h5("Understanding Survival Probabilities"),
                                                       HTML("<ul style='margin-bottom:0'>
                                       <li><b>Clinical relevance:</b> Helps identify high-risk periods and inform healthcare planning</li>
                                       <li><b>Neonatal period:</b> First 28 days typically show highest mortality risk</li>
                                       <li><b>Assumptions:</b> Post-neonatal deaths distributed evenly across months 2-12</li>
                                       <li><b>Interpretation:</b> Higher percentages indicate better survival outcomes</li>
                                     </ul>")
                                      ),
                                      
                                      conditionalPanel("input.survival_analysis_type == 'lifetables'",
                                                       tags$h5("Life Tables & Cohort Analysis"),
                                                       HTML("<ul style='margin-bottom:0'>
                                       <li><b>Birth Cohorts:</b> Groups of babies born in same month/year, followed over time</li>
                                       <li><b>Survival Curves:</b> Show probability of surviving to each age milestone</li>
                                       <li><b>Life Tables:</b> Detailed mortality risks and survival probabilities by age interval</li>
                                       <li><b>Confidence Intervals:</b> Statistical uncertainty ranges for robust interpretation</li>
                                     </ul>")
                                      ),
                                      
                                      conditionalPanel("input.survival_analysis_type == 'parametric'",
                                                       tags$h5("Parametric vs Empirical Models"),
                                                       HTML("<ul style='margin-bottom:0'>
                                       <li><b>Life-table S(x):</b> Step function based directly on observed data</li>
                                       <li><b>Parametric models:</b> Smooth mathematical functions fitted to data</li>
                                       <li><b>Model comparison:</b> Lower AIC indicates better fit; visual comparison shows patterns</li>
                                       <li><b>Use cases:</b> Parametric models enable extrapolation and risk prediction</li>
                                     </ul>")
                                      )
                                  )
                           )
                         )
                ),
                
                tabPanel("Trends",
                         title = tagList(icon("lightbulb"), " Insights & Trends"),
                         value = "Trends",
                         fluidRow(
                           column(12,
                                  h4("Key insights into infant mortality"),
                                  uiOutput("insight_box"),  # This will now show context-aware insights
                                  br(),
                                  div(class = "alert alert-secondary",
                                      tags$h5("Context: COVID-19 and seasonality"),
                                      HTML(paste(
                                        " <b>Lower IMR in 2020</b> coincides with COVID-19 restrictions; first UK lockdown <b>23 March 2020</b>.",
                                        " <b>Seasonality:</b> UK winter (Dec-Jan) tends to have higher IMR.",
                                        " <b>Post-lockdown:</b> IMR rises again in 2021-2022."
                                      ))
                                  )
                           )
                         )
                )
    )
  )
)

# ----------------------- SERVER ---------------------------------------------
server <- function(input, output, session){

  # ===== REACTIVE VALUES =====
  insights_context <- reactiveVal(NULL)
  
  # ===== THEME HANDLING =====
  observeEvent(input$darkmode, ignoreInit = TRUE, {
    session$setCurrentTheme(if (isTRUE(input$darkmode)) theme_dark else theme_light)
  })
  
  observe({
    session$sendCustomMessage("setDarkClass", isTRUE(input$darkmode))
  })
  
  # ===== INSIGHTS BUTTON =====
  observeEvent(input$go_insights, {
    cat("Button clicked! Current plot:", input$plot_type, "\n")
    
    insights_context(list(
      plot_type = input$plot_type,
      mode = input$mode,
      year = input$year,
      years_cmp = input$years_cmp,
      ga = input$ga,
      daily_years = input$daily_years,
      eth_years = input$eth_years
    ))
    
    updateTabsetPanel(session, "main_tabs", selected = "Trends")
    cat("Switched to Trends tab\n")
  })
  
  # toggle .dark class for CSS
  observe({
    session$sendCustomMessage("setDarkClass", isTRUE(input$darkmode))
  })
  
  output$download_plot <- downloadHandler(
    filename = function() paste0("mortality_plot_", Sys.Date(), ".png"),
    content = function(file) {
      ggsave(file, last_plot(), width = 12, height = 8, dpi = 300)
    }
  )
  
  theme_app <- function(dark = FALSE){
    base <- ggplot2::theme_minimal(base_size = 13)
    if (!dark) return(base)
    base + ggplot2::theme(
      plot.background  = ggplot2::element_rect(fill = "#0F172A", color = NA),
      panel.background = ggplot2::element_rect(fill = "#0F172A", color = NA),
      panel.grid.major = ggplot2::element_line(color = "#1F2937"),
      panel.grid.minor = ggplot2::element_line(color = "#1F2937"),
      axis.text        = ggplot2::element_text(color = "#E5E7EB"),
      axis.title       = ggplot2::element_text(color = "#E5E7EB"),
      legend.text      = ggplot2::element_text(color = "#E5E7EB"),
      legend.title     = ggplot2::element_text(color = "#E5E7EB"),
      plot.title       = ggplot2::element_text(color = "#E5E7EB")
    )
  }
  plotly_skin <- function(p, dark = FALSE){
    font_col <- if (dark) "#E5E7EB" else "#1F2937"
    p |> plotly::layout(
      template      = if (dark) "plotly_dark" else "plotly_white",
      paper_bgcolor = "rgba(0,0,0,0)",
      plot_bgcolor  = "rgba(0,0,0,0)",
      font          = list(color = font_col),
      xaxis         = list(tickfont = list(color = font_col), titlefont = list(color = font_col)),
      yaxis         = list(tickfont = list(color = font_col), titlefont = list(color = font_col)),
      legend        = list(font = list(color = font_col))
    )
  }
  
  years_available <- reactive({
    yrs <- c()
    if(!is.null(input$file2019$datapath)) yrs <- c(yrs,2019)
    if(!is.null(input$file2020$datapath)) yrs <- c(yrs,2020)
    if(!is.null(input$file2021$datapath)) yrs <- c(yrs,2021)
    if(!is.null(input$file2022$datapath)) yrs <- c(yrs,2022)
    if(length(yrs)==0) c(2020,2021) else yrs
  })
  
  output$year_controls <- renderUI({
    yrs <- years_available()
    if(input$mode=="single"){
      selectInput("year","Single-year view", choices=yrs, selected=max(yrs))
    } else {
      checkboxGroupInput("years_cmp","Years to compare", choices=yrs, selected=yrs, inline=TRUE)
    }
  })
  
  by_year_months <- reactive({
    out <- list()
    if(!is.null(input$file2019$datapath)) out[[2019]] <- read_months_clean(input$file2019$datapath, 2019)
    if(!is.null(input$file2020$datapath)) out[[2020]] <- read_months_clean(input$file2020$datapath, 2020)
    if(!is.null(input$file2021$datapath)) out[[2021]] <- read_months_clean(input$file2021$datapath, 2021)
    if(!is.null(input$file2022$datapath)) out[[2022]] <- read_months_clean(input$file2022$datapath, 2022)
    safe_bind_rows(out)
  })
  by_year_bwga <- reactive({
    out <- list()
    if(!is.null(input$file2019$datapath)) out[[2019]] <- parse_bw_ga(input$file2019$datapath, 2019)
    if(!is.null(input$file2020$datapath)) out[[2020]] <- parse_bw_ga(input$file2020$datapath, 2020)
    if(!is.null(input$file2021$datapath)) out[[2021]] <- parse_bw_ga(input$file2021$datapath, 2021)
    if(!is.null(input$file2022$datapath)) out[[2022]] <- parse_bw_ga(input$file2022$datapath, 2022)
    safe_bind_rows(out)
  })
  by_year_mage <- reactive({
    out <- list()
    if(!is.null(input$file2019$datapath)) out[[2019]] <- parse_mage_ga(input$file2019$datapath, 2019)
    if(!is.null(input$file2020$datapath)) out[[2020]] <- parse_mage_ga(input$file2020$datapath, 2020)
    if(!is.null(input$file2021$datapath)) out[[2021]] <- parse_mage_ga(input$file2021$datapath, 2021)
    if(!is.null(input$file2022$datapath)) out[[2022]] <- parse_mage_ga(input$file2022$datapath, 2022)
    safe_bind_rows(out)
  })
  by_year_ethnicity <- reactive({
    out <- list()
    if(!is.null(input$file2019$datapath)) out[[2019]] <- parse_ethnicity_imr(input$file2019$datapath, 2019)
    if(!is.null(input$file2020$datapath)) out[[2020]] <- parse_ethnicity_imr(input$file2020$datapath, 2020)
    if(!is.null(input$file2021$datapath)) out[[2021]] <- parse_ethnicity_imr(input$file2021$datapath, 2021)
    if(!is.null(input$file2022$datapath)) out[[2022]] <- parse_ethnicity_imr(input$file2022$datapath, 2022)
    safe_bind_rows(out)
  })
  
  daily_from_uploaded <- reactive({ req(input$dailyFile$datapath); read_daily_from_uploaded(input$dailyFile$datapath) })
  daily_anchors <- reactive({
    req(input$dailyFile$datapath)
    d <- read_daily_from_uploaded(input$dailyFile$datapath)
    validate(need(nrow(d)>0, "Could not parse required columns from Daily mortality.xlsx."))
    d
  })
  daily_curves <- reactive({
    d <- daily_anchors(); yrs <- sort(unique(d$Year))
    purrr::map_dfr(yrs, function(y){
      dfy <- d |> filter(Year==y) |> arrange(Age)
      lx <- log(pmax(dfy$Age,1e-5)); ly <- log(pmax(dfy$Mortality,1e-12))
      xi <- log(pmax(1:365,1e-5)); yi <- approx(lx,ly,xout=xi,rule=2)$y
      tibble(Year=y, Age=1:365, Mortality=exp(yi))
    })
  })
  output$daily_year_picker <- renderUI({
    d <- daily_anchors(); yrs <- sort(unique(d$Year))
    checkboxGroupInput("daily_years","Years to show", choices=yrs, selected=yrs, inline=TRUE)
  })
  
  
  output$filters_dynamic <- renderUI({
    req(input$plot_type %in% c("bw","mage"))
    d_bw <- tryCatch(by_year_bwga(), error = function(e) tibble())
    d_mg <- tryCatch(by_year_mage(), error = function(e) tibble())
    ga_vals <- sort(unique(na.omit(c(as.character(d_bw$ga), as.character(d_mg$ga)))))
    help_txt <- if (input$plot_type == "bw") {
      "Bars show IMR by birthweight; GA filter optional."
    } else {
      "Bars show IMR by mother's age; GA filter optional."
    }
    tagList(
      selectInput("ga","Gestational age", choices = c("All", ga_vals), selected = "All"),
      helpText(help_txt)
    )
  })
  
  months_to_survival <- function(births, neo_deaths, post_deaths, m, uniform=TRUE){
    S1 <- ifelse(births>0, 1 - neo_deaths/births, NA_real_)
    if(m <= 0)  return(1)
    if(m <= 1)  return(S1)
    if(!uniform) return(NA_real_)
    survivors_at_1m <- births - neo_deaths
    total_surv_1to12 <- ifelse(survivors_at_1m>0, 1 - post_deaths/survivors_at_1m, NA_real_)
    q <- ifelse(is.finite(total_surv_1to12) & total_surv_1to12>=0, total_surv_1to12^(1/11), NA_real_)
    S1 * (q^(m - 1))
  }
  
  output$viz_plot <- renderPlot({
    req(input$plot_type)
    if (input$plot_type == "bw") {
      d_bwga <- by_year_bwga()
      validate(need("Year" %in% names(d_bwga) && nrow(d_bwga)>0, "Birthweight x GA table not found in uploads."))
      ga_sel <- input$ga %||% "All"
      db <- d_bwga |>
        dplyr::filter(if (identical(ga_sel, "All")) TRUE else ga == ga_sel) |>
        dplyr::group_by(Year, bw) |>
        dplyr::summarise(births = sum(births, na.rm = TRUE),
                         deaths = sum(deaths, na.rm = TRUE), .groups = "drop") |>
        dplyr::mutate(
          risk = ifelse(births > 0, deaths / births, NA_real_),
          bw = factor(bw, levels = c("<1000g","1000-1499g","1500-1999g","2000-2499g",
                                     "2500-2999g","3000-3499g","3500-3999g",">=4000g",
                                     "Not stated","All birthweight"))
        )
      if (input$mode == "single") {
        db <- db |> dplyr::filter(Year == input$year)
        ggplot2::ggplot(db, ggplot2::aes(x = bw, y = risk * 1000)) +
          ggplot2::geom_col(fill = "#4DA3FF") + ggplot2::coord_flip() +
          ggplot2::labs(x = NULL, y = "IMR (per 1,000)",
                        title = paste0("Infant mortality by birthweight:” ", input$year,
                                       if (ga_sel != "All") paste0(" (GA: ", ga_sel, ")"))) +
          theme_app(isTRUE(input$darkmode))
      } else {
        yrs <- input$years_cmp; validate(need(length(yrs) > 0, "Select year(s) to compare."))
        db <- db |> dplyr::filter(Year %in% yrs, bw != "All birthweight", bw != "Not stated")
        ggplot2::ggplot(db, ggplot2::aes(x = bw, y = risk * 1000, fill = factor(Year))) +
          ggplot2::geom_col(position = "stack") +  # stacked compare
          ggplot2::coord_flip() +
          ggplot2::labs(x = NULL, y = "IMR (per 1,000)", fill = "Year",
                        title = paste0("Infant mortality by birthweight",
                                       if (ga_sel != "All") paste0(" (GA: ", ga_sel, ")"))) +
          theme_app(isTRUE(input$darkmode))
      }
    } else if (input$plot_type == "mage") {
      d_mage <- by_year_mage()
      validate(need("Year" %in% names(d_mage) && nrow(d_mage)>0, "Mother's age — GA table not found in uploads."))
      ga_sel <- input$ga %||% "All"
      dm <- d_mage |>
        dplyr::filter(if (identical(ga_sel, "All")) TRUE else ga == ga_sel) |>
        dplyr::group_by(Year, mage) |>
        dplyr::summarise(births = sum(births, na.rm = TRUE),
                         deaths = sum(deaths, na.rm = TRUE), .groups = "drop") |>
        dplyr::mutate(risk = ifelse(births > 0, deaths / births, NA_real_)) |>
        dplyr::filter(mage != "Not stated")
      if (input$mode == "single") {
        dm <- dm |> dplyr::filter(Year == input$year, mage != "All mothers' ages")
        ggplot2::ggplot(dm, ggplot2::aes(x = mage, y = risk * 1000)) +
          ggplot2::geom_col(fill = "#6C757D") + ggplot2::coord_flip() +
          ggplot2::labs(x = NULL, y = "IMR (per 1,000)",
                        title = paste0("Infant mortality by mother's age:” ", input$year,
                                       if (ga_sel != "All") paste0(" (GA: ", ga_sel, ")"))) +
          theme_app(isTRUE(input$darkmode))
      } else {
        yrs <- input$years_cmp; validate(need(length(yrs) > 0, "Select year(s) to compare."))
        dm <- dm |> dplyr::filter(Year %in% yrs, mage != "All mothers' ages")
        ggplot2::ggplot(dm, ggplot2::aes(x = mage, y = risk * 1000, fill = factor(Year))) +
          ggplot2::geom_col(position = "stack") +   # stacked
          ggplot2::coord_flip() +
          ggplot2::labs(x = NULL, y = "IMR (per 1,000)", fill = "Year",
                        title = paste0("Infant mortality by mother's age",
                                       if (ga_sel != "All") paste0(" (GA: ", ga_sel, ")"))) +
          theme_app(isTRUE(input$darkmode))
      }
    }
  })
  
  output$rates_plot <- renderPlot({
    d_month <- by_year_months()
    validate(need(nrow(d_month) > 0, "Upload at least one dataset"))
    yr_all <- d_month |> dplyr::filter(Month == "All") |> dplyr::select(Year, rate_stillbirth, rate_neonatal)
    validate(need(nrow(yr_all) > 0, "Could not find annual rates on Sheet 1."))
    sel <- if (input$mode == "single") intersect(input$year, yr_all$Year) else intersect(input$years_cmp, yr_all$Year)
    validate(need(length(sel) > 0, "Select year(s) to compare."))
    yrp <- yr_all |> dplyr::filter(Year %in% sel) |>
      tidyr::pivot_longer(c(rate_stillbirth, rate_neonatal),
                          names_to = "rate_type", values_to = "rate") |>
      dplyr::mutate(rate_type = dplyr::recode(
        rate_type,
        rate_stillbirth = "Stillbirth rate (per 1,000 births)",
        rate_neonatal   = "Neonatal mortality rate (per 1,000 live births)"
      ))
    ggplot2::ggplot(yrp, ggplot2::aes(x = Year, y = rate, colour = rate_type)) +
      ggplot2::geom_line(linewidth = 1.3) + ggplot2::geom_point(size = 2.4) +
      ggplot2::scale_x_continuous(breaks = sort(unique(yrp$Year))) +
      ggplot2::labs(x = NULL, y = "Rate (per 1,000)", colour = NULL,
                    title = "Stillbirth vs Neonatal mortality rates (annual)") +
      theme_app(isTRUE(input$darkmode)) +
      ggplot2::theme(legend.position = "top")
  })
  
  output$imr_plotly <- renderPlotly({
    d <- by_year_months(); validate(need(nrow(d)>0, "Upload datasets to see the interactive IMR plot."))
    d <- d |> filter(Month %in% month.name)
    yrs <- if(input$mode=="single") input$year else input$years_cmp
    validate(need(length(yrs)>0, "Select year(s)."))
    d <- d |> filter(Year %in% yrs) |>
      mutate(imr_dec = case_when(
        is.finite(rate_infant) ~ rate_infant/1000,
        births_all>0 & is.finite(deaths_infant) ~ deaths_infant/births_all,
        TRUE ~ NA_real_
      ),
      Month=factor(Month, levels=month.name)) |>
      arrange(Year,Month)
    p <- plot_ly()
    if(input$imr_geom=="line"){
      for(yr in sort(unique(d$Year))){
        dd <- d |> filter(Year==yr)
        p <- p |> add_trace(type="scatter", mode="lines+markers",
                            x=dd$Month, y=dd$imr_dec, name=as.character(yr),
                            hovertemplate=paste0("%{x}<br>", yr, ": %{y:.2%}<extra></extra>"))
      }
      p <- p |> layout(
        xaxis=list(title="Month", categoryorder="array", categoryarray=month.name),
        yaxis=list(title="Infant mortality rate", tickformat=".1%", rangemode="tozero")
      )
    } else {
      p <- d |>
        plot_ly(x=~Month, y=~imr_dec, color=~factor(Year), type="bar",
                hovertemplate="%{x}<br>%{color}: %{y:.2%}<extra></extra>") |>
        layout(
          barmode="stack",
          xaxis=list(title="Month", categoryorder="array", categoryarray=month.name),
          yaxis=list(title="Infant mortality rate", tickformat=".1%", rangemode="tozero")
        )
    }
    plotly_skin(p, dark = isTRUE(input$darkmode))
  })
  
  output$daily_plotly <- renderPlotly({
    d_pts <- daily_anchors(); validate(need(nrow(d_pts)>0, "No daily anchors found."))
    d_cv  <- daily_curves()
    yrs <- input$daily_years; validate(need(length(yrs)>0, "Select at least one year."))
    d_cv  <- d_cv  |> filter(Year %in% yrs)
    d_pts <- d_pts |> filter(Year %in% yrs)
    p <- plot_ly()
    for(yr in sort(unique(d_cv$Year))){
      dd <- d_cv |> filter(Year == yr)
      p <- p |> add_trace(type="scatter", mode="lines",
                          x=dd$Age, y=dd$Mortality, name=as.character(yr),
                          line=list(width=2),
                          hovertemplate=paste0("<b>Year: ",yr,"</b><br>Age: %{x} days<br>Daily rate: %{y:.4f} per 1,000<extra></extra>"))
      if(isTRUE(input$daily_show_points)){
        dp <- d_pts |> filter(Year == yr)
        p <- p |> add_trace(type="scatter", mode="markers",
                            x=dp$Age, y=dp$Mortality, name=paste0(yr," anchors"),
                            showlegend=FALSE,
                            marker=list(size=7, line=list(color="white", width=1.5)),
                            hovertemplate=paste0("<b>Year: ",yr,"</b><br>Age: %{x} days<br>Daily rate: %{y:.4f} per 1,000<extra></extra>"))
      }
    }
    anchors <- c(17,28,91,182,365)
    p <- p |> layout(
      yaxis=list(type="log", title="Daily mortality rate (deaths per 1,000 live births)"),
      xaxis=list(title="Age (days)", range=c(0,365), tickmode="array", tickvals=seq(0,350,50), ticktext=seq(0,350,50)),
      legend=list(orientation="h"),
      hovermode="closest",
      shapes=lapply(anchors, function(x) list(type="line", x0=x, x1=x, y0=1e-3, y1=2,
                                              xref="x", yref="y", line=list(dash="dot", width=1)))
    ) |> config(displayModeBar=TRUE)
    plotly_skin(p, dark = isTRUE(input$darkmode))
  })
  
  output$eth_year_picker <- renderUI({
    d <- by_year_ethnicity()
    validate(need(nrow(d) > 0,
                  "Upload workbooks with a Sheet \"8\" that includes Infant Mortality Rate by ethnicity."))
    d$Year <- suppressWarnings(as.integer(d$Year))
    yrs <- sort(intersect(2019:2022, unique(d$Year)))
    validate(need(length(yrs) > 0, "No valid years (2019-2022) found in Sheet 8."))
    checkboxGroupInput("eth_years","Year(s)", choices=yrs, selected=max(yrs), inline=TRUE)
  })
  
  output$eth_plotly <- renderPlotly({
    d <- by_year_ethnicity()
    validate(need(nrow(d) > 0,
                  "Upload workbooks with a Sheet \"8\" that includes Infant Mortality Rate by ethnicity."))
    d$Year <- suppressWarnings(as.integer(d$Year))
    yrs <- input$eth_years
    validate(need(length(yrs) > 0, "Select at least one year."))
    d <- d |> filter(Year %in% yrs) |>
      mutate(Ethnicity = stringr::str_squish(stringr::str_replace_all(Ethnicity, "\\s+", " "))) |>
      filter(!grepl("^all\\b|^total\\b|not stated|unknown", tolower(Ethnicity)))
    validate(need(nrow(d) > 0, "No ethnicity rows with mortality rates found."))
    ord <- d |> group_by(Ethnicity) |> summarise(m = mean(imr_per_1000, na.rm = TRUE), .groups = "drop") |>
      arrange(desc(m)) |> pull(Ethnicity)
    d$Ethnicity <- factor(d$Ethnicity, levels = ord)
    if (length(yrs) == 1) {
      d_yr <- d |> filter(Year == yrs[[1]])
      p <- plot_ly(
        d_yr, x = ~Ethnicity, y = ~imr_per_1000, type = "bar", color = ~Ethnicity,
        text = ~paste("Ethnicity:", Ethnicity, "<br>Rate:", round(imr_per_1000, 2)),
        hoverinfo = "text"
      ) |>
        layout(
          barmode = "group", bargap = 0.05,
          xaxis = list(title = "", showticklabels = TRUE, tickangle = -45),
          yaxis = list(title = "Infant mortality rate (deaths per 1,000 live births)"),
          legend = list(orientation = "v", x = 1.02, y = 1)
        )
    } else {
      p <- plot_ly(
        d, x = ~Ethnicity, y = ~imr_per_1000, type = "bar", color = ~factor(Year),
        hovertemplate = "%{x}<br>%{color}: %{y:.2f} per 1,000<extra></extra>"
      ) |>
        layout(
          barmode = "group", bargap = 0.08,
          xaxis = list(title = "", showticklabels = TRUE, tickangle = -45),
          yaxis = list(title = "Infant mortality rate (per 1,000)"),
          legend = list(title = list(text = "Year"), orientation = "v", x = 1.02, y = 1)
        )
    }
    plotly_skin(p, dark = isTRUE(input$darkmode))
  })
  
  output$eth_warn <- renderUI({
    d <- by_year_ethnicity(); if (nrow(d) == 0) return(NULL)
    rng <- range(d$imr_per_1000, na.rm = TRUE)
    HTML(sprintf("<em>Note:</em> Range observed: %.1f%.1f per 1,000.", rng[1], rng[2]))
  })
  
  output$surv_kpi <- renderText({
    d <- by_year_months(); validate(need(nrow(d)>0, "Upload a workbook first."))
    req(input$surv_year, input$surv_birth_month, input$surv_m)
    row <- d |> filter(Year == input$surv_year, Month == input$surv_birth_month)
    validate(need(nrow(row)>0, "Selected month not found in the uploaded workbook."))
    S  <- months_to_survival(row$births_all, row$deaths_neonatal, row$deaths_postneo, input$surv_m, input$show_uniform)
    fmt <- scales::percent(S, accuracy = 0.01)
    paste0('<div class="big">', fmt, '</div>',
           '<div class="sub">Probability of surviving beyond month ',
           input$surv_m, ' (', input$surv_birth_month, ' ', input$surv_year, ')</div>')
  })
  output$surv_explain <- renderText({
    d <- by_year_months(); validate(need(nrow(d)>0, "Upload a workbook first."))
    req(input$surv_year, input$surv_birth_month)
    row <- d |> filter(Year == input$surv_year, Month == input$surv_birth_month)
    validate(need(nrow(row)>0, "Selected month not found in the uploaded workbook."))
    S1  <- ifelse(row$births_all>0, 1 - row$deaths_neonatal/row$births_all, NA_real_)
    S12 <- ifelse(row$births_all>0, 1 - row$deaths_infant  /row$births_all, NA_real_)
    paste0(
      "<ul style='margin-bottom:0'>",
      "<li><b>To 1 month:</b> ", scales::percent(S1,  accuracy=0.01), "</li>",
      "<li><b>To 12 months:</b> ", scales::percent(S12, accuracy=0.01), "</li>",
      if (isTRUE(input$show_uniform))
        "<li>Months 2-11 estimated assuming deaths spread evenly across months 2-12 (constant monthly survival).</li>"
      else
        "<li>Exact values are defined at 0, 1 and 12 months only.</li>",
      "</ul>"
    )
  })
  
  # --- Parametric vs Life-table controls & outputs ---
  output$param_controls <- renderUI({
    req(input$dailyFile$datapath)
    yrs <- sort(unique(daily_anchors()$Year))
    tagList(
      selectInput("param_year", "Year (from Daily mortality.xlsx)", choices = yrs, selected = max(yrs)),
      checkboxGroupInput("param_models", "Parametric models",
                         choices = c("Exponential"="exponential","Weibull"="weibull","Gompertz"="gompertz"),
                         selected = c("weibull","exponential","gompertz"), inline = TRUE)
    )
  })
  
  param_fits_unified <- reactive({
    req(input$dailyFile$datapath, input$param_year_unified)
    iv <- prep_intervals_from_daily(input$dailyFile$datapath, input$param_year_unified)
    list(
      exponential = fit_parametric_grouped(iv, "exponential"),
      weibull     = fit_parametric_grouped(iv, "weibull"),
      gompertz    = fit_parametric_grouped(iv, "gompertz"),
      iv = iv
    )
  })
  
  output$param_surv_plot <- renderPlot({
    if(input$survival_analysis_type != 'parametric') return(NULL)
    
    f <- param_fits_unified()
    sel <- input$param_models_unified %||% character(0)
    validate(need(length(sel) > 0, "Select at least one parametric model."))
    
    base_fit <- f[[sel[1]]]
    df <- tibble(t = base_fit$S_times, S = base_fit$S_emp, curve = "Life-table S(x)")
    
    for (m in sel){
      fm <- f[[m]]
      lbl <- paste0(toupper(substring(m, 1, 1)), substring(m, 2), " S(x)")
      df <- bind_rows(df, tibble(t = fm$S_times, S = fm$S_mod, curve = lbl))
    }
    
    ggplot(df, aes(t, S, color = curve, linetype = curve)) +
      geom_step(data = df |> filter(curve == "Life-table S(x)"), linewidth = 1.3) +
      geom_line(data = df |> filter(curve != "Life-table S(x)"), linewidth = 1.3) +
      scale_linetype_manual(values = c("Life-table S(x)"="solid",
                                       "Exponential S(x)"="dashed",
                                       "Weibull S(x)"="dashed", 
                                       "Gompertz S(x)"="dashed")) +
      labs(title = paste0("Year ", input$param_year_unified, " Life-table vs Parametric S(x)"),
           x = "Age (days)", y = "Survival S(x)", color = NULL, linetype = NULL) +
      theme_app(isTRUE(input$darkmode)) +
      theme(legend.position = "top")
  })
  
  output$param_gof <- renderDT({
    if(input$survival_analysis_type != 'parametric') return(NULL)
    
    f <- param_fits_unified()
    gof <- tibble(
      Model = c("Exponential","Weibull","Gompertz"),
      AIC  = c(f$exponential$AIC, f$weibull$AIC, f$gompertz$AIC),
      logLik = c(f$exponential$logLik, f$weibull$logLik, f$gompertz$logLik),
      `Pearson Chi-Square` = c(f$exponential$pearson_chisq, f$weibull$pearson_chisq, f$gompertz$pearson_chisq),
      Deviance = c(f$exponential$deviance, f$weibull$deviance, f$gompertz$deviance)
    ) |> arrange(AIC)
    
    datatable(gof, rownames = FALSE, options = list(pageLength = 5, dom = 't'))
  })
  
  # ======== INSIGHTS=====================================
  static_insight_block <- function(pt){
    switch(
      pt,
      "imr" = div(class="alert alert-info", tags$h5("Monthly IMR:” what this shows"),
                  HTML("<ul style='margin-bottom:0'>
            <li><b>Seasonal pattern:</b> UK winter (Dec-Jan) often shows higher IMR; spring/summer are usually lower.</li>
            <li><b>2020 dip:</b> Lockdown from <b>23 March 2020</b> likely reduced infections and contact, lowering IMR.</li>
            <li><b>After restrictions:</b> Rates in 2021-2022 move back toward pre-pandemic levels.</li>
            <li><b>How to read:</b> Compare the same month across years to tell seasonal peaks from bigger changes.</li>
          </ul>")
      ),
      "bw" = div(class="alert alert-info", tags$h5("Birthweight & IMR:” what this shows"),
                 HTML("<ul style='margin-bottom:0'>
            <li><b>Very small babies are most at risk:</b> Under about 1.5kg carries much higher risk in the first year.</li>
            <li><b>Healthiest range:</b> Around 3-3.5kg usually has the lowest risk.</li>
            <li><b>Why this matters:</b> If more babies are born very small, the overall rate can rise even if care is steady.</li>
            <li><b>How to read:</b> Look for tall bars at the low weights; compare shapes across years.</li>
          </ul>")
      ),
      "mage" = div(class="alert alert-info", tags$h5("Mother's age & IMR :” what this shows"),
                   HTML("<ul style='margin-bottom:0'>
            <li><b>Higher risk at the ends:</b> Babies of mums <b>&lt;20</b> or <b>>40</b> face more challenges (e.g., prematurity).</li>
            <li><b>Lowest risk in the middle:</b> Late 20s to early 30s tend to have the best outcomes.</li>
            <li><b>What to watch:</b> If the U-shape gets steeper over time, age is playing a bigger role.</li>
          </ul>")
      ),
      "rates" = div(class="alert alert-info", tags$h5("Stillbirth vs Neonatal:” what this shows"),
                    HTML("<ul style='margin-bottom:0'>
            <li><b>SBR:</b> stillbirths per 1,000 total births (live + still).</li>
            <li><b>NMR:</b> deaths in the first 27 days per 1,000 live births.</li>
            <li><b>Why compare:</b> SBR reflects pregnancy/labour issues; NMR reflects the early newborn period.</li>
          </ul>")
      ),
      "daily" = div(class="alert alert-info", tags$h5("Daily mortality curve:” what this shows"),
                    HTML("<ul style='margin-bottom:0'>
            <li><b>Front-loaded risk:</b> Highest per-day risk is right after birth and falls quickly over time.</li>
            <li><b>Anchor points:</b> Day 1, 7, 28, 91, 182, 365 guide the curve between known intervals.</li>
          </ul>")
      ),
      "eth" = div(class="alert alert-info", tags$h5("Ethnicity & IMR:” what this shows"),
                  HTML("<ul style='margin-bottom:0'>
            <li><b>Rates vary by group:</b> Differences often reflect a mix of social, environmental and care factors.</li>
            <li><b>How to read:</b> Check if the ordering of groups changes over time or stays consistent.</li>
          </ul>")
      ),
      NULL
    )
  }
  
  output$insight_box <- renderUI({
    # Determine which plot type to show insights for
    if(input$main_tabs == "Trends" && !is.null(insights_context())) {
      # Use the stored context when on Trends tab after clicking button
      context <- insights_context()
      ptype <- context$plot_type
      mode_val <- context$mode
      year_val <- context$year
      years_cmp_val <- context$years_cmp
      ga_val <- context$ga
    } else {
      # Use current input values when on Plots tab
      req(input$plot_type)
      ptype <- input$plot_type
      mode_val <- input$mode
      year_val <- input$year
      years_cmp_val <- input$years_cmp
      ga_val <- input$ga
    }
    
    # Generate insights based on the plot type
    auto_block <- switch(
      ptype,
      "imr" = {
        d <- by_year_months() |> dplyr::filter(Month %in% month.name)
        yrs <- if (mode_val == "single") year_val else years_cmp_val
        validate(need(length(yrs) > 0, "Pick year(s)"))
        d <- d |>
          dplyr::filter(Year %in% yrs) |>
          dplyr::mutate(imr = dplyr::case_when(
            is.finite(rate_infant) ~ rate_infant/1000,
            births_all>0 & is.finite(deaths_infant) ~ deaths_infant/births_all,
            TRUE ~ NA_real_
          )) |>
          dplyr::mutate(Month = factor(Month, levels = month.name))
        top <- d |> dplyr::filter(is.finite(imr)) |> dplyr::slice_max(imr, n = 1, with_ties = FALSE)
        low <- d |> dplyr::filter(is.finite(imr)) |> dplyr::slice_min(imr, n = 1, with_ties = FALSE)
        rng <- (top$imr - low$imr) * 1000
        year_avg <- d |> dplyr::group_by(Year) |> dplyr::summarise(avg = mean(imr, na.rm = TRUE)) |> dplyr::arrange(Year)
        
        HTML(sprintf(
          paste0(
            "<div class='alert alert-light'><b>Auto insight:</b> ",
            "Highest monthly IMR: <b>%s %s</b> (%.2f per 1,000). ",
            "Lowest: <b>%s %s</b> (%.2f per 1,000). Range across selected months: <b>%.2f</b> per 1,000.",
            "<br><i>Yearly averages</i>: %s</div>"
          ),
          as.character(top$Month), top$Year, top$imr*1000,
          as.character(low$Month), low$Year, low$imr*1000, rng,
          paste(sprintf("%s: %.2f", year_avg$Year, year_avg$avg*1000), collapse = "   ")
        ))
      },
      "bw" = {
        d <- by_year_bwga()
        yrs <- if (mode_val == "single") year_val else years_cmp_val
        validate(need(length(yrs) > 0, "Pick year(s)"))
        ga_sel <- ga_val %||% "All"
        dd <- d |>
          dplyr::filter(Year %in% yrs, if (identical(ga_sel,"All")) TRUE else ga == ga_sel) |>
          dplyr::group_by(Year, bw) |>
          dplyr::summarise(births = sum(births, na.rm = TRUE),
                           deaths = sum(deaths, na.rm = TRUE), .groups = "drop") |>
          dplyr::mutate(risk = ifelse(births>0, deaths/births, NA_real_))
        
        hi <- dd |> dplyr::filter(bw != "All birthweight") |> dplyr::slice_max(risk, n=1, with_ties=FALSE)
        lo <- dd |> dplyr::filter(bw != "All birthweight") |> dplyr::slice_min(risk, n=1, with_ties=FALSE)
        
        HTML(sprintf(
          "<div class='alert alert-light'><b>Auto insight:</b> Highest risk group: <b>%s</b> (%.2f per 1,000). Lowest: <b>%s</b> (%.2f per 1,000).<br><i>Tip:</i> The smallest babies usually carry the greatest risk; average-sized babies do best.</div>",
          hi$bw, hi$risk*1000, lo$bw, lo$risk*1000
        ))
      },
      "mage" = {
        d <- by_year_mage()
        yrs <- if (mode_val == "single") year_val else years_cmp_val
        validate(need(length(yrs) > 0, "Pick year(s)"))
        ga_sel <- ga_val %||% "All"
        dd <- d |>
          dplyr::filter(Year %in% yrs, if (identical(ga_sel,"All")) TRUE else ga == ga_sel) |>
          dplyr::group_by(Year, mage) |>
          dplyr::summarise(births = sum(births, na.rm = TRUE),
                           deaths = sum(deaths, na.rm = TRUE), .groups = "drop") |>
          dplyr::mutate(risk = ifelse(births>0, deaths/births, NA_real_)) |>
          dplyr::filter(mage != "Not stated", mage != "All mothers' ages")
        
        hi <- dd |> dplyr::slice_max(risk, n=1, with_ties=FALSE)
        lo <- dd |> dplyr::slice_min(risk, n=1, with_ties=FALSE)
        
        HTML(sprintf(
          "<div class='alert alert-light'><b>Auto insight:</b> Highest risk age group: <b>%s years</b> (%.2f per 1,000). Lowest: <b>%s years</b> (%.2f per 1,000).%s<br><i>Pattern:</i> Typically shows U-shaped curve with higher risks at younger (<20) and older (>40) maternal ages.</div>",
          hi$mage, hi$risk*1000, lo$mage, lo$risk*1000,
          if (!identical(ga_sel, "All")) sprintf(" (filtered to GA: %s)", ga_sel) else ""
        ))
      },
      "rates" = {
        d_month <- by_year_months()
        validate(need(nrow(d_month) > 0, "Upload at least one dataset"))
        yr_all <- d_month |> dplyr::filter(Month == "All") |> 
          dplyr::select(Year, rate_stillbirth, rate_neonatal)
        yrs <- if (mode_val == "single") year_val else years_cmp_val
        validate(need(length(yrs) > 0, "Pick year(s)"))
        yrp <- yr_all |> dplyr::filter(Year %in% yrs)
        
        sb_trend <- if(nrow(yrp) > 1) {
          if(yrp$rate_stillbirth[nrow(yrp)] < yrp$rate_stillbirth[1]) "decreasing" else "increasing"
        } else "stable"
        nm_trend <- if(nrow(yrp) > 1) {
          if(yrp$rate_neonatal[nrow(yrp)] < yrp$rate_neonatal[1]) "decreasing" else "increasing"
        } else "stable"
        
        HTML(sprintf(
          "<div class='alert alert-light'><b>Auto insight:</b> Selected years show stillbirth rate trend: <b>%s</b>, neonatal mortality trend: <b>%s</b>.<br><i>Latest values:</i> SBR: %.2f per 1,000 | NMR: %.2f per 1,000</div>",
          sb_trend, nm_trend,
          yrp$rate_stillbirth[nrow(yrp)], yrp$rate_neonatal[nrow(yrp)]
        ))
      },
      "daily" = {
        d_pts <- daily_anchors()
        validate(need(nrow(d_pts) > 0, "Upload Daily mortality.xlsx"))
        yrs <- input$daily_years
        validate(need(length(yrs) > 0, "Select at least one year"))
        d_sub <- d_pts |> dplyr::filter(Year %in% yrs)
        
        day1_avg <- d_sub |> dplyr::filter(Age == 1) |> dplyr::pull(Mortality) |> mean(na.rm=TRUE)
        day365_avg <- d_sub |> dplyr::filter(Age == 365) |> dplyr::pull(Mortality) |> mean(na.rm=TRUE)
        reduction_pct <- (1 - day365_avg/day1_avg) * 100
        
        HTML(sprintf(
          "<div class='alert alert-light'><b>Auto insight:</b> Day 1 mortality averages <b>%.3f per 1,000</b>, while Day 365 averages <b>%.4f per 1,000</b> — a <b>%.1f%% reduction</b> over the first year.<br><i>Pattern:</i> Most risk is concentrated in the first days of life, declining exponentially thereafter.</div>",
          day1_avg, day365_avg, reduction_pct
        ))
      },
      "eth" = {
        d <- by_year_ethnicity()
        validate(need(nrow(d) > 0, "Upload workbooks with Sheet 8"))
        yrs <- input$eth_years
        validate(need(length(yrs) > 0, "Select at least one year"))
        d_sub <- d |> dplyr::filter(Year %in% yrs)
        
        grp_avg <- d_sub |> dplyr::group_by(Ethnicity) |> 
          dplyr::summarise(avg_imr = mean(imr_per_1000, na.rm=TRUE), .groups="drop") |>
          dplyr::arrange(desc(avg_imr))
        
        HTML(sprintf(
          "<div class='alert alert-light'><b>Auto insight:</b> Highest average IMR: <b>%s</b> (%.2f per 1,000). Lowest: <b>%s</b> (%.2f per 1,000).<br><i>Range:</i> %.2f per 1,000 difference between groups. Disparities reflect complex social, environmental, and healthcare access factors.</div>",
          grp_avg$Ethnicity[1], grp_avg$avg_imr[1],
          grp_avg$Ethnicity[nrow(grp_avg)], grp_avg$avg_imr[nrow(grp_avg)],
          grp_avg$avg_imr[1] - grp_avg$avg_imr[nrow(grp_avg)]
        ))
      },
      NULL
    )
    
    tagList(static_insight_block(ptype), auto_block)
  })

  # Unified parametric controls for the combined tab
  output$param_controls_unified <- renderUI({
    if(is.null(input$dailyFile$datapath)) {
      div(class = "alert alert-warning",
          "Upload Daily mortality.xlsx to enable parametric modeling")
    } else {
      yrs <- sort(unique(daily_anchors()$Year))
      tagList(
        selectInput("param_year_unified", "Year:", choices = yrs, selected = max(yrs)),
        checkboxGroupInput("param_models_unified", "Models:",
                           choices = c("Exponential"="exponential","Weibull"="weibull","Gompertz"="gompertz"),
                           selected = c("weibull","exponential"), inline = TRUE)
      )
    }
  })
  
  
}

shinyApp(ui, server)




