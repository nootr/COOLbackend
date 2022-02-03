"use strict";

(async function() {
    const rondeNummer = Number(params.get("ronde")) || competitie.vorigeRonde;
    menu([GEREGISTREERD, "systeembeheer", function () {
            naarAnderePagina("beheer.html");
        }],
        [WEDSTRIJDLEIDER, `ranglijst na ronde ${rondeNummer}`, function() {
            naarAnderePagina(`ranglijst.html?ronde=${rondeNummer}`);
        }],
        [WEDSTRIJDLEIDER, `ronde ${rondeNummer} opnieuw indelen`, function () {
            naarAnderePagina(`indelen.html?ronde=${rondeNummer}`);
        }],
        [BEHEERDER, `ranglijst ${ditSeizoen} opnieuw verwerken`, function () {
            for (const key of Object.keys(sessionStorage)) {
                if (key.startsWith(`/ranglijst/${ditSeizoen}`)) {
                    sessionStorage.removeItem(key);
                }
            }
        }],
        [BEHEERDER, `verwijder indeling ronde ${rondeNummer}`, async function () {
            const mutaties = await serverFetch(`/${uuidToken}/verwijder/indeling/${competitie.seizoen}/int/${rondeNummer}`);
            if (mutaties) {
                sessionStorage.removeItem(`/ronde/${competitie.seizoen}/${rondeNummer}`);  // TODO ranglijst weggooien
                naarAnderePagina("ronde.html?ronde=" + rondeNummer);
            }
        }],
        [BEHEERDER, `verwijder ronde ${rondeNummer}`, async function () {
            const mutaties = await serverFetch(`/${uuidToken}/verwijder/ronde/${competitie.seizoen}/int/${rondeNummer}`);
        }]);
    rondeSelecteren(INTERNE_COMPETITIE, rondeNummer);
    wedstrijdenBijRonde(rondeNummer, document.getElementById("kop"), document.getElementById("wedstrijden"));
    const subkop = document.getElementById("subkop");
    subkop.innerHTML = "Ronde " + rondeNummer + SCHEIDING + datumLeesbaar(competitie.ronde[rondeNummer]);
    uitslagenRonde(rondeNummer, document.getElementById("tabel"));
})();

/*
    verwerk &ronde=[rondeNummer]&wit=[wit]&zwart=[zwart]&uitslag=[uitslag]
 */

async function wedstrijdenBijRonde(rondeNummer, kop, lijst) {
    kop.innerHTML = competitie.vereniging + SCHEIDING + seizoenVoluit(competitie.seizoen);
    if (rondeNummer > 1) {
        lijst.appendChild(ranglijstTot(rondeNummer - 1));
    }
    const wedstrijden = await localFetch("/wedstrijden/" + competitie.seizoen);
    for (const wedstrijd of wedstrijden) {
        if (wedstrijdBijRonde(rondeNummer, wedstrijd.datum)) {
            const datumKolom = datumLeesbaar(wedstrijd);
            const wedstrijdKolom = naarTeam(wedstrijd);
            const rondeUitslagen = await uitslagenTeamAlleRonden(wedstrijd.teamCode);
            const u = rondeUitslagen[wedstrijd.rondeNummer - 1];
            const uitslagKolom = uitslagTeam(u.ronde.uithuis, u.winst, u.verlies, u.remise);
            lijst.appendChild(htmlRij("", datumKolom, wedstrijdKolom, uitslagKolom));
        }
    }
    if (competitie.laatsteRonde > rondeNummer + 1) {
        lijst.appendChild(ranglijstTot(rondeNummer + 1));
    }
}

function ranglijstTot(rondeNummer) {
    return htmlRij(
        rondeNummer,
        htmlLink(`ronde.html?ronde=${rondeNummer}`, datumLeesbaar(competitie.ronde[rondeNummer])),
        "interne competitie", "");
}

function wedstrijdBijRonde(rondeNummer, datum) {
    if (rondeNummer === 1) {
        return datum <= competitie.ronde[1].datum; // bij ronde 1 uitsluitend wedstrijden tot en met datum ronde 1
    } else if (rondeNummer === competitie.laatsteRonde) {
        return datum > competitie.ronde[rondeNummer - 1].datum; // bij laatste ronde alle wedstrijden vanaf voorlaatste ronde
    } else {
        return datum > competitie.ronde[rondeNummer - 1].datum && datum <= competitie.ronde[rondeNummer].datum;
    }
}

/*
  -- uitslagen interne competitie per ronde
  select
      uitslag.bordNummer,
      uitslag.knsbNummer,
      wit.naam,
      uitslag.tegenstanderNummer,
      zwart.naam,
      uitslag.resultaat
  from uitslag
  join persoon as wit on uitslag.knsbNummer = wit.knsbNummer
  join persoon as zwart on uitslag.tegenstanderNummer = zwart.knsbNummer
  where seizoen = @seizoen and teamCode = 'int' and rondeNummer = @rondeNummer and witZwart = 'w'
  order by uitslag.seizoen, uitslag.bordNummer;
 */
async function uitslagenRonde(rondeNummer, lijst) {
    const gewijzigd = await uitslagMutatie(rondeNummer);
    const uitslagen = await serverFetch(`/ronde/${competitie.seizoen}/${rondeNummer}`); // actuele situatie
    if (uitslagen.length > 0) {
        for (const uitslag of uitslagen) {
            const uitslagKolom = uitslagVerwerken(rondeNummer, uitslag); // TODO waarom werkt htmlVerwerkt hier niet?
            htmlVerwerkt(uitslagKolom, uitslag.knsbNummer === gewijzigd.wit && uitslag.tegenstanderNummer === gewijzigd.zwart);
            lijst.appendChild(htmlRij(
                uitslag.bordNummer,
                naarSpeler({knsbNummer: uitslag.knsbNummer, naam: uitslag.wit}),
                naarSpeler({knsbNummer: uitslag.tegenstanderNummer, naam: uitslag.zwart}),
                uitslagKolom));
        }
    } else {
        lijst.appendChild(htmlRij("nog", "geen", "uitslagen", ""));
    }
}

async function uitslagMutatie(rondeNummer) {
    const wit = params.get("wit");
    const zwart = params.get("zwart");
    const uitslag = params.get("uitslag");
    if (wit && zwart && uitslag) {
        const mutaties = await serverFetch(
            `/${uuidToken}/uitslag/${competitie.seizoen}/${competitie.competitie}/${rondeNummer}/${wit}/${zwart}/${uitslag}`);
        if (mutaties > 0) {
            for (const key of Object.keys(sessionStorage)) {
                if (key.startsWith(`/ranglijst/${competitie.seizoen}`) ||
                    key.startsWith(`/uitslagen/${competitie.seizoen}`)) { // TODO beperken tot 1 competitie
                    sessionStorage.removeItem(key);
                }
            }
        }
    }
    return {"wit": Number(wit), "zwart": Number(zwart)};
}

function uitslagVerwerken(rondeNummer, uitslag) {
    if (uitslagWijzigen(uitslag)) {
        return uitslagSelecteren(rondeNummer, uitslag)
    } else if (uitslag.resultaat === WINST) {
        return "1-0";
    } else if (uitslag.resultaat === REMISE) {
        return "½-½";
    } else if (uitslag.resultaat === VERLIES) {
        return "0-1";
    } else {
        return "";
    }
}

function uitslagWijzigen(uitslag)  {
    if (competitie.seizoen !== ditSeizoen) { // vorig seizoen nooit wijzigen
        return false;
    } else if (gebruiker.mutatieRechten >= WEDSTRIJDLEIDER) {
        return true;
    } else if (gebruiker.mutatieRechten >= GEREGISTREERD && uitslag.resultaat === "") {
        return uitslag.knsbNummer === gebruiker.knsbNummer || uitslag.tegenstanderNummer === gebruiker.knsbNummer;
    } else {
        return false;
    }
}

function uitslagSelecteren(rondeNummer, uitslag) {
    const select = document.createElement("select");
    select.appendChild(htmlOptie(WINST, "1-0"));
    select.appendChild(htmlOptie(REMISE, "½-½"));
    select.appendChild(htmlOptie(VERLIES, "0-1"));
    select.value = uitslag.resultaat;
    select.addEventListener("input",function () {
        naarZelfdePagina(
            `ronde=${rondeNummer}&wit=${uitslag.knsbNummer}&zwart=${uitslag.tegenstanderNummer}&uitslag=${select.value}`);
    });
    return select;
}