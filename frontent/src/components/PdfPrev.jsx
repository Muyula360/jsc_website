import React, { useEffect, useRef, useState } from "react";


// PDF.js CDN
const PDF_JS_CDN = "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.14.305/pdf.min.js";
const PDF_WORKER_CDN = "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.14.305/pdf.worker.min.js";


const PdfPrev = () => {

  const [pdfFile, setPdfFile] = useState(null);
  const [showPreview, setShowPreview] = useState(false); // Controls visibility of preview
  const canvasRef = useRef(null);
  const loaderRef = useRef(null);
  const pdfjsLibRef = useRef(null);

  useEffect(() => {
    // Dynamically load PDF.js script
    const script = document.createElement("script");
    script.src = PDF_JS_CDN;
    script.onload = () => {
      pdfjsLibRef.current = window["pdfjs-dist/build/pdf"] || window.pdfjsLib;
      pdfjsLibRef.current.GlobalWorkerOptions.workerSrc = PDF_WORKER_CDN;
    };
    document.body.appendChild(script);
  }, []);

  useEffect(() => {
    if (pdfFile && pdfjsLibRef.current) {
      loadPDF(pdfFile);
    }
  }, [pdfFile]);

  // Load and Display the First Page of the PDF
  function loadPDF(pdfUrl) {
    pdfjsLibRef.current.getDocument(pdfUrl).promise.then(function (pdfDoc) {
      pdfDoc.getPage(1).then(function (page) {
        const canvas = canvasRef.current;
        const context = canvas.getContext("2d");

        // Reduce the viewport scale for preview size
        const viewport = page.getViewport({ scale: 0.5 });
        canvas.width = viewport.width;
        canvas.height = viewport.height;

        const renderContext = { canvasContext: context, viewport };
        page.render(renderContext);

        loaderRef.current.style.display = "none";
        canvas.style.display = "block";
        setShowPreview(true); // Show preview, hide input
      });
    }).catch(error => {
      alert("Error loading PDF: " + error.message);
    });
  }

  // Handle File Selection
  function handleFileChange(event) {
    const file = event.target.files[0];

    if (!file || file.type !== "application/pdf") {
      alert("Error: Incorrect file type");
      return;
    }

    if (file.size > 10 * 1024 * 1024) {
      alert("Error: Exceeded size 10MB");
      return;
    }

    setPdfFile(URL.createObjectURL(file));
  }

  return (
    <div>
      {!showPreview && (
        <>
          <button onClick={() => document.getElementById("pdf-file").click()}>Choose PDF</button>
          <input type="file" id="pdf-file" accept="application/pdf" onChange={handleFileChange} style={{ display: "none" }} />
        </>
      )}

      <div ref={loaderRef} style={{ display: pdfFile ? "none" : "block" }}>Loading Preview...</div>
      <canvas ref={canvasRef} style={{ display: "none", width: "150px", height: "100px" }} />
    </div>
  );
}

export default PdfPrev