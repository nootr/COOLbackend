"use strict";

(async function() {
    await init();
    menu([GEREGISTREERD, "systeembeheer", function () {
            naarAnderePagina("beheer.html");
        }]);
    ledenLijst(document.getElementById("kop"), document.getElementById("tabel"));
    document.querySelector("#file-input").addEventListener('change', function() {
        // files that user has chosen
        var all_files = this.files;
        if(all_files.length == 0) {
            alert('Error : No file selected');
            return;
        }

        // first file selected by user
        var file = all_files[0];

        // files types allowed
        var allowed_types = [ 'text/plain' ];
        if(allowed_types.indexOf(file.type) == -1) {
            alert('Error : Incorrect file type');
            return;
        }

        // Max 2 MB allowed
        var max_size_allowed = 2*1024*1024
        if(file.size > max_size_allowed) {
            alert('Error : Exceeded size 2MB');
            return;
        }

        // file validation is successfull
        // we will now read the file

        var reader = new FileReader();

        // file reading started
        reader.addEventListener('loadstart', function() {
            document.querySelector("#file-input-label").style.display = 'none';
        });

        // file reading finished successfully
        reader.addEventListener('load', function(e) {
            var text = e.target.result;

            // contents of the file
            document.querySelector("#contents").innerHTML = text;
            document.querySelector("#contents").style.display = 'block';

            document.querySelector("#file-input-label").style.display = 'block';
        });

        // file reading failed
        reader.addEventListener('error', function() {
            alert('Error : Failed to read file');
        });

        // file read progress
        reader.addEventListener('progress', function(e) {
            if(e.lengthComputable == true) {
                document.querySelector("#file-progress-percent").innerHTML = Math.floor((e.loaded/e.total)*100);
                document.querySelector("#file-progress-percent").style.display = 'block';
            }
        });

        // read as text file
        reader.readAsText(file);
    });
})();

function Upload() {
    var fileUpload = document.getElementById("fileUpload");
    var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.csv|.txt)$/;
    if (regex.test(fileUpload.value.toLowerCase())) {
        if (typeof (FileReader) != "undefined") {
            var reader = new FileReader();
            reader.onload = function (e) {
                var table = document.createElement("table");
                var rows = e.target.result.split("\n");
                for (var i = 0; i < rows.length; i++) {
                    var cells = rows[i].split(",");
                    if (cells.length > 1) {
                        var row = table.insertRow(-1);
                        for (var j = 0; j < cells.length; j++) {
                            var cell = row.insertCell(-1);
                            cell.innerHTML = cells[j];
                        }
                    }
                }
                var dvCSV = document.getElementById("dvCSV");
                dvCSV.innerHTML = "";
                dvCSV.appendChild(table);
            }
            reader.readAsText(fileUpload.files[0]);
        } else {
            alert("This browser does not support HTML5.");
        }
    } else {
        alert("Please upload a valid CSV file.");
    }
}

async function ledenLijst(kop, lijst) {
    kop.innerHTML = seizoenVoluit(o_o_o.seizoen) + SCHEIDING + "leden";
    const leden = await localFetch(`/personen/${o_o_o.seizoen}`);
    for (const lid of leden) {
        console.log(lid);
        const knsbNummer = Number(lid.knsbNummer);
        if (knsbNummer > 100) {
            tabel.appendChild(htmlRij(
                lid.naam,
                "", // lid ? lid.knsbRating : "",
                "", // lid ? datumLeesbaar(lid) : "",
                "", // lid ? lid.knsbTeam : "",
                "",
                "", // lid ? lid.nhsbTeam : "",
                "",
                ""));
        }
    }
}

