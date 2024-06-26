const fileInput = document.getElementById("fileToUpload");
const vistaPrevia = document.getElementById("vista-previa");
const vistaPreviaText = document.getElementById("vista-previa-text");

document.getElementById("subir-button").addEventListener("click", () => {
    fileInput.click();
});

fileInput.addEventListener("change", () => {
    const archivos = fileInput.files;

    if (archivos.length > 0) {
        vistaPrevia.style.display = "block";
        vistaPreviaText.textContent = "Archivos seleccionados: ";
        
        for (let i = 0; i < archivos.length; i++) {
            vistaPreviaText.textContent += archivos[i].name;
            if (i < archivos.length - 1) {
                vistaPreviaText.textContent += ", ";
            }
        }
        
        vistaPrevia.style.height = "auto";
    } else {
        vistaPrevia.style.display = "none";
    }
});

function goBack() {
    window.history.back();
}








