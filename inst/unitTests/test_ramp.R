test_mzXML <- function() {
    file <- system.file("threonine", "threonine_i2_e35_pH_tree.mzXML", package = "msdata")
    mzxml <- openMSfile(file, backend="Ramp")
    checkTrue(class(mzxml)=="mzRramp")
    show(mzxml)
    length(mzxml)
    runInfo(mzxml)
    instrumentInfo(mzxml)
    peaks(mzxml)
    peaks(mzxml,1)
    peaks(mzxml,2:3)
    peaksCount(mzxml)
    header(mzxml)
    header(mzxml,1)
    header(mzxml,2:3)
    fileName(mzxml)
    hdr <- header(mzxml)
    checkTrue(any(colnames(hdr) == "centroided"))
    checkTrue(all(is.na(hdr$centroided)))
    checkTrue(any(colnames(hdr) == "ionMobilityDriftTime"))
    checkTrue(all(is.na(hdr$ionMobilityDriftTime)))
    close(mzxml)
}

test_mzML <- function() {
    file <- system.file("microtofq", "MM14.mzML", package = "msdata")
    mzml <- openMSfile(file, backend="Ramp")
    checkTrue(class(mzml)=="mzRramp")
    show(mzml)
    length(mzml)
    runInfo(mzml)
    instrumentInfo(mzml)
    peaks(mzml)
    peaks(mzml,1)
    peaks(mzml,2:3)
    peaksCount(mzml)
    hdr <- header(mzml)
    checkTrue(any(colnames(hdr) == "spectrumId"))
    checkEquals(hdr$spectrumId, paste0("scan=", hdr$acquisitionNum))
    header(mzml,1)
    header(mzml,2:3)
    checkTrue(any(colnames(hdr) == "ionMobilityDriftTime"))
    checkTrue(all(is.na(hdr$ionMobilityDriftTime)))

    checkTrue(ncol(header(mzml))>4)
    checkTrue(length(header(mzml,1))>4)
    checkTrue(ncol(header(mzml,2:3))>4)

    ## Check polarity reporting
#    checkTrue(all(header(mzml)$polarity==1))

    fileName(mzml)
    close(mzml)
}

test_mzData <- function() {
    file <- system.file("microtofq", "MM14.mzdata", package = "msdata")
    mzdata <- openMSfile(file, backend="Ramp")
    checkTrue(class(mzdata)=="mzRramp")
    show(mzdata)
    length(mzdata)
    runInfo(mzdata)
    checkTrue(all(instrumentInfo(mzdata)==""))
    peaks(mzdata)
    peaks(mzdata,1)
    peaks(mzdata,2:3)
    peaksCount(mzdata)
    hdr <- header(mzdata)
    checkTrue(any(colnames(hdr) == "spectrumId"))
    checkEquals(hdr$spectrumId, paste0("scan=", hdr$acquisitionNum))
    header(mzdata,1)
    header(mzdata,2:3)
    fileName(mzdata)

    ## Check polarity reporting
    checkTrue(all(header(mzdata)$polarity==1))
   
    close(mzdata)    
}

test_mzData.gz <- function() {
    file <- system.file("microtofq", "MM14.mzdata.gz", package = "msdata")
    mzdata <- openMSfile(file, backend="Ramp")
    checkTrue(class(mzdata)=="mzRramp")
    show(mzdata)
    length(mzdata)
    runInfo(mzdata)
    checkTrue(all(instrumentInfo(mzdata)==""))
    peaks(mzdata)
    peaks(mzdata,1)
    peaks(mzdata,2:3)
    peaksCount(mzdata)
    hdr <- header(mzdata)
    checkTrue(any(colnames(hdr) == "spectrumId"))
    checkEquals(hdr$spectrumId, paste0("scan=", hdr$acquisitionNum))
    header(mzdata,1)
    header(mzdata,2:3)
    fileName(mzdata)
    close(mzdata)    
}

test_peaks_spectra <- function() {
    library("msdata")
    f <- proteomics(full.names = TRUE)
    x <- openMSfile(f[1])
    p <- peaks(x, 1:10)
    s <- spectra(x, 1:10)
    checkIdentical(p, s)
    close(x)
}

test_chromatogram <- function() {
    library("msdata")
    f <- proteomics(full.names = TRUE)
    x <- openMSfile(f[1], backend = "Ramp")
    suppressWarnings(
        chr <- chromatogram(x)
    )
    checkTrue(length(chr) == 0)
    suppressWarnings(
        chr <- chromatograms(x)
    )
    checkTrue(length(chr) == 0)
    close(x)
}

test_chromatogramHeader <- function() {
    library("msdata")
    f <- proteomics(full.names = TRUE)
    x <- openMSfile(f[1], backend = "Ramp")
    suppressWarnings(
        ch <- chromatogramHeader(x)
    )
    checkTrue(nrow(ch) == 0)
    close(x)
}

