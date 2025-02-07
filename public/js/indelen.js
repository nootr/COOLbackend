"use strict";

/*
    verwerk ronde=<ronde>
           &rangnummers=aan
           &indelen=<versienummer indelen algoritme>
 */

(async function() {
    await init();
    competitieTitel();
    const rondeNummer = Number(params.get("ronde")) || o_o_o.huidigeRonde;
    const totDatum = o_o_o.ronde[rondeNummer].datum;
    const subkop = document.getElementById("subkop");
    subkop.innerHTML = "Indeling ronde " + rondeNummer + SCHEIDING + datumLeesbaar({datum: totDatum});
    const wit = [];
    const zwart = [];
    let oneven = 0; // eerste speler is nooit oneven
    const deelnemers = await deelnemersRonde(rondeNummer, MEEDOEN);
    const r = zwitsers(o_o_o.competitie) // TODO weer 1 ranglijstSorteren
        ? await ranglijstOpPuntenWeerstandenRating(rondeNummer, deelnemers)
        : await ranglijstOpPuntenRating(rondeNummer, deelnemers);
    if (zwitsers(o_o_o.competitie)) {
        console.log("--- Zwitsers systeem ---");
        for (const speler of r) {
            console.log(`${speler.naam} ${speler.totaal()} sb: ${speler.sonnebornBerger()} wp: ${speler.weerstandsPunten()}`);
        }
        const pogingen = [];
        const partijen = zwitsersIndelen(r, pogingen);
        const gesorteerdePartijen = partijen.sort(function (een, ander) {
            return Math.min(een[0], een[1]) - Math.min(ander[0], ander[1]);
        });
        console.log(gesorteerdePartijen);
        for (const p of gesorteerdePartijen) {
            if (p[0] === p[1]) {
                oneven = p[0];
            } else {
                wit.push(p[0]);
                zwart.push(p[1]);
            }
        }
    } else if (rondeNummer === 1) { // Alkmaar systeem eerste ronde
        oneven = r.length % 2 === 0 ? 0 : r.length - 1;  // laatste speler is oneven
        indelenEersteRonde(oneven ? oneven : r.length, 3, wit, zwart);
    } else { // Alkmaar systeem andere ronden
        oneven = indelenRonde(r, wit, zwart, rondeNummer);
    }
    const rangnummers = rangnummersToggle(document.querySelector("details"), rondeNummer);
    const uithuis = await serverFetch(`/${uuidToken}/uithuis/${o_o_o.seizoen}/${rondeNummer}`); // actuele situatie
    partijenLijst(r, wit, zwart, oneven, rangnummers, document.getElementById("partijen"), uithuis);
    if (rangnummers) {
        deelnemersLijst(r, document.getElementById("lijst"));
    }
    menu([GEREGISTREERD, "systeembeheer", function () {
            naarAnderePagina("beheer.html");
        }],
        [WEDSTRIJDLEIDER, "indeling definitief maken", async function () {
            let mutaties = 0;
            for (let i = 0; i < wit.length; i++) {
                if (await serverFetch(
                    `/${uuidToken}/indelen/${o_o_o.seizoen}/${o_o_o.competitie}/${rondeNummer}/${i + 1}/${r[wit[i]].knsbNummer}/${r[zwart[i]].knsbNummer}`)) {
                    mutaties += 2;
                }
            }
            if (oneven) {
                if (await serverFetch(
                    `/${uuidToken}/oneven/${o_o_o.seizoen}/${o_o_o.competitie}/${rondeNummer}/${r[oneven].knsbNummer}`)) {
                    mutaties += 1;
                }
            }
            mutaties += await serverFetch(`/${uuidToken}/afwezig/${o_o_o.seizoen}/${o_o_o.competitie}/${rondeNummer}`);
            mutaties += await serverFetch(`/${uuidToken}/extern/${o_o_o.seizoen}/${o_o_o.competitie}/${rondeNummer}`);
            if (mutaties) {
                naarAnderePagina(`ronde.html?ronde=${rondeNummer}`);
            }
        }]);
    versieSelecteren(document.getElementById("versies"), rondeNummer);
})();

async function deelnemersRonde(rondeNummer, partij) {
    if (GEREGISTREERD <= gebruiker.mutatieRechten) {
        return await serverFetch(`/${uuidToken}/deelnemers/${o_o_o.seizoen}/${o_o_o.competitie}/${rondeNummer}/${partij}`); // actuele situatie
    } else {
        return [0]; // een onbekende deelnemer, zodat niet alle spelers worden geselecteerd
    }
}

async function ranglijstOpPuntenRating(rondeNummer, deelnemers) {
    const lijst = await ranglijst(rondeNummer, deelnemers);
    lijst.sort(function (een, ander) {
        return ander.totaal() - een.totaal(); // van hoog naar laag
    });
    return lijst;
}

async function ranglijstOpPuntenWeerstandenRating(rondeNummer, deelnemers) {
    const lijst = await ranglijst(rondeNummer, deelnemers);
    for (const speler of lijst) {
        let i = 20;
        let wp = speler.oneven() * 5; // bijtelling oneven
        let sb = speler.oneven() * 50;
        while (speler.totalen[i]) { // indien rondeNummer
            const knsbNummer = speler.totalen[i + 2];
            if (knsbNummer) {
                let tegenstander = 0;
                while (lijst[tegenstander].knsbNummer !== knsbNummer) {
                    tegenstander++;
                }
                wp += lijst[tegenstander].totaal() - lijst[tegenstander].oneven() * 5;  // aftrek oneven
                if (speler.totalen[i + 3] === 2) { // wint van tegenstander
                    sb += lijst[tegenstander].totaal() * 10 - lijst[tegenstander].oneven() * 50;
                } else if (speler.totalen[i + 3] === 1) { // remise met tegenstander
                    sb += lijst[tegenstander].totaal() * 5 - lijst[tegenstander].oneven() * 25;
                }
            } else {
                if (speler.totalen[i] === rondeNummer - 1) {
                    wp -= 5; // in ranglijst na vorige ronde geen aftrek of bijtelling oneven
                    sb -= 50;
                }
            }
            i = i + 4; // volgende rondeNummer, kleur, knsbNummer en resultaat
        }
        speler.weerstandsPuntenInvullen(wp);
        speler.sonnebornBergerInvullen(sb);
    }
    lijst.sort(function (een, ander) {
        return ander.totaal() - een.totaal() || ander.sonnebornBerger() - een.sonnebornBerger() || ander.weerstandsPunten() - een.weerstandsPunten();
    });
    return lijst;
}

function rangnummersToggle(rangnummers, rondeNummer) {
    const rangnummersAan = params.get("rangnummers");
    if (rangnummersAan) {
        rangnummers.open = true;
    } else {
        rangnummers.addEventListener("toggle",function () {
            naarZelfdePagina(`ronde=${rondeNummer}&indelen=${versieIndelen}&rangnummers=aan`);
        });
    }
    return rangnummersAan;
}

function partijenLijst(r, wit, zwart, oneven, rangnummers, partijen, extern) {
    for (let i = 0; i < wit.length; i++) {
        partijen.appendChild(htmlRij(
            i + 1,
            naarSpeler(r[wit[i]]),
            naarSpeler(r[zwart[i]]),
            rangnummers ? `${wit[i] + 1} - ${zwart[i] + 1}` : ""
        ));
    }
    if (oneven) {
        partijen.appendChild(htmlRij("", naarSpeler(r[oneven]), "", "oneven"));
    }
    let bord = wit.length;
    for (const speler of extern) { // EXTERN_THUIS heeft extra bord nodig EXTERN_UIT niet
        partijen.appendChild(htmlRij(speler.partij === EXTERN_THUIS ? ++bord : "", naarSpeler(speler), "", "extern"));
    }
}

function deelnemersLijst(r, lijst) {
    r.forEach(function(t, i) {
        lijst.appendChild(htmlRij(
            i + 1,
            naarSpeler(t),
            t.totaal(),
            t.eigenWaardeCijfer(),
            t.intern() ? t.intern() : "",
            t.saldoWitZwart() ? t.saldoWitZwart() : ""));
    });
}

function indelenEersteRonde(aantalSpelers, aantalGroepen, wit, zwart) {
    const aantalPartijen = aantalSpelers / 2;
    aantalGroepen = juisteAantalGroepen(aantalGroepen, aantalSpelers);
    const helftGroep = Math.floor(aantalPartijen / aantalGroepen);
    const tot = (aantalGroepen - 1) * helftGroep; // tot laatste groep
    for (let van = 0; van < tot; van += helftGroep) {
        groepIndelenEersteRonde(van, van + helftGroep, wit, zwart);
    }
    groepIndelenEersteRonde(tot, aantalPartijen, wit, zwart);
}

function juisteAantalGroepen(aantalGroepen, aantalSpelers) {
    if (aantalSpelers < 7) {
        return 1;
    } else if (aantalSpelers < 11 && aantalGroepen > 2) {
        return 2;
    } else if (aantalSpelers < 15 && aantalGroepen > 3) {
        return 3;
    } else if (aantalGroepen > 4) { // TODO testen met meer dan 4 groepen
        return 4;
    } else {
        return aantalGroepen;
    }
}

function groepIndelenEersteRonde(van, tot, wit, zwart) {
    const sterkste = van % 2;
    for (let i = van; i < tot; i++) {
        if (i % 2 === sterkste) { // op van, van + 2, van + 4 heeft de sterkste speler zwart
            wit[i] = i + tot;
            zwart[i] = i + van;
        } else {
            wit[i] = i + van;
            zwart[i] = i + tot;
        }
    }
}

const versieIndelen = Number(params.get("indelen")) || 0;

function versieSelecteren(versies, rondeNummer) {
    for (let i = 0; i < indelenFun.length; i++) {
        versies.appendChild(htmlOptie(i, indelenFun[i][0]));
    }
    versies.value = versieIndelen;
    versies.addEventListener("input",
        function () {
            naarZelfdePagina(`ronde=${rondeNummer}&indelen=${versies.value}&rangnummers=aan`);
        });
}

function indelenRonde(r, wit, zwart, rondeNummer) {
    // console.log("--- indelenRonde ---");
    // console.log("rondeNummer: " + rondeNummer);
    return indelenFun[versieIndelen][1](r, wit, zwart, rondeNummer);
}

/**
 * Liever nietTegen volgens heuristieken.
 *
 * @param r ranglijst
 * @param i speler
 * @param j tegenstander
 * @param rondeNummer huidige ronde
 * @returns {boolean}
 */
function nietTegen(r, i, j, rondeNummer) {
    const nogNietTegen = [101 , 103]; // Ramon Witte, Charles Stoorvogel
    if (!r[i].tegen(r[j], rondeNummer)) {
        return true;
    } else if (o_o_o.competitie === RAPID_COMPETTIE || versieIndelen > 0) { // rapid en oudere versies zonder heuristieken
        return false;
    } else if (r[i].intern() < 4 && nogNietTegen.includes(r[j].knsbNummer)) {
        console.log(`${r[i].naam} nog niet tegen ${r[j].naam}`);
        return true; // de eerste 3 x nogNietTegen
    } else if (r[j].intern() < 4 && nogNietTegen.includes(r[i].knsbNummer)) {
        console.log(`${r[j].naam} nog niet tegen ${r[i].naam}`);
        return true; // de eerste 3 x nogNietTegen
    } else if (r[i].eigenWaardeCijfer() - r[j].eigenWaardeCijfer() >= 3) {
        if (r[j].intern() / r[i].intern() > 2) {
            console.log(`${r[i].naam} te sterk voor ${r[j].naam}`);
            return true; // verschil waardecijfers meer dan 3 en helft minder aantal partijen gespeeld
        }
    } else if (r[j].eigenWaardeCijfer() - r[i].eigenWaardeCijfer() >= 3) {
        if (r[i].intern() / r[j].intern() > 2) {
            console.log(`${r[j].naam} te sterk voor ${r[i].naam}`);
            return true; // verschil waardecijfers meer dan 3 en helft minder aantal partijen gespeeld
        }
    }
    return false;
}

const indelenFun = [
    ["vooruit indelen met en achteruit indelen zonder heuristieken", function (r, wit, zwart, rondeNummer) {
        const oneven = onevenSpeler(r);
        let nietIngedeeld = vooruitIndelen(r, wit, zwart, oneven, rondeNummer);
        if (nietIngedeeld.length > 0) {
            let pogingen = 0
            let poging = [];
            for (let volgnummer = 0; volgnummer < 6; volgnummer++) {
                poging = [];
                let speler = 999;
                while (nietIngedeeld.length > 0 && speler > 0 && ++pogingen < 13) {
                    console.log("--- 1 niet ingedeelde speler --- poging #" + pogingen + "/" + volgnummer);
                    opnieuwIndelen(wit, zwart);
                    speler = volgendeNietIngedeeldeSpeler(nietIngedeeld, poging, volgnummer);
                    spelerIndelen(speler, VOORUIT, r, wit, zwart, oneven, rondeNummer) ||
                    spelerIndelen(speler, ACHTERUIT, r, wit, zwart, oneven, rondeNummer);
                    nietIngedeeld = vooruitIndelen(r, wit, zwart, oneven, rondeNummer);
                }
            }
            if (nietIngedeeld.length > 0) {
                console.log("--- alle niet ingedeelde spelers --- poging #" + ++pogingen);
                opnieuwIndelen(wit, zwart);
                while (eenNietIngedeeldeSpeler(nietIngedeeld, poging)) {
                    // toevoegen aan poging
                }
                for (const speler of poging) {
                    if (!ingedeeld(speler, wit, zwart, oneven)) {
                        spelerIndelen(speler, VOORUIT, r, wit, zwart, oneven, rondeNummer) ||
                        spelerIndelen(speler, ACHTERUIT, r, wit, zwart, oneven, rondeNummer);
                    }
                }
                nietIngedeeld = vooruitIndelen(r, wit, zwart, oneven, rondeNummer);
            }
            if (nietIngedeeld.length > 0) {
                console.log("--- mislukt ---");
            }
        }
        return oneven;
    }],

    ["indelen met heuristieken en niet ingedeelde spelers opnieuw verwerken", function (r, wit, zwart, rondeNummer) {
        const oneven = onevenSpeler(r);
        let nietIngedeeld = vooruitIndelen(r, wit, zwart, oneven, rondeNummer);
        if (nietIngedeeld.length > 0) {
            let pogingen = 0
            let poging = [];
            let speler = 999;
            while (nietIngedeeld.length > 0 && speler > 0 && ++pogingen < 13) {
                console.log("--- 1 niet ingedeelde speler --- poging #" + pogingen);
                opnieuwIndelen(wit, zwart);
                speler = eenNietIngedeeldeSpeler(nietIngedeeld, poging);
                spelerIndelen(speler, VOORUIT, r, wit, zwart, oneven, rondeNummer) ||
                spelerIndelen(speler, ACHTERUIT, r, wit, zwart, oneven, rondeNummer);
                nietIngedeeld = vooruitIndelen(r, wit, zwart, oneven, rondeNummer);
            }
            if (nietIngedeeld.length > 0) {
                console.log("--- alle niet ingedeelde spelers --- poging #" + ++pogingen);
                opnieuwIndelen(wit, zwart);
                while (eenNietIngedeeldeSpeler(nietIngedeeld, poging)) {
                    // toevoegen aan poging
                }
                for (const speler of poging) {
                    if (!ingedeeld(speler, wit, zwart, oneven)) {
                        spelerIndelen(speler, VOORUIT, r, wit, zwart, oneven, rondeNummer) ||
                        spelerIndelen(speler, ACHTERUIT, r, wit, zwart, oneven, rondeNummer);
                    }
                }
                nietIngedeeld = vooruitIndelen(r, wit, zwart, oneven, rondeNummer);
            }
            if (nietIngedeeld.length > 0) {
                console.log("--- mislukt ---");
            }
        }
        return oneven;
    }],

    ["indelen met alleen vooruit gaan", function (r, wit, zwart, rondeNummer) {
        console.log("--- indelen met met alleen vooruit gaan ---");
        const oneven = onevenSpeler(r);
        for (let i = 0; i < r.length; i++) {
            if (!ingedeeld(i, wit, zwart, oneven)) { // indien niet ingedeeld of oneven
                let j = i + 1;
                while (j < r.length && (ingedeeld(j, wit, zwart, oneven) || !r[i].tegen(r[j], rondeNummer))) {
                    j++; // volgende indien al ingedeeld of oneven of mag niet tegen
                }
                if (j < r.length) {
                    if (r[i].metWit(r[j])) {
                        wit.push(i);
                        zwart.push(j);
                    } else {
                        wit.push(j);
                        zwart.push(i);
                    }
                }
            }
        }
        return oneven;
    }]];

function vooruitIndelen(r, wit, zwart, oneven, rondeNummer) {
    const nietIngedeeld = [];
    for (let i = 0; i < r.length; i++) {
        if (!ingedeeld(i, wit, zwart, oneven)) { // indien niet ingedeeld of oneven
            let j = i + 1;
            while (j < r.length && (ingedeeld(j, wit, zwart, oneven) || nietTegen(r, i, j, rondeNummer))) {
                j++; // volgende indien al ingedeeld of oneven of mag niet tegen
            }
            if (j < r.length) {
                if (r[i].metWit(r[j])) {
                    wit.push(i);
                    zwart.push(j);
                } else {
                    wit.push(j);
                    zwart.push(i);
                }
            }
        }
        if (!ingedeeld(i, wit, zwart, oneven)) { // indien niet ingedeeld of oneven
            console.log(`${r[i].naam} is niet ingedeeld`);
            nietIngedeeld.push(i);
        }
    }
    return nietIngedeeld;
}

const VOORUIT = 1;
const ACHTERUIT = -1;

function spelerIndelen(speler, richting, r, wit, zwart, oneven, rondeNummer) {
    console.log(`--- ${r[speler].naam} ${richting === VOORUIT ? "vooruit" : "achteruit"} indelen ---`);
    let j = speler + richting;
    while (j >= 0 && j < r.length && (ingedeeld(j, wit, zwart, oneven) || !r[speler].tegen(r[j], rondeNummer))) { // zonder heuristieken
        j = j + richting; // volgende / vorige indien al ingedeeld of oneven of mag niet tegen
    }
    if (j >= 0 && j < r.length) {
        if (r[speler].metWit(r[j])) {
            wit.push(speler);
            zwart.push(j);
        } else {
            wit.push(j);
            zwart.push(speler);
        }
        return true;
    } else {
        return false;
    }
}

function ingedeeld(speler, wit, zwart, oneven) {
    return wit.includes(speler) || zwart.includes(speler) || (oneven && speler === oneven);
}

function opnieuwIndelen(wit, zwart) {
    while (wit.length) {
        wit.pop();
        zwart.pop();
    }
}

function eenNietIngedeeldeSpeler(nietIngedeeld, poging) {
    for (const speler of nietIngedeeld) {
        if (!poging.includes(speler)) {
            poging.push(speler);
            return speler;
        }
    }
    return 0;
}

function volgendeNietIngedeeldeSpeler(nietIngedeeld, poging, volgnummer) {
    let nummer = 0;
    for (const speler of nietIngedeeld) {
        if (!poging.includes(speler) && ++nummer >= volgnummer) {
            poging.push(speler);
            return speler;
        }
    }
    return 0;
}

/**
 * Indien er een oneven aantal deelnemers is, is er een onevenSpeler.
 * De onevenSpeler is de laagste speler van de ranglijst met het grootste aantal gespeelde partijen
 * die niet eerder oneven was en
 * die niet bij eerste 8 aanwezige spelers van de ranglijst staat.
 *
 * @param r ranglijst
 * @returns {number|number} 0 indien niemand oneven anders onevenSpeler
 */
function onevenSpeler(r) {
    let oneven = r.length % 2 === 0 ? 0 : r.length - 1;  // laatste speler is oneven
    if (oneven) {
        while (r[oneven].oneven()) {
            console.log(`laatste speler ${r[oneven].naam} was al oneven`);
            oneven--;
        }
        for (let i = oneven; i > 7; i--) { // eerste 8 aanwezige spelers mogen niet oneven zijn
            if (r[i].oneven()) {
                console.log(`${r[i].naam} was al oneven`);
            } else if (r[i].intern() > r[oneven].intern()) {
                console.log(`${r[i].naam} heeft meer interne partijen gespeeld dan ${r[oneven].naam}`);
                oneven = i;
            }
        }
        console.log(`${r[oneven].naam} is oneven`);
    }
    return oneven;
}

/**
 * zwitsersIndelen deelt in volgens de reglementen van het FIDE Dutch system
 *
 * https://spp.fide.com/c-04-3-fide-dutch-system/
 *
 * ?param r ranglijst (= A.1 initial ranking list)
 * ?returns ingedeelde partijen of false
 */
function zwitsersIndelen(r, pogingen, eerst) {
    console.log(`=== zwitsersIndelen === poging #${pogingen.length}`);
    let partijen = [];
    let oneven = r.length % 2 === 0 ? 0 : r.length - 1;
    if (oneven) {
        while (r[oneven].oneven()) { // Absolute Criteria C.2
            console.log(`${r[oneven].naam} was al oneven`);
            oneven--;
        }
        console.log(`${r[oneven].naam} is oneven`);
        partijen.push([oneven, oneven]);
    }
    if (eerst) {
        console.log(`eerst indelen: ${r[eerst].naam}`);
        if (!zwitsersVooruit(r, eerst, eerst + 1, partijen)) {
            console.log(`eerst vooruit indelen: ${r[eerst].naam} is ook mislukt!`);
            if (!zwitsersAchteruit(r, eerst, eerst - 1, partijen)) {
                console.log(`eerst achteruit indelen: ${r[eerst].naam} is ook mislukt!`);
                return false;
            }
        }
    }
    const mislukt = [];
    let volgendeGroep = 0;
    while (volgendeGroep < r.length) {
        const van = volgendeGroep;
        const tot = puntenGroep(r, van);
        volgendeGroep = tot + 1;
        const helftGroep = van + Math.floor((volgendeGroep - van) / 2);
        let wisselKleur = 1; // indien geen kleurVoorkeur begin met 1 = zwart, 0 = wit
        for (let i = van; i <= tot; i++) {
            if (!reedsIngedeeld(r, i, partijen)) {
                console.log(`indelen: ${r[i].naam}`);
                if (!zwitsersVooruitIndelen(r, i, wisselKleur, helftGroep, partijen)) {
                    console.log(`vooruit indelen: ${r[i].naam} is mislukt!`);
                    mislukt.push(i);
                }
                wisselKleur = wisselKleur ? 0 : 1;
            }
        }
    }
    for (const speler of mislukt) {
        if (!pogingen.includes(speler)) {
            pogingen.push(speler);
            partijen = zwitsersIndelen(r, pogingen, speler);
            if (partijen) {
                break;
            }
        }
    }
    return partijen;
}

/**
 * maak puntenGroep (= A.3 Scoregroup) in ranglijst van tot
 *
 * @param r ranglijst
 * @param van in ranglijst
 * @returns {number} tot in ranglijst
 */
function puntenGroep(r, van) {
    const einde = r.length - 1;
    if (van >= einde) {
        console.log(`geen nieuwe puntenGroep tot: ${einde}`);
        return einde;
    }
    let tot = van;
    for (let i = 0; i < r.length; i++) {
        if (r[van].totaal() === r[i].totaal()) {
            tot = i;
        }
    }
    const helft = Math.floor((tot + 1 - van) / 2);
    console.log(`helft: ${helft} *****`);
    if (helft > 0) {
        return tot;
    }
    console.log(`puntenGroep verlengen`);
    return puntenGroep(r, tot + 1);
}

/**
 * indien speler in partijen staat is speler reedsIngedeeld
 *
 * @param r ranglijst TODO uitsluitend voor print
 * @param speler in ranglijst
 * @param partijen na indelen
 * @returns {boolean} indien reedsIngedeeld
 */
function reedsIngedeeld(r, speler, partijen) {
    for (const p of partijen) {
        if (p.includes(speler)) {
            console.log(`${r[speler].naam} reeds ingedeeld`);
            return true;
        }
    }
    return false;
}

/**
 * zwitsersVoooruitIndelen probeert speler in te delen met tegenstander lager op de ranglijst
 *
 * @param r ranglijst
 * @param speler in ranglijst
 * @param wisselKleur indien geen voorkeur 1 = zwart, 0 = wit
 * @param tegenstander in ranglijst
 * @param partijen na indelen
 * @returns {boolean} indien speler is ingedeeld
 */
function zwitsersVooruitIndelen(r, speler, wisselKleur, tegenstander, partijen) {
    for (let i = tegenstander; i < r.length; i++) {
        if (!reedsIngedeeld(r, i, partijen)) {
            console.log(`${r[speler].naam} tegen ${r[i].naam} ? ${r[speler].tegen(i)} en ${juisteKleurVoorkeur(r[speler], r[i])} kleur: ${metWit(r[speler], r[i], wisselKleur)}`);
        }
        if (!reedsIngedeeld(r, i, partijen) && r[speler].tegen(i) && juisteKleurVoorkeur(r[speler], r[i])) {
            if (metWit(r[speler], r[i], wisselKleur)) {
                partijen.push([i, speler]);
            } else {
                partijen.push([speler, i]);
            }
            return true;
        }
    }
    return false;
}

function zwitsersVooruit(r, speler, tegenstander, partijen) {
    for (let i = tegenstander; i < r.length; i++) {
        if (!i === speler && !reedsIngedeeld(r, i, partijen) && !r[speler].tegen(i)) {
            if (metWit(r[speler], r[i], metZwart(r[speler], r[i]))) {
                partijen.push([i, speler]);
            } else {
                partijen.push([speler, i]);
            }
            return true;
        }
    }
    return false;
}

function zwitsersAchteruit(r, speler, tegenstander, partijen) {
    for (let i = tegenstander; i >= 0; i--) {
        if (!i === speler && !reedsIngedeeld(r, i, partijen) && !r[speler].tegen(i)) {
            if (metWit(r[speler], r[i], metZwart(r[speler], r[i]))) {
                partijen.push([i, speler]);
            } else {
                partijen.push([speler, i]);
            }
            return true;
        }
    }
    return false;
}

/**
 * juistKleurVoorkeur zorgt voor Absolute Criteria C.3
 * speler en tegenstander mogen niet dezelfde voorkeur hebben voor een kleur
 *
 * @param speler
 * @param tegenstander
 * @returns {boolean} indien juisteKleurVoorkeur
 */
function juisteKleurVoorkeur(speler, tegenstander) {
    if (speler.saldoWitZwart() > 0) { // speler heeft voorkeur voor wit
        return tegenstander.saldoWitZwart() <= 0;
    } else if (speler.saldoWitZwart() < 0) { // speler heeft voorkeur voor zwart
        return tegenstander.saldoWitZwart() >= 0;
    } else {
        return true // speler heeft geen voorkeur
    }
}

/**
 * metWit berekent welke kleur speler heeft tegen tegenstander
 *
 * @param speler
 * @param tegenstander
 * @param wisselKleur indien spelers geen voorkeur hebben
 * @returns {number|*} indien wit anders zwart
 */
function metWit(speler, tegenstander, wisselKleur) {
    if (speler.saldoWitZwart() < 0 || tegenstander.saldoWitZwart() > 0) { // speler heeft voorkeur voor wit of tegenstander heeft voorkeur voor zwart
        return 0;
    } else if (speler.saldoWitZwart() > 0 || tegenstander.saldoWitZwart() < 0) { // speler heeft voorkeur voor zwart of tegenstander heeft voorkeur voor zwart
        return 1;
    } else {
        return wisselKleur; // spelers hebben geen voorkeur
    }
}

function metZwart(speler, tegenstander) {
    if (speler > tegenstander) { // sterkste speler heeft voorkeur voor zwart
        return 1;
    } else {
        return 0; // zwakste speler heeft voorkeur voor wit
    }
}

