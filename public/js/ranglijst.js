"use strict";

const alleLeden = Number(params.get("leden"));

(async function() {
    await gebruikerVerwerken();
    menu(naarBeheer,
        naarAgenda,
        naarGebruiker,
        terugNaar);
    seizoenSelecteren(INTERNE_COMPETITIE);
    teamSelecteren(INTERNE_COMPETITIE);
    rondeSelecteren(INTERNE_COMPETITIE, 0);
    versieSelecteren(document.getElementById("versies"));
    ledenSelecteren(document.getElementById("leden"));
// TODO bijbehorende voorlopige indeling
    spelersLijst(document.getElementById("kop"), document.getElementById("tabel"));
})();

async function spelersLijst(kop, lijst) {
    let datumTot = params.get("datum");
    if (datumTot) {
        kop.innerHTML = vereniging + SCHEIDING + seizoenVoluit(seizoen) + SCHEIDING + "tot ronde " + rondeNummer;
    } else {
        datumTot = datumSQL();
        kop.innerHTML = vereniging + SCHEIDING + seizoenVoluit(seizoen);
    }
    const winnaars = {};
    (await ranglijst(seizoen, versie, datumTot)).forEach(function (t, i) {
        if (t.inRanglijst() || alleLeden) {
            lijst.appendChild(htmlRij(
                i + 1,
                naarSpeler(t.knsbNummer, t.naam),
                t.punten() ? t.punten() : "",
                t.eigenWaardeCijfer(),
                t.winnaarSubgroep(winnaars),
                t.scoreIntern(),
                t.percentageIntern(),
                t.saldoWitZwart() ? t.saldoWitZwart() : "",
                t.intern() && t.afzeggingen() ? t.afzeggingen() : "",
                t.oneven() ? t.oneven() : "",
                t.scoreExtern(),
                t.percentageExtern(),
                t.rating()));
        }
    });
}

async function versieSelecteren(versies) {  // TODO: versies en teksten in database
    versies.appendChild(htmlOptie(0, "versie 0 volgens huidige reglement"));
    versies.appendChild(htmlOptie(1, "versie 1 zonder aftrek na 10x afzeggen"));
    versies.value = versie;
    versies.addEventListener("input",
        function () {
            naarZelfdePagina("?versie=" + versies.value);
        });
}

function ledenSelecteren(leden) {
    leden.appendChild(htmlOptie(0, "alleen actieve leden"));
    leden.appendChild(htmlOptie(1, "inclusief niet actieve spelers"));
    leden.value = alleLeden;
    leden.addEventListener("input",
        function () {
            naarZelfdePagina("?leden=" + leden.value);
        })
}
