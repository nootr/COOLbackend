"use strict";

/*
const
- webPage
- api
- params
- schaakVereniging
- seizoen

doorgeven:
- schaakVereniging
- seizoen
 */

const pagina = new URL(location);
const api = pagina.host.match("localhost") ? "http://localhost:3000" : "https://0-0-0.nl";
const params = pagina.searchParams;
const schaakVereniging = doorgeven("schaakVereniging");
const seizoen = doorgeven("seizoen");

const INTERNE_COMPETITIE = "int";
const SCHEIDING = " ";

function doorgeven(key) {
    let value = params.get(key);
    if (value) {
        sessionStorage.setItem(key, value);
    } else {
        value = sessionStorage.getItem(key);
    }
    return value;
}

async function mapAsync(url, mapFun) {
    let object = await localFetch(url);
    object.map(mapFun);
}

async function localFetch(url) {
    let object = JSON.parse(sessionStorage.getItem(url));
    if (!object) {
        object = await serverFetch(url);
        sessionStorage.setItem(url, JSON.stringify(object));
    }
    return await object;
}

async function serverFetch(url) {
    try {
        let response = await fetch(api + url);
        return await response.json();
    } catch (e) {
        console.error(e);
    }
}

function element(tag, text) {
    let el = document.createElement(tag);
    el.innerHTML = text;
    return el;
}

function option(value, text) {
    let option = document.createElement("option");
    option.value = value;
    option.text = text;
    return option;
}

function rij(...kolommen) {
    let tr = document.createElement("tr");
    kolommen.map(kolom => {
        let td = document.createElement("td");
        if (kolom.nodeType === Node.ELEMENT_NODE) {
            td.appendChild(kolom);
        } else {
            td.innerHTML = kolom;
        }
        tr.appendChild(td);
    });
    return tr;
}

function href(text, link) {
    let a = document.createElement("a");
    a.appendChild(document.createTextNode(text));
    a.href = link;
    return a;
}

function naarSpeler(knsbNummer, naam) {
    return href(naam,`speler.html?speler=${knsbNummer}&naam=${naam}`);
}

function naarRonde(tekst, rondeNummer, datum) {
    return href(tekst,`ronde.html?ronde=${rondeNummer}&datum=${datum}`);
}

function naarTeam(u) {
    return href(wedstrijdVoluit(u),`team.html?team=${u.teamCode}#ronde${u.rondeNummer}`);
}

function naarZelfdePagina() {
    location.replace(pagina.pathname);
}

function naarAnderePagina(naarPagina) {
    location.replace(pagina.pathname.replace(/\w+.html/, naarPagina));
}

function datumLeesbaar(datumJson) {
    const d = new Date(datumJson);
    return `${voorloopNul(d.getDate())}-${voorloopNul(d.getMonth()+1)}-${d.getFullYear()}`;
}

function voorloopNul(getal) {
    return getal < 10 ? "0" + getal : getal;
}

function seizoenVoluit(seizoen) {
    return "20" + seizoen.substring(0,2) + "-20" +  seizoen.substring(2,4);
}

function teamVoluit(teamCode) {
    if (teamCode === INTERNE_COMPETITIE) {
        return "interne competitie";
    } else if (teamCode === "kbe") {
        return schaakVereniging + " bekerteam";
    } else if (teamCode === "nbe") {
        return schaakVereniging + " nhsb bekerteam";
    } else {
        return wedstrijdTeam(teamCode)
    }
}

function wedstrijdTeam(teamCode) {
    return schaakVereniging + (teamCode.substring(1) === "be" ? " " : " " + teamCode);
}

function wedstrijdVoluit(r) {
    let eigenTeam = wedstrijdTeam(r.teamCode);
    return r.uithuis === "t" ? eigenTeam + " -  " + r.tegenstander : r.tegenstander + " - " + eigenTeam;
}

async function seizoenen(seizoenSelecteren, teamCode) {
    await mapAsync("/seizoenen/" + teamCode,
        (team) => {
            seizoenSelecteren.appendChild(option(team.seizoen, seizoenVoluit(team.seizoen)));
        });
    seizoenSelecteren.value = seizoen; // werkt uitsluitend na await
    seizoenSelecteren.addEventListener("input",
        () => {
            sessionStorage.setItem("seizoen", seizoenSelecteren.value);
            naarZelfdePagina();
        });
}

async function teams(teamSelecteren, teamCode) {
    await mapAsync("/teams/" + seizoen,
        (team) => {
            teamSelecteren.appendChild(option(team.teamCode, teamVoluit(team.teamCode)));
        });
    teamSelecteren.value = teamCode; // werkt uitsluitend na await
    teamSelecteren.addEventListener("input",
        () => {
            if (teamSelecteren.value === INTERNE_COMPETITIE) {
                naarAnderePagina("ranglijst.html");
            } else {
                naarAnderePagina("team.html?team=" + teamSelecteren.value);
            }
        });
}

async function ronden(rondeSelecteren, teamCode) {
    await mapAsync("/ronden/" + seizoen + "/" + teamCode,
        (ronde) => {
            rondeSelecteren.appendChild(option(ronde.rondeNummer, datumLeesbaar(ronde.datum) + SCHEIDING + "ronde " + ronde.rondeNummer));
        });
    rondeSelecteren.value = rondeNummer; // werkt uitsluitend na await
    rondeSelecteren.addEventListener("input",
        () => {
            sessionStorage.setItem("ronde", rondeSelecteren.value);
            naarZelfdePagina();
        });
}

async function wedstrijden(wedstrijdenSelecteren) {
    await mapAsync("/wedstrijden/" + seizoen,
        (r) => {
            wedstrijdenSelecteren.appendChild(option(r.teamCode + ":" + r.rondeNummer, datumLeesbaar(r.datum) + SCHEIDING + wedstrijdVoluit(r)));
        });
    wedstrijdenSelecteren.appendChild(option(0,wedstrijdenSelecteren.length + " externe wedstrijden"))
    wedstrijdenSelecteren.value = 0; // werkt uitsluitend na await
    wedstrijdenSelecteren.addEventListener("input",
        () => {
            console.log("wedstrijdenSelecteren: " + wedstrijdenSelecteren.value);
        });
}

function ranglijst(kop, lijst) {
    kop.innerHTML = schaakVereniging + SCHEIDING + seizoenVoluit(seizoen);
    mapAsync("/ranglijst/" + seizoen,
        (speler, i) => {
            lijst.appendChild(rij(
                i + 1,
                naarSpeler(speler.knsbNummer,speler.naam),
                speler.totaal));
        });
}

/*
  -- uitslagen interne competitie per ronde
  select
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
function uitslagenRonde(kop, lijst) {
    kop.innerHTML = schaakVereniging + SCHEIDING + seizoenVoluit(seizoen) + SCHEIDING + "ronde "+ rondeNummer;
    mapAsync("/ronde/" + seizoen + "/" + rondeNummer,
        (uitslag) => {
            lijst.appendChild(rij(
                naarSpeler(uitslag.knsbNummer, uitslag.wit),
                naarSpeler(uitslag.tegenstanderNummer, uitslag.zwart),
                uitslag.resultaat === "1" ? "1-0" : uitslag.resultaat === "0" ? "0-1" : "½-½"));
        });
}

/*
 Fetch JSON uitslagen en verwerk die met uitslagRij tot rijen voor de uitslagen tabel.
 */

function uitslagenSpeler(kop, lijst) {
    kop.innerHTML = schaakVereniging + SCHEIDING + seizoenVoluit(seizoen) + SCHEIDING + naam;
    let totaal = 300; // TODO uit de MySQL database
    mapAsync("/uitslagen/" + seizoen + "/" + speler,
        (uitslag) => {
            totaal = totaal + uitslag.punten;
            lijst.appendChild(uitslagRij(uitslag, totaal));
        });
}

/*
Verwerk een JSON uitslag tot een rij van 8 kolommen.

  -- punten van alle uitslagen per speler
  select u.datum,
      u.rondeNummer,
      u.bordNummer,
      u.witZwart,
      u.tegenstanderNummer,
      p.naam,
      u.resultaat,
      u.teamCode,
      r.compleet,
      r.uithuis,
      r.tegenstander,
      punten(@seizoen, @knsbNummer, u.teamCode, u.tegenstanderNummer, u.resultaat) as punten
  from uitslag u
  join persoon p on u.tegenstanderNummer = p.knsbNummer
  join ronde r on u.seizoen = r.seizoen and u.teamCode = r.teamCode and u.rondeNummer = r.rondeNummer
  where u.seizoen = @seizoen
      and u.knsbNummer = @knsbNummer
      and u.anderTeam = 'int'
  order by u.datum, u.bordNummer;

1. link naar interne ronde
2. datum
3. link naar interne tegenstander, link naar externe wedstrijd of andere tekst
4. externe bord
5. kleur
6. resultaat
7. punten
8. voortschrijdend totaal

@param u JSON uitslag
@param totaal punten
 */

const TIJDELIJK_LID_NUMMER = 100;

function uitslagRij(u, totaal) {
    let datum = datumLeesbaar(u.datum);
    let rondeKolom = naarRonde(u.rondeNummer, u.rondeNummer, datum);
    let datumKolom = naarRonde(datum, u.rondeNummer, datum);
    if (u.tegenstanderNummer > TIJDELIJK_LID_NUMMER) {
        return rij(rondeKolom, datumKolom, naarSpeler(u.tegenstanderNummer, u.naam), "", u.witZwart, u.resultaat, u.punten, totaal);
    } else if (u.teamCode === INTERNE_COMPETITIE) {
        return rij(rondeKolom, datumKolom, u.naam, "", "", "", u.punten, totaal);
    } else {
        return rij("", datum, naarTeam(u), u.bordNummer, u.witZwart, u.resultaat, u.punten, totaal);
    }
}

/*

-- uitslagen externe competitie per team
select uitslag.rondeNummer,
    uitslag.bordNummer,
    uitslag.witZwart,
    uitslag.resultaat,
    uitslag.knsbNummer,
    persoon.naam,
from uitslag
join persoon on uitslag.knsbNummer = persoon.knsbNummer
where uitslag.seizoen = @seizoen and uitslag.teamCode = @teamCode
order by uitslag.seizoen, uitslag.rondeNummer, uitslag.bordNummer;
 */

/**
 * uitslagenTeam doet fetch van JSON ronden en uitslagen per team
 * en verwerkt die tot een tabel met ronden en een aantal tabellen met uitslagen per ronde.
 *
 * @param kop
 * @param ronden
 * @param uitslagenTemplate
 * @returns {Promise<void>}
 */

async function uitslagenTeam(kop, ronden, uitslagenTemplate) {
    kop.innerHTML = schaakVereniging + SCHEIDING + seizoenVoluit(seizoen) + SCHEIDING + wedstrijdTeam(teamCode);
    let rondeUitslagen = [];
    await mapAsync("/ronden/" + seizoen + "/" + teamCode,
        (ronde) => {
            rondeUitslagen.push({ronde: ronde, punten: 0, uitslagen: []});
            // console.log("in /ronden/:seizoen/:teamCode " + ronde.tegenstander);
        });
    console.log("na /ronden/:seizoen/:teamCode");
    console.log(rondeUitslagen);
    await mapAsync("/team/" + seizoen + "/" + teamCode,
        (uitslag) => {
            // console.log("ronde: " + uitslag.rondeNummer + " bordNummer: " + uitslag.bordNummer);
            let rondeUitslag = rondeUitslagen[uitslag.rondeNummer - 1];
            rondeUitslag.punten += uitslag.resultaat === "1" ? 1 : uitslag.resultaat === "0" ? 0 : 0.5;
            rondeUitslag.uitslagen.push(teamUitslagRij(uitslag));
        });
    console.log("na /team/:seizoen/:teamCode");
    console.log(rondeUitslagen);
    for (let i = 0; i < rondeUitslagen.length; ++i) {
        const div = document.getElementById("ronde" + (i + 1));
        div.appendChild(uitslagenTemplate.content.cloneNode(true));
        div.getElementsByTagName("h2")[0].innerHTML = "Ronde " + (i + 1);
        let tabel = div.getElementsByTagName("table")[0];
        for (let uitslag of rondeUitslagen[i].uitslagen) {
            tabel.appendChild(uitslag);
        }
    }
}

function teamUitslagRij(u) {
    return rij(u.bordNummer, naarSpeler(u.knsbNummer, u.naam), u.witZwart, u.resultaat);
}
