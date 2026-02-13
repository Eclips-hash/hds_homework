# ==========================================
# METABRIC Data Downloader
# Purpose: Ensures all raw data is present 
# before running the main analysis.
# ==========================================

# 1. Increase timeout (vital for large files)
options(timeout = 600)

# 2. Define Paths
if (!dir.exists("data")) dir.create("data")

files_to_download <- list(
  "clinical" = "https://raw.githubusercontent.com/HannahHong/Masters_HealthData/main/data/metabric_data_clinical_patient.csv",
  "expression" = "https://zenodo.org/records/18587857/files/metabric_data_expression_normalised.txt"
)

# 3. Execution Loop
for (name in names(files_to_download)) {
  dest <- paste0("data/metabric_data_", name, ".txt") # or .csv
  
  if (!file.exists(dest)) {
    message(paste("Downloading", name, "data..."))
    try(download.file(files_to_download[[name]], dest, method = "libcurl", mode = "wb"))
  } else {
    message(paste("✅", name, "data already exists."))
  }
}

message("Setup Complete!")