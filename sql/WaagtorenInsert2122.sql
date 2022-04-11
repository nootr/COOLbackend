use waagtoren; -- ga naar PvD

-- TODO ranglijst Rapid
set @competitie = 'ira';
set @ronde = 4;

select naam, u.* from uitslag u join persoon p on p.knsbNummer = u.knsbNummer
where seizoen = '2122' and teamCode = @competitie and rondeNummer = @ronde order by bordNummer, witZwart;  -- and u.knsbNummer in (@wit, @zwart);



-- TODO partij wijzigen

set @competitie = 'int';
set @ronde = 17;
set @bord = 12;
set @wit = 7691728; -- Karel Beentjes
set @zwart = 103; -- Charles Stoorvogel
set @bord = 13;
set @wit = 8472530; -- Rosa Leek
set @zwart = 122; -- Olia Lutsiv

select naam, u.* from uitslag u join persoon p on p.knsbNummer = u.knsbNummer
where seizoen = '2122' and teamCode = @competitie and rondeNummer = @ronde and partij = 'i' order by bordNummer, witZwart;  -- and u.knsbNummer in (@wit, @zwart);

select naam, u.* from uitslag u join persoon p on p.knsbNummer = u.knsbNummer
where seizoen = '2122' and teamCode = @competitie and rondeNummer = @ronde and u.knsbNummer in (@wit, @zwart);

update uitslag set bordNummer = @bord, partij = 'i', witZwart = 'w', tegenstanderNummer = @zwart, resultaat = ''
where seizoen = '2122' and teamCode = @competitie and rondeNummer = @ronde and knsbNummer = @wit;
update uitslag set bordNummer = @bord, partij = 'i', witZwart = 'z', tegenstanderNummer = @wit, resultaat = ''
where seizoen = '2122' and teamCode = @competitie and rondeNummer = @ronde and knsbNummer = @zwart;

-- TODO partij wijzigen

set @competitie = 'ira';
set @ronde = 4;
set @bord = 5;
set @wit = 7613166; -- Peter Kalisvaart
set @zwart = 6192098; -- Nico Brugman
set @bord = 6;
set @wit = 8112654; -- Ton Fasel
set @zwart = 7970094; -- Danny de Ruiter
set @bord = 7;
set @wit = 7518203; -- Theo de Bruijn
set @zwart = 7292043; -- Rob Freer
set @bord = 8;
set @wit = 101; -- Ramon Witte
set @zwart = 7269834; -- Arie Boots
set @bord = 9;
set @wit = 7529522; -- Willem Meyles
set @zwart = 7399469; -- Nico Mak

select naam, u.* from uitslag u join persoon p on p.knsbNummer = u.knsbNummer
where seizoen = '2122' and teamCode = @competitie and rondeNummer = @ronde and partij = 'i' order by bordNummer, witZwart;  -- and u.knsbNummer in (@wit, @zwart);
select naam, u.* from uitslag u join persoon p on p.knsbNummer = u.knsbNummer
where seizoen = '2122' and teamCode = @competitie and rondeNummer = @ronde and partij <> 'i' order by bordNummer, witZwart;  -- and u.knsbNummer in (@wit, @zwart);

select naam, u.* from uitslag u join persoon p on p.knsbNummer = u.knsbNummer
where seizoen = '2122' and teamCode = @competitie and rondeNummer = @ronde and u.knsbNummer in (@wit, @zwart);

update uitslag set bordNummer = @bord, partij = 'i', witZwart = 'w', tegenstanderNummer = @zwart, resultaat = ''
where seizoen = '2122' and teamCode = @competitie and rondeNummer = @ronde and knsbNummer = @wit;
update uitslag set bordNummer = @bord, partij = 'i', witZwart = 'z', tegenstanderNummer = @wit, resultaat = ''
where seizoen = '2122' and teamCode = @competitie and rondeNummer = @ronde and knsbNummer = @zwart;

-- TODO spelers selecteren
select naam, s.knsbNummer, knsbRating, knsbOpgegeven, nhsbOpgegeven 
from speler s join persoon p on p.knsbNummer = s.knsbNummer 
where seizoen = '2122' order by naam; -- knsbRating desc; 

-- TODO wedstrijd tijdens interne competitie
set @team = 'n1'; -- Waagtoren n1 - Kijk Uit n1
set @ronde = 7;
set @intern = 19;
set @uithuis = 't';

set @team = 'n4'; -- Waagtoren n4 - Heerhugowaard n1
set @ronde = 2;
set @intern = 20;
set @uithuis = 't';

select * from ronde
where seizoen = '2122' and teamCode = @team and rondeNummer = @ronde;

select * from uitslag
where seizoen = '2122' and teamCode = @team and rondeNummer = @ronde;

delete from uitslag
where seizoen = '2122' and teamCode = @team and rondeNummer = @ronde and partij in ('m', 'n'); -- oude agenda items

select naam, u.* from uitslag u join persoon p on p.knsbNummer = u.knsbNummer
where seizoen = '2122' and ((teamCode = 'int' and rondeNummer = @intern) or (teamCode = @team and rondeNummer = @ronde))
and u.knsbNummer in (7970094, 7428960, 7099950, 7099620, 7129991, 7707832, 6225934, 7535385) order by naam; -- Waagtoren n1 - Kijk Uit n1

update uitslag set partij = @uithuis
where seizoen = '2122' and ((teamCode = 'int' and rondeNummer = @intern) or (teamCode = @team and rondeNummer = @ronde))
and knsbNummer in (7970094, 7428960, 7099950, 7099620, 7129991, 7707832, 6225934, 7535385); -- Waagtoren n1 - Kijk Uit n1

insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', @team, @ronde, 0, 7535385, @uithuis, '', 0, '', '2022-04-12', 'int'); -- Marten Coerts (Waagtoren n1 - Kijk Uit n1)

select naam, u.* from uitslag u join persoon p on p.knsbNummer = u.knsbNummer
where seizoen = '2122' and ((teamCode = 'int' and rondeNummer = @intern) or (teamCode = @team and rondeNummer = @ronde))
and u.knsbNummer in (8750093, 7399469, 6212404, 7321534, 8472530, 7518203) order by naam; -- Waagtoren n4 - Heerhugowaard n1

update uitslag set partij = @uithuis
where seizoen = '2122' and ((teamCode = 'int' and rondeNummer = @intern) or (teamCode = @team and rondeNummer = @ronde))
and knsbNummer in (8750093, 7399469, 6212404, 7321534, 8472530, 7518203); -- Waagtoren n4 - Heerhugowaard n1

insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', @team, @ronde, 0, 8750093, @uithuis, '', 0, '', '2022-04-19', 'int'), -- Martin Rep (Waagtoren n4 - Heerhugowaard n1)
('2122', @team, @ronde, 0, 7399469, @uithuis, '', 0, '', '2022-04-19', 'int'), -- Nico Mak
('2122', @team, @ronde, 0, 7321534, @uithuis, '', 0, '', '2022-04-19', 'int'), -- Ronald Kamps
('2122', @team, @ronde, 0, 8472530, @uithuis, '', 0, '', '2022-04-19', 'int'), -- Rosa Leek
('2122', @team, @ronde, 0, 7518203, @uithuis, '', 0, '', '2022-04-19', 'int'); -- Theo de Bruijn


insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'n4', 6, 0, 8750093, 't', '', 0, '', '2022-03-22', 'int'), -- Martin Rep
('2122', 'n4', 6, 0, 6212404, 't', '', 0, '', '2022-03-22', 'int'), -- PvD
('2122', 'n4', 6, 0, 7518203, 't', '', 0, '', '2022-03-22', 'int'), -- Theo de Bruijn
('2122', 'n4', 6, 0, 7321534, 't', '', 0, '', '2022-03-22', 'int'), -- Ronald Kamps
('2122', 'n4', 6, 0, 8073978, 't', '', 0, '', '2022-03-22', 'int'), -- Gerrit Peereboom
('2122', 'n4', 6, 0, 7691728, 't', '', 0, '', '2022-03-22', 'int'); -- Karel Beentjes

-- TODO speler toevoegen 
insert into persoon (knsbNummer, naam) values
(7771665, 'Yvonne Schol');

insert into speler (seizoen, nhsbTeam, nhsbOpgegeven, knsbTeam, knsbOpgegeven, knsbNummer, knsbRating, datumRating) values
('2122', '', '', '', '', 7771665, 1264, '2022-04-10');

-- TODO wedstrijden en ronden voor vandaag opruimen
set @datum = '2022-03-19';
select * from uitslag where datum < @datum and partij in ('m', 'n', 'u', 't') order by datum;

delete from uitslag where seizoen = '2122' and datum < @datum and partij in ('m', 'n', 'u', 't');

delete from uitslag where seizoen = '21ra' and datum < '2022-03-12' and partij in ('m', 'n', 'u', 't');

-- TODO partij = 'e' voor externe wedstrijd op dinsdag
select * from uitslag i
where seizoen = '2122' and teamCode = 'int' and rondeNummer = 13 and knsbNummer in 
(select knsbNummer from uitslag where seizoen = '2122' and teamCode <> 'int' and datum = i.datum) 
order by partij; 

update uitslag set partij = 'e' 
where seizoen = '2122' and teamCode = 'int' and rondeNummer = 13 and knsbNummer in (7707832, 8112654, 7970094, 7879520, 6225934, 6483455, 7129991, 7428960); 

-- deze werkt niet!
update uitslag i set partij = 'e'
where seizoen = '2122' and teamCode = 'int' and rondeNummer = 13 and knsbNummer in 
(select knsbNummer from uitslag where seizoen = '2122' and teamCode <> 'int' and datum = i.datum); 

delete from uitslag where seizoen = '2122' and datum < '2022-03-01' and partij in ('m', 'n', 'u', 't');

insert into speler (seizoen, nhsbTeam, nhsbOpgegeven, knsbTeam, knsbOpgegeven, knsbNummer, knsbRating, datumRating) values -- TODO teams invullen
('2122', '', '', '', '', 101, 1000, '2021-08-06'),
('2122', '', '', '', '', 102, 1000, '2021-08-06'),
('2122', '', '', '', '', 103, 1000, '2021-08-06'),
('2122', '', '', '', '', 105, 1000, '2021-08-06'),
('2122', '', '', '', '', 106, 1000, '2021-08-06'),
('2122', '', '', '', '', 107, 1000, '2021-08-06'),
('2122', '', '', '', '', 109, 1000, '2021-08-06'),
('2122', '', '', '', '', 110, 1000, '2021-08-06'),
('2122', '', '', '', '', 111, 1000, '2021-08-19'),
('2122', '', '', '', '', 112, 1000, '2021-08-19'),
('2122', '', '', '', '', 113, 1250, '2021-09-04'),
('2122', '', '', '', '', 114, 1750, '2021-10-20'),
('2122', '', '', '', '', 115, 1000, '2021-09-14'),
('2122', '', '', '', '', 116, 1000, '2021-09-14'),
('2122', '', '', '', '', 117, 1550, '2021-10-10'),
('2122', '', '', '', '', 118, 1000, '2021-11-09'),
('2122', '', '', '', '', 119, 1000, '2022-02-27'),
('2122', '', '', '', '', 120, 1000, '2022-03-01'),
('2122', '', '', '', '', 121, 1000, '2022-03-28'),
('2122', '', '', '', '', 122, 1000, '2022-03-29'), -- PvD
('2122', '', '', '', '', 7771665, 1264, '2022-04-10')
('2122', '', '', '', '', 7584566, 2333, '2021-08-01'),
('2122', '', '', '', '', 7657342, 2299, '2021-08-01'),
('2122', '', '', '', '', 7970094, 2271, '2021-08-01'),
('2122', '', '', '', '', 8180810, 2243, '2021-08-01'),
('2122', '', '', '', '', 7079743, 2240, '2021-08-01'),
('2122', '', '', '', '', 7428960, 2211, '2021-08-01'),
('2122', '', '', '', '', 8285574, 2171, '2021-08-01'),
('2122', '', '', '', '', 7561653, 2136, '2021-08-01'),
('2122', '', '', '', '', 6335670, 2130, '2021-08-01'),
('2122', '', '', '', '', 8096242, 2126, '2021-08-01'),
('2122', '', '', '', '', 7828183, 2107, '2021-08-01'),
('2122', '', '', '', '', 6483455, 2103, '2021-08-01'),
('2122', '', '', '', '', 7099950, 2079, '2021-08-01'),
('2122', '', '', '', '', 7468417, 2021, '2021-08-01'),
('2122', '', '', '', '', 7129991, 2020, '2021-08-01'),
('2122', '', '', '', '', 7099620, 1996, '2021-08-01'),
('2122', '', '', '', '', 7879520, 1985, '2021-08-01'),
('2122', '', '', '', '', 7509920, 1960, '2021-08-01'),
('2122', '', '', '', '', 7707832, 1950, '2021-08-01'),
('2122', '', '', '', '', 6225934, 1943, '2021-08-01'),
('2122', '', '', '', '', 7665834, 1939, '2021-08-01'),
('2122', '', '', '', '', 6572511, 1907, '2021-08-01'),
('2122', '', '', '', '', 7063881, 1903, '2021-08-01'),
('2122', '', '', '', '', 7739314, 1902, '2021-08-01'),
('2122', '', '', '', '', 8112654, 1890, '2021-08-01'),
('2122', '', '', '', '', 7529522, 1889, '2021-08-01'),
('2122', '', '', '', '', 6930957, 1883, '2021-08-01'),
('2122', '', '', '', '', 7535396, 1882, '2021-08-01'),
('2122', '', '', '', '', 7535385, 1877, '2021-08-01'),
('2122', '', '', '', '', 8552038, 1872, '2021-08-01'),
('2122', '', '', '', '', 7544438, 1871, '2021-08-01'),
('2122', '', '', '', '', 7292043, 1860, '2021-08-01'),
('2122', '', '', '', '', 7640798, 1860, '2021-08-01'),
('2122', '', '', '', '', 7824674, 1845, '2021-08-01'),
('2122', '', '', '', '', 7758014, 1829, '2021-08-01'),
('2122', '', '', '', '', 7468362, 1819, '2021-08-01'),
('2122', '', '', '', '', 6951362, 1815, '2021-08-01'),
('2122', '', '', '', '', 7699010, 1807, '2021-08-01'),
('2122', '', '', '', '', 7504310, 1806, '2021-08-01'),
('2122', '', '', '', '', 7809285, 1794, '2021-08-01'),
('2122', '', '', '', '', 7904589, 1792, '2021-08-01'),
('2122', '', '', '', '', 8611922, 1790, '2021-08-01'),
('2122', '', '', '', '', 8372881, 1768, '2021-08-01'),
('2122', '', '', '', '', 6214153, 1754, '2021-08-01'),
('2122', '', '', '', '', 8484443, 1754, '2021-08-01'),
('2122', '', '', '', '', 7282033, 1736, '2021-08-01'),
('2122', '', '', '', '', 7707084, 1721, '2021-08-01'),
('2122', '', '', '', '', 7502143, 1719, '2021-08-01'),
('2122', '', '', '', '', 8291877, 1708, '2021-08-01'),
('2122', '', '', '', '', 7210137, 1701, '2021-08-01'),
('2122', '', '', '', '', 7731812, 1700, '2021-08-01'),
('2122', '', '', '', '', 8276752, 1697, '2021-08-01'),
('2122', '', '', '', '', 7649213, 1691, '2021-08-01'),
('2122', '', '', '', '', 8587337, 1688, '2021-08-01'),
('2122', '', '', '', '', 7399469, 1671, '2021-08-01'),
('2122', '', '', '', '', 7419621, 1670, '2021-08-01'),
('2122', '', '', '', '', 8750093, 1664, '2021-08-01'),
('2122', '', '', '', '', 8571453, 1656, '2021-08-01'),
('2122', '', '', '', '', 6212404, 1652, '2021-08-01'),
('2122', '', '', '', '', 8485059, 1611, '2021-08-01'),
('2122', '', '', '', '', 8400183, 1597, '2021-08-01'),
('2122', '', '', '', '', 8224502, 1579, '2021-08-01'),
('2122', '', '', '', '', 7269834, 1573, '2021-08-01'),
('2122', '', '', '', '', 8182416, 1560, '2021-08-01'),
('2122', '', '', '', '', 7518203, 1551, '2021-08-01'),
('2122', '', '', '', '', 8305473, 1542, '2021-08-01'),
('2122', '', '', '', '', 7321534, 1540, '2021-08-01'),
('2122', '', '', '', '', 8314834, 1516, '2021-08-01'),
('2122', '', '', '', '', 8073978, 1509, '2021-08-01'),
('2122', '', '', '', '', 7227264, 1499, '2021-08-01'),
('2122', '', '', '', '', 8617367, 1487, '2021-08-01'),
('2122', '', '', '', '', 6192098, 1481, '2021-08-01'),
('2122', '', '', '', '', 8193548, 1460, '2021-08-01'),
('2122', '', '', '', '', 7691728, 1425, '2021-08-01'),
('2122', '', '', '', '', 8587348, 1422, '2021-08-01'),
('2122', '', '', '', '', 8472530, 1386, '2021-08-01'),
('2122', '', '', '', '', 8144191, 1376, '2021-08-01'),
('2122', '', '', '', '', 6187885, 1374, '2021-08-01'),
('2122', '', '', '', '', 7582102, 1281, '2021-08-01'),
('2122', '', '', '', '', 8335415, 1229, '2021-08-01'),
('2122', '', '', '', '', 8580374, 1223, '2021-08-01'),
('2122', '', '', '', '', 8580385, 1212, '2021-08-01'),
('2122', '', '', '', '', 8865549, 1000, '2021-08-01'),
('2122', '', '', '', '', 8931098, 1000, '2021-08-01');

-- knsb teams artikel 13.2
select naam, s.knsbNummer, knsbTeam, knsbOpgegeven from speler s join persoon p on s.knsbNummer = p.knsbNummer where seizoen = '2122' order by knsbRating desc;

update speler set knsbTeam = '1', knsbOpgegeven = '1' where seizoen = '2122' and knsbNummer in 
(7584566, 7657342, 8180810, 7079743, 7428960, 8285574, 7561653, 8096242, 7828183, 7468417);
update speler set knsbTeam = '2', knsbOpgegeven = '2' where seizoen = '2122' and knsbNummer in 
(6335670, 6483455, 7099950, 7129991, 7099620, 7879520, 7509920, 7707832); -- 6225934, 7665834
update speler set knsbTeam = '3', knsbOpgegeven = '3' where seizoen = '2122' and knsbNummer in 
(6572511, 7535385, 7758014, 7699010, 7504310, 8611922, 8484443, 8587337);
update speler set knsbTeam = '3' where seizoen = '2122' and knsbNummer in (
6225934,  -- Ruud Adema
7665834); -- David Baanstra
update speler set knsbTeam = '4', knsbOpgegeven = '4' where seizoen = '2122' and knsbNummer in 
(7824674, 7809285, 7904589, 7282033, 8276752, 7649213, 8750093, 6212404);
update speler set knsbTeam = '4' where seizoen = '2122' and knsbNummer in (
8112654, -- Ton Fasel             1890
7529522, -- Willem Meyles         1889
6930957, -- Leo van Steenoven     1883
7535396, -- John Leek             1882
8552038, -- Kevin Brands          1872
7292043, -- Rob Freer             1860
6951362, -- Johan Plooijer        1815
8291877, -- Jawdat Adib           1708
7210137, -- Arjen Dibbets         1701
7399469, -- Nico Mak              1671
7419621, -- Frits Leenart         1670
8485059, -- Peter Duijs           1611
8400183, -- Daan de Vetten        1597
8224502, -- Jan van Gijsen        1579
7269834, -- Arie Boots            1573
7518203, -- Theo de Bruijn        1551
    114, -- Bram Vink             1550
8073978, -- Gerrit Peereboom      1509
8617367, -- Arend Noordam         1487
6192098, -- Nico Brugman          1481
8193548, -- Daan de Vries         1460
7691728, -- Karel Beentjes        1425
8587348, -- Merijn Hooijmans      1422
8472530  -- Rosa Leek             1386
); 

-- nhsb teams artikel 20
select naam, s.knsbNummer, nhsbTeam, nhsbOpgegeven, knsbRating from speler s join persoon p on s.knsbNummer = p.knsbNummer where seizoen = '2122' order by knsbRating desc;

update speler set nhsbTeam = 'n1', nhsbOpgegeven = 'n1' where seizoen = '2122' and knsbNummer in 
(7970094, 7428960, 8096242, 7099950, 7129991, 7099620, 7707832, 6225934);
update speler set nhsbTeam = 'n1' where seizoen = '2122' and knsbNummer in ( 
7584566, -- Yong Hoon de Rover    2333
7657342, -- Frank van Tellingen   2299
8180810, -- Midas Ratsma          2243
7079743, -- Juan de Roda Husman   2240
8285574, -- Maaike Keetman        2171
7561653, -- Mariska de Mie        2136
6335670, -- Hebert Perez Garcia   2130
7828183, -- Rob Konijn            2107
6483455, -- Jeroen Smorenberg     2103
7468417  -- Daan Geerke           2021
);
update speler set nhsbTeam = 'n2', nhsbOpgegeven = 'n2' where seizoen = '2122' and knsbNummer in 
(7529522, 6930957, 7824674, 7758014, 8611922, 8484443, 8587337, 8400183);
update speler set nhsbTeam = 'n2' where seizoen = '2122' and knsbNummer in ( 
7879520, -- Vincent Pandelaar     1985
7509920, -- Dirk van der Meiden   1960
7665834, -- David Baanstra        1939
6572511, -- Bert Buitink          1907
8112654 -- Ton Fasel             1890
);
update speler set nhsbTeam = 'n3', nhsbOpgegeven = 'n3' where seizoen = '2122' and knsbNummer in 
(7468362, 7504310, 6214153, 7282033, 7210137, 7731812, 8276752, 7649213);
update speler set nhsbTeam = 'n3' where seizoen = '2122' and knsbNummer in ( 
7535396, -- John Leek             1882
7535385, -- Marten Coerts         1877
8552038, -- Kevin Brands          1872
7544438, -- Fred Driesse          1871
7292043, -- Rob Freer             1860
6951362, -- Johan Plooijer        1815
7699010, -- Ruud Niewenhuis       1807
7809285, -- Albert van der Meiden 1794
7904589, -- Wim Nieland           179
7757409, -- Gerrit Valk           1771
8372881 -- Egbert van Oene       1768
);
update speler set nhsbTeam = 'n4', nhsbOpgegeven = 'n4' where seizoen = '2122' and knsbNummer in 
(8750093, 6212404, 7321534, 7518203, 8073978, 7691728);
update speler set nhsbTeam = 'n4' where seizoen = '2122' and knsbNummer in ( 
    114, -- Bram Vink             1700
8291877, -- Jawdat Adib           1708
7399469, -- Nico Mak              1671
7419621, -- Frits Leenart         1670
8571453, -- Marit de Boer         1656
8485059, -- Peter Duijs           1611
8224502, -- Jan van Gijsen        1579
7269834, -- Arie Boots            1573
7518203, -- Theo de Bruijn        1551
    117, -- Kees van Kuipers      1550
8305473, -- Klaas Silver          1542
7321534, -- Ronald Kamps          1540
8073978, -- Gerrit Peereboom      1509
8617367, -- Arend Noordam         1487
6192098, -- Nico Brugman          1481
8193548, -- Daan de Vries         1460
7691728, -- Karel Beentjes        1425
8472530, -- Rosa Leek             1386
8144191, -- Gerard Brouwers       1376
6187885, -- Bob de Mon            1374
7582102, -- Onno Vellinga         1281
8335415, -- Koos de Graaf         1229
8580374, -- Jos Bakker            1223
8580385 -- Han Rauws             1212
);

insert into team (seizoen, teamCode, bond, poule, omschrijving, borden, teamleider) values
('2122', '', '', '', 'geen team', 0, 0),
('2122', '1', 'k', '1a', 'KNSB 1a', 10, 6214153),
('2122', '2', 'k', '3d', 'KNSB 3d', 8, 7129991),
('2122', '3', 'k', '4e', 'KNSB 4e', 8, 7758014),
('2122', '4', 'k', '6c', 'KNSB 6c', 8, 6212404),
('2122', 'n1', 'n', 't', 'NHSB top', 8, 7428960),
('2122', 'n2', 'n', '1a', 'NHSB 1a', 8, 7529522),
-- ('2122', 'n3', 'n', '2a', 'NHSB 2b', 8, 6214153),
('2122', 'n4', 'n', '3b', 'NHSB 3c', 6, 6212404),
('2122', 'int', 'i', 'nt', 'interne competitie', 0, 0),
('2122', 'ira', 'i', 'ra', 'rapid competitie', 0, 0);

insert into ronde (seizoen, teamCode, rondeNummer, uithuis, tegenstander, plaats, datum) values
('2122', 'ira', '1', 't', '', 'Alkmaar', '2021-10-19'),
('2122', 'ira', '2', 't', '', 'Alkmaar', '2021-10-19'),
('2122', 'ira', '3', 't', '', 'Alkmaar', '2021-10-19'),
('2122', 'ira', '4', 't', '', 'Alkmaar', '2022-02-22'),
('2122', 'ira', '5', 't', '', 'Alkmaar', '2022-02-22'),
('2122', 'ira', '6', 't', '', 'Alkmaar', '2022-02-22'),
('2122', 'ira', '7', 't', '', 'Alkmaar', '2022-05-03'),
('2122', 'ira', '8', 't', '', 'Alkmaar', '2022-05-03'),
('2122', 'ira', '9', 't', '', 'Alkmaar', '2022-05-03');

insert into ronde (seizoen, teamCode, rondeNummer, uithuis, tegenstander, plaats, datum) values
('2122', 'int', '1', 't', '', 'Alkmaar', '2021-09-07'),
('2122', 'int', '2', 't', '', 'Alkmaar', '2021-09-14'),
('2122', 'int', '3', 't', '', 'Alkmaar', '2021-09-21'),
('2122', 'int', '4', 't', '', 'Alkmaar', '2021-09-28'),
('2122', 'int', '5', 't', '', 'Alkmaar', '2021-10-05'),
('2122', 'int', '6', 't', '', 'Alkmaar', '2021-10-12'),
('2122', 'int', '7', 't', '', 'Alkmaar', '2021-10-26'),
('2122', 'int', '8', 't', '', 'Alkmaar', '2021-11-02'),
('2122', 'int', '9', 't', '', 'Alkmaar', '2021-11-09'),
('2122', 'int', '10', 't', '', 'Alkmaar', '2021-11-16'),
('2122', 'int', '11', 't', '', 'Alkmaar', '2021-11-23'),
('2122', 'int', '12', 't', '', 'Alkmaar', '2021-11-30'),
('2122', 'int', '13', 't', '', 'Alkmaar', '2021-12-07'),
('2122', 'int', '14', 't', '', 'Alkmaar', '2021-12-14'),
('2122', 'int', '15', 't', '', 'Alkmaar', '2022-01-04'),
('2122', 'int', '16', 't', '', 'Alkmaar', '2022-01-11'),
('2122', 'int', '17', 't', '', 'Alkmaar', '2022-01-18'),
('2122', 'int', '18', 't', '', 'Alkmaar', '2022-02-01'),
('2122', 'int', '19', 't', '', 'Alkmaar', '2022-02-08'),
('2122', 'int', '20', 't', '', 'Alkmaar', '2022-02-15'),
('2122', 'int', '21', 't', '', 'Alkmaar', '2022-03-01'),
('2122', 'int', '22', 't', '', 'Alkmaar', '2022-03-08'),
('2122', 'int', '23', 't', '', 'Alkmaar', '2022-03-15'),
('2122', 'int', '24', 't', '', 'Alkmaar', '2022-03-22'),
('2122', 'int', '25', 't', '', 'Alkmaar', '2022-03-29'),
('2122', 'int', '26', 't', '', 'Alkmaar', '2022-04-05'),
('2122', 'int', '27', 't', '', 'Alkmaar', '2022-04-12'),
('2122', 'int', '28', 't', '', 'Alkmaar', '2022-04-19'),
('2122', 'int', '29', 't', '', 'Alkmaar', '2022-04-26'),
('2122', 'int', '30', 't', '', 'Alkmaar', '2022-05-10'),
('2122', 'int', '31', 't', '', 'Alkmaar', '2022-05-17'),
('2122', 'int', '32', 't', '', 'Alkmaar', '2022-05-24'),
('2122', 'int', '33', 't', '', 'Alkmaar', '2022-05-31'),
('2122', '1', '1', 'u', 'Voorschoten 1', 'Voorschoten', '2021-09-18'),
('2122', '1', '2', 't', 'Philidor 1847 1', 'Alkmaar', '2021-10-09'),
('2122', '1', '3', 't', 'HWP Haarlem 1', 'Alkmaar', '2021-11-06'),
('2122', '1', '4', 'u', 'Wageningen 1', 'Wageningen', '2021-11-27'),
('2122', '1', '5', 't', 'Paul Keres 1', 'Alkmaar', '2022-05-21'),
('2122', '1', '6', 'u', 'Caissa-Eenhoorn 1', 'Hoorn', '2022-02-05'),
('2122', '1', '7', 't', 'Groninger Combinatie 2', 'Alkmaar', '2022-03-12'),
('2122', '1', '8', 'u', 'SG Max Euwe 1', 'Enschede', '2022-04-02'),
('2122', '1', '9', 't', 'Zukertort Amstelveen 1', 'Alkmaar', '2022-04-23'),
('2122', '2', '1', 'u', 'ZSC-Saende 1', 'Zaandam', '2021-09-18'),
('2122', '2', '2', 't', 'Laurierboom-Gambiet 1', 'Alkmaar', '2021-10-09'),
('2122', '2', '3', 't', 'HWP Haarlem 2', 'Alkmaar', '2021-11-06'),
('2122', '2', '4', 'u', 'ZSC-Saende 2', 'Zaandam', '2021-11-27'),
('2122', '2', '5', 't', 'De Wijker Toren 2', 'Alkmaar', '2022-05-21'),
('2122', '2', '6', 'u', 'Caissa-Eenhoorn 2', 'Hoorn', '2022-02-05'),
('2122', '2', '7', 't', 'Caissa 3', 'Alkmaar', '2022-03-12'),
('2122', '2', '8', 'u', 'Santpoort 1', 'Velserbroek', '2022-04-02'),
('2122', '2', '9', 't', 'Fischer Z 1', 'Alkmaar', '2022-04-23'),
('2122', '3', '1', 'u', 'Bergen 1', 'Bergen', '2021-09-18'),
('2122', '3', '2', 't', 'De Uil 1', 'Alkmaar', '2021-10-09'),
('2122', '3', '3', 't', 'HWP Haarlem 3', 'Alkmaar', '2021-11-06'),
('2122', '3', '4', 'u', 'Aartswoud 1', 'Hoogwoud', '2021-11-27'),
('2122', '3', '5', 't', 'Volendam 1', 'Alkmaar', '2022-05-21'),
('2122', '3', '6', 'u', 'Caissa-Eenhoorn 3', 'Zwaag', '2022-02-05'),
('2122', '3', '7', 't', 'Kennemer Combinatie 3', 'Alkmaar', '2022-03-12'),
('2122', '3', '8', 'u', 'vrije ronde', '', '2022-04-02'), -- PvD
('2122', '3', '9', 't', 'Het Spaarne 1', 'Alkmaar', '2022-04-23'),
('2122', '4', '1', 't', 'Purmerend 3', 'Alkmaar', '2021-10-09'),
('2122', '4', '2', 't', 'HWP Haarlem 4', 'Alkmaar', '2021-11-06'),
('2122', '4', '3', 'u', 'VAS 5', 'Amsterdam', '2021-11-27'),
('2122', '4', '4', 't', 'VAS 6', 'Alkmaar', '2022-05-21'),
('2122', '4', '5', 'u', 'Leiderdorp 2', 'Leiderdorp', '2022-02-05'),
('2122', '4', '6', 't', 'Woerden 3', 'Alkmaar', '2022-03-12'),
('2122', '4', '7', 'u', 'Zukertort Amstelveen 3', 'Amstelveen', '2022-04-02'),
('2122', 'n1', '1', 'u', 'Chess Society Zandvoort N1', 'Zandvoort', '2021-10-15'),
('2122', 'n1', '2', 't', 'HWP Haarlem N2', 'Alkmaar', '2021-11-09'),
('2122', 'n1', '3', 'u', 'Kennemer Combinatie N1', 'Haarlem', '2022-05-06'),
('2122', 'n1', '4', 't', 'Krommenie N1', 'Alkmaar', '2022-02-01'),
('2122', 'n1', '5', 'u', 'HWP Haarlem N1', 'Haarlem', '2022-03-01'),
('2122', 'n1', '6', 'u', 'De Uil N1', 'Hillegom', '2022-03-21'),
('2122', 'n1', '7', 't', 'Kijk Uit N1', 'Alkmaar', '2022-04-12'),
('2122', 'n2', '1', 't', 'Volendam N1', 'Alkmaar', '2021-10-12'),
('2122', 'n2', '2', 'u', 'Noordkopcombinatie Magnus N1', 'Schagen', '2021-11-12'),
('2122', 'n2', '3', 't', 'Aartswoud N1', 'Alkmaar', '2022-04-26'),
('2122', 'n2', '4', 'u', 'KTV N1', 'Enkhuizen', '2022-05-27'),
('2122', 'n2', '5', 't', 'Caïssa-Eenhoorn N1', 'Alkmaar', '2022-03-15'),
('2122', 'n2', '7', 'u', 'Opening 64 N1', 'Sint Pancras', '2022-04-15'),
('2122', 'n4', '1', 'u', 'Opening 64 N2', 'Sint Pancras', '2021-11-26'),
('2122', 'n4', '2', 't', 'Heerhugowaard N1', 'Alkmaar', '2022-04-19'),
('2122', 'n4', '5', 'u', 'Aris de Heer N', '', '2022-02-28');

use waagtoren;
select * from ronde where seizoen = '2122' and teamCode = 'n1';
update ronde set datum = '2022-05-06' where seizoen = '2122' and teamCode = 'n1' and rondeNummer = 3; 
delete from uitslag where seizoen = '2122' and teamCode = 'n1' and rondeNummer = 3; 

select * from ronde where seizoen = '2122' and teamCode = 'n2';
update ronde set datum = '2022-05-27' where seizoen = '2122' and teamCode = 'n2' and rondeNummer = 4; 
update ronde set datum = '2022-04-26' where seizoen = '2122' and teamCode = 'n2' and rondeNummer = 3; 
delete from ronde where seizoen = '2122' and teamCode = 'n2' and rondeNummer = 6; 
delete from uitslag where seizoen = '2122' and teamCode = 'n2' and rondeNummer in (4, 3, 6); 

-- ronde 1
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'int', 1, 0, 7269834, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 8073978, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 7904589, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 7399469, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 7879520, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 7428960, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 7502143, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 7509920, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 7758014, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 7544438, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 7582102, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 7640798, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 8750093, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 7649213, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 7699010, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 7707084, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 105, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 115, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 114, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 8552038, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 116, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 8335415, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 8224502, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 6930957, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 6951362, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 8865549, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 0, 7063881, 'a', '', 0, '', '2021-09-07', 'int'),
('2122', 'int', 1, 1, 7665834, 'i', 'w', 8096242, '0', '2021-09-07', 'int'),
('2122', 'int', 1, 1, 8096242, 'i', 'z', 7665834, '1', '2021-09-07', 'int'),
('2122', 'int', 1, 2, 6572511, 'i', 'z', 7099950, '0', '2021-09-07', 'int'),
('2122', 'int', 1, 2, 7099950, 'i', 'w', 6572511, '1', '2021-09-07', 'int'),
('2122', 'int', 1, 3, 8112654, 'i', 'w', 7129991, '½', '2021-09-07', 'int'),
('2122', 'int', 1, 3, 7129991, 'i', 'z', 8112654, '½', '2021-09-07', 'int'),
('2122', 'int', 1, 4, 7099620, 'i', 'w', 7529522, '0', '2021-09-07', 'int'),
('2122', 'int', 1, 4, 7529522, 'i', 'z', 7099620, '1', '2021-09-07', 'int'),
('2122', 'int', 1, 5, 7535396, 'i', 'w', 7707832, '½', '2021-09-07', 'int'),
('2122', 'int', 1, 5, 7707832, 'i', 'z', 7535396, '½', '2021-09-07', 'int'),
('2122', 'int', 1, 6, 7535385, 'i', 'z', 6225934, '½', '2021-09-07', 'int'),
('2122', 'int', 1, 6, 6225934, 'i', 'w', 7535385, '½', '2021-09-07', 'int'),
('2122', 'int', 1, 7, 7292043, 'i', 'z', 7210137, '1', '2021-09-07', 'int'),
('2122', 'int', 1, 7, 7210137, 'i', 'w', 7292043, '0', '2021-09-07', 'int'),
('2122', 'int', 1, 8, 7731812, 'i', 'z', 7809285, '½', '2021-09-07', 'int'),
('2122', 'int', 1, 8, 7809285, 'i', 'w', 7731812, '½', '2021-09-07', 'int'),
('2122', 'int', 1, 9, 8611922, 'i', 'z', 8276752, '½', '2021-09-07', 'int'),
('2122', 'int', 1, 9, 8276752, 'i', 'w', 8611922, '½', '2021-09-07', 'int'),
('2122', 'int', 1, 10, 8587337, 'i', 'z', 8372881, '1', '2021-09-07', 'int'),
('2122', 'int', 1, 10, 8372881, 'i', 'w', 8587337, '0', '2021-09-07', 'int'),
('2122', 'int', 1, 11, 7419621, 'i', 'w', 6214153, '½', '2021-09-07', 'int'),
('2122', 'int', 1, 11, 6214153, 'i', 'z', 7419621, '½', '2021-09-07', 'int'),
('2122', 'int', 1, 12, 8400183, 'i', 'z', 7282033, '0', '2021-09-07', 'int'),
('2122', 'int', 1, 12, 7282033, 'i', 'w', 8400183, '1', '2021-09-07', 'int'),
('2122', 'int', 1, 13, 7518203, 'i', 'z', 8472530, '½', '2021-09-07', 'int'),
('2122', 'int', 1, 13, 8472530, 'i', 'w', 7518203, '½', '2021-09-07', 'int'),
('2122', 'int', 1, 14, 6187885, 'i', 'z', 7321534, '1', '2021-09-07', 'int'),
('2122', 'int', 1, 14, 7321534, 'i', 'w', 6187885, '0', '2021-09-07', 'int'),
('2122', 'int', 1, 15, 8617367, 'i', 'z', 113, '1', '2021-09-07', 'int'),
('2122', 'int', 1, 15, 113, 'i', 'w', 8617367, '0', '2021-09-07', 'int'),
('2122', 'int', 1, 16, 6192098, 'i', 'w', 8931098, '1', '2021-09-07', 'int'),
('2122', 'int', 1, 16, 8931098, 'i', 'z', 6192098, '0', '2021-09-07', 'int'),
('2122', 'int', 1, 17, 8193548, 'i', 'z', 103, '1', '2021-09-07', 'int'),
('2122', 'int', 1, 17, 103, 'i', 'w', 8193548, '0', '2021-09-07', 'int'),
('2122', 'int', 1, 18, 7691728, 'i', 'w', 101, '1', '2021-09-07', 'int'),
('2122', 'int', 1, 18, 101, 'i', 'z', 7691728, '0', '2021-09-07', 'int'),
('2122', 'int', 1, 19, 8485059, 'i', 'z', 111, '1', '2021-09-07', 'int'),
('2122', 'int', 1, 19, 111, 'i', 'w', 8485059, '0', '2021-09-07', 'int'),
('2122', 'int', 1, 20, 7824674, 'i', 'z', 6212404, '1', '2021-09-07', 'int'),
('2122', 'int', 1, 20, 6212404, 'i', 'w', 7824674, '0', '2021-09-07', 'int');

-- ronde 2
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'int', 2, 0, 7544438, 'a', '', 0, '', '2021-09-14', 'int'),
('2122', 'int', 2, 0, 7707084, 'a', '', 0, '', '2021-09-14', 'int'),
('2122', 'int', 2, 0, 6930957, 'a', '', 0, '', '2021-09-14', 'int'),
('2122', 'int', 2, 0, 7691728, 'a', '', 0, '', '2021-09-14', 'int'),
('2122', 'int', 2, 0, 7099950, 'e', '', 0, '', '2021-09-14', 'int'),
('2122', 'int', 2, 0, 8552038, 'a', '', 0, '', '2021-09-14', 'int'),
('2122', 'int', 2, 0, 8335415, 'a', '', 0, '', '2021-09-14', 'int'),
('2122', 'int', 2, 0, 7649213, 'a', '', 0, '', '2021-09-14', 'int'),
('2122', 'int', 2, 0, 7582102, 'a', '', 0, '', '2021-09-14', 'int'),
('2122', 'int', 2, 0, 7509920, 'a', '', 0, '', '2021-09-14', 'int'),
('2122', 'int', 2, 0, 7879520, 'a', '', 0, '', '2021-09-14', 'int'),
('2122', 'int', 2, 0, 114, 'a', '', 0, '', '2021-09-14', 'int'),
('2122', 'int', 2, 0, 8931098, 'a', '', 0, '', '2021-09-14', 'int'),
('2122', 'int', 2, 0, 105, 'a', '', 0, '', '2021-09-14', 'int'),
('2122', 'int', 2, 0, 8865549, 'a', '', 0, '', '2021-09-14', 'int'),
('2122', 'int', 2, 0, 113, 'a', '', 0, '', '2021-09-14', 'int'),
('2122', 'int', 2, 0, 115, 'a', '', 0, '', '2021-09-14', 'int'),
('2122', 'int', 2, 1, 7529522, 'i', 'z', 8096242, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 1, 8096242, 'i', 'w', 7529522, '1', '2021-09-14', 'int'),
('2122', 'int', 2, 2, 8587337, 'i', 'z', 7292043, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 2, 7292043, 'i', 'w', 8587337, '1', '2021-09-14', 'int'),
('2122', 'int', 2, 3, 7824674, 'i', 'w', 7282033, '1', '2021-09-14', 'int'),
('2122', 'int', 2, 3, 7282033, 'i', 'z', 7824674, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 4, 8485059, 'i', 'w', 6187885, '1', '2021-09-14', 'int'),
('2122', 'int', 2, 4, 6187885, 'i', 'z', 8485059, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 5, 6192098, 'i', 'z', 8617367, '1', '2021-09-14', 'int'),
('2122', 'int', 2, 5, 8617367, 'i', 'w', 6192098, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 6, 8193548, 'i', 'w', 8112654, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 6, 8112654, 'i', 'z', 8193548, '1', '2021-09-14', 'int'),
('2122', 'int', 2, 7, 7535385, 'i', 'w', 7535396, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 7, 7535396, 'i', 'z', 7535385, '1', '2021-09-14', 'int'),
('2122', 'int', 2, 8, 7129991, 'i', 'w', 7707832, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 8, 7707832, 'i', 'z', 7129991, '1', '2021-09-14', 'int'),
('2122', 'int', 2, 9, 7809285, 'i', 'w', 6225934, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 9, 6225934, 'i', 'z', 7809285, '1', '2021-09-14', 'int'),
('2122', 'int', 2, 10, 8276752, 'i', 'z', 7731812, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 10, 7731812, 'i', 'w', 8276752, '1', '2021-09-14', 'int'),
('2122', 'int', 2, 11, 7428960, 'i', 'w', 7419621, '½', '2021-09-14', 'int'),
('2122', 'int', 2, 11, 7419621, 'i', 'z', 7428960, '½', '2021-09-14', 'int'),
('2122', 'int', 2, 12, 8611922, 'i', 'w', 6214153, '½', '2021-09-14', 'int'),
('2122', 'int', 2, 12, 6214153, 'i', 'z', 8611922, '½', '2021-09-14', 'int'),
('2122', 'int', 2, 13, 8472530, 'i', 'z', 7063881, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 13, 7063881, 'i', 'w', 8472530, '1', '2021-09-14', 'int'),
('2122', 'int', 2, 14, 7640798, 'i', 'w', 7758014, '½', '2021-09-14', 'int'),
('2122', 'int', 2, 14, 7758014, 'i', 'z', 7640798, '½', '2021-09-14', 'int'),
('2122', 'int', 2, 15, 6951362, 'i', 'w', 7699010, '½', '2021-09-14', 'int'),
('2122', 'int', 2, 15, 7699010, 'i', 'z', 6951362, '½', '2021-09-14', 'int'),
('2122', 'int', 2, 16, 7904589, 'i', 'w', 7502143, '½', '2021-09-14', 'int'),
('2122', 'int', 2, 16, 7502143, 'i', 'z', 7904589, '½', '2021-09-14', 'int'),
('2122', 'int', 2, 17, 7518203, 'i', 'w', 7399469, '½', '2021-09-14', 'int'),
('2122', 'int', 2, 17, 7399469, 'i', 'z', 7518203, '½', '2021-09-14', 'int'),
('2122', 'int', 2, 18, 8750093, 'i', 'w', 8224502, '1', '2021-09-14', 'int'),
('2122', 'int', 2, 18, 8224502, 'i', 'z', 8750093, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 19, 7665834, 'i', 'z', 8073978, '1', '2021-09-14', 'int'),
('2122', 'int', 2, 19, 8073978, 'i', 'w', 7665834, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 20, 7099620, 'i', 'z', 6572511, '1', '2021-09-14', 'int'),
('2122', 'int', 2, 20, 6572511, 'i', 'w', 7099620, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 21, 7210137, 'i', 'w', 6212404, '1', '2021-09-14', 'int'),
('2122', 'int', 2, 21, 6212404, 'i', 'z', 7210137, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 22, 8372881, 'i', 'z', 8400183, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 22, 8400183, 'i', 'w', 8372881, '1', '2021-09-14', 'int'),
('2122', 'int', 2, 23, 111, 'i', 'z', 103, '1', '2021-09-14', 'int'),
('2122', 'int', 2, 23, 103, 'i', 'w', 111, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 24, 7321534, 'i', 'z', 101, '½', '2021-09-14', 'int'),
('2122', 'int', 2, 24, 101, 'i', 'w', 7321534, '½', '2021-09-14', 'int'),
('2122', 'int', 2, 25, 7269834, 'i', 'z', 116, '0', '2021-09-14', 'int'),
('2122', 'int', 2, 25, 116, 'i', 'w', 7269834, '1', '2021-09-14', 'int');

insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', '1', 1, 8, 7099950, 'e', 'z', '0', '0', '2021-09-14', 'int'); -- Jos Vlaming speelt vooruit op

-- KNSB competitie 18 september 2021 
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', '1', '1', '4', '6483455', 'e', 'z', '0', '1', '2021-09-18', 'int'),
('2122', '1', '1', '2', '7428960', 'e', 'z', '0', '0', '2021-09-18', 'int'),
('2122', '1', '1', '10', '7468417', 'e', 'z', '0', '1', '2021-09-18', 'int'),
('2122', '1', '1', '1', '7584566', 'e', 'w', '0', '1', '2021-09-18', 'int'),
('2122', '1', '1', '3', '7657342', 'e', 'w', '0', '1', '2021-09-18', 'int'),
('2122', '1', '1', '7', '7828183', 'e', 'w', '0', '1', '2021-09-18', 'int'),
('2122', '1', '1', '9', '8096242', 'e', 'w', '0', '½', '2021-09-18', 'int'),
('2122', '1', '1', '5', '8180810', 'e', 'w', '0', '1', '2021-09-18', 'int'),
('2122', '1', '1', '6', '8285574', 'e', 'z', '0', '1', '2021-09-18', 'int'),
('2122', '2', '1', '5', '6225934', 'e', 'w', '0', '1', '2021-09-18', 'int'),
('2122', '2', '1', '1', '6335670', 'e', 'w', '0', '1', '2021-09-18', 'int'),
('2122', '2', '1', '2', '7099620', 'e', 'z', '0', '1', '2021-09-18', 'int'),
('2122', '2', '1', '3', '7129991', 'e', 'w', '0', '1', '2021-09-18', 'int'),
('2122', '2', '1', '4', '7509920', 'e', 'z', '0', '1', '2021-09-18', 'int'),
('2122', '2', '1', '7', '7665834', 'e', 'w', '0', '0', '2021-09-18', 'int'),
('2122', '2', '1', '6', '7707832', 'e', 'z', '0', '0', '2021-09-18', 'int'),
('2122', '2', '1', '8', '8552038', 'e', 'z', '0', '0', '2021-09-18', 'int'),
('2122', '3', '1', '8', '6212404', 'e', 'z', '0', '½', '2021-09-18', 'int'),
('2122', '3', '1', '1', '7292043', 'e', 'w', '0', '0', '2021-09-18', 'int'),
('2122', '3', '1', '3', '7535385', 'e', 'w', '0', '0', '2021-09-18', 'int'),
('2122', '3', '1', '2', '7699010', 'e', 'z', '0', '1', '2021-09-18', 'int'),
('2122', '3', '1', '5', '7758014', 'e', 'w', '0', '½', '2021-09-18', 'int'),
('2122', '3', '1', '7', '8484443', 'e', 'w', '0', '0', '2021-09-18', 'int'),
('2122', '3', '1', '6', '8587337', 'e', 'z', '0', '0', '2021-09-18', 'int'),
('2122', '3', '1', '4', '8611922', 'e', 'z', '0', '½', '2021-09-18', 'int');

-- ronde 3
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'int', 3, 0, 8193548, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 7129991, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 7428960, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 7509920, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 7535385, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 7544438, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 7640798, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 7649213, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 7707084, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 7809285, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 7879520, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 8224502, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 8335415, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 8931098, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 8552038, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 8617367, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 6930957, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 113, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 7063881, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 116, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 0, 6187885, 'a', '', 0, '', '2021-09-21', 'int'),
('2122', 'int', 3, 1, 8096242, 'i', 'z', 7292043, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 1, 7292043, 'i', 'w', 8096242, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 2, 7099950, 'i', 'z', 7824674, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 2, 7824674, 'i', 'w', 7099950, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 3, 6192098, 'i', 'z', 7707832, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 3, 7707832, 'i', 'w', 6192098, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 4, 8485059, 'i', 'w', 6225934, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 4, 6225934, 'i', 'z', 8485059, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 5, 7535396, 'i', 'z', 8112654, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 5, 8112654, 'i', 'w', 7535396, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 6, 7099620, 'i', 'w', 7731812, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 6, 7731812, 'i', 'z', 7099620, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 7, 7529522, 'i', 'w', 7665834, '½', '2021-09-21', 'int'),
('2122', 'int', 3, 7, 7665834, 'i', 'z', 7529522, '½', '2021-09-21', 'int'),
('2122', 'int', 3, 8, 8750093, 'i', 'z', 8587337, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 8, 8587337, 'i', 'w', 8750093, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 9, 8611922, 'i', 'w', 7282033, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 9, 7282033, 'i', 'z', 8611922, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 10, 7419621, 'i', 'w', 7518203, '½', '2021-09-21', 'int'),
('2122', 'int', 3, 10, 7518203, 'i', 'z', 7419621, '½', '2021-09-21', 'int'),
('2122', 'int', 3, 11, 7699010, 'i', 'w', 7758014, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 11, 7758014, 'i', 'z', 7699010, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 12, 7691728, 'i', 'w', 7904589, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 12, 7904589, 'i', 'z', 7691728, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 13, 8400183, 'i', 'w', 7210137, '½', '2021-09-21', 'int'),
('2122', 'int', 3, 13, 7210137, 'i', 'z', 8400183, '½', '2021-09-21', 'int'),
('2122', 'int', 3, 14, 6951362, 'i', 'z', 6214153, '½', '2021-09-21', 'int'),
('2122', 'int', 3, 14, 6214153, 'i', 'w', 6951362, '½', '2021-09-21', 'int'),
('2122', 'int', 3, 15, 7502143, 'i', 'w', 111, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 15, 111, 'i', 'z', 7502143, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 17, 7399469, 'i', 'w', 114, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 17, 114, 'i', 'z', 7399469, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 18, 8472530, 'i', 'w', 8276752, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 18, 8276752, 'i', 'z', 8472530, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 19, 8865549, 'i', 'w', 7582102, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 19, 7582102, 'i', 'z', 8865549, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 20, 105, 'i', 'w', 115, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 20, 115, 'i', 'z', 105, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 21, 8073978, 'i', 'z', 101, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 21, 101, 'i', 'w', 8073978, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 22, 6572511, 'i', 'z', 6212404, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 22, 6212404, 'i', 'w', 6572511, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 23, 7269834, 'i', 'w', 7321534, '1', '2021-09-21', 'int'),
('2122', 'int', 3, 23, 7321534, 'i', 'z', 7269834, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 24, 103, 'i', 'z', 8372881, '0', '2021-09-21', 'int'),
('2122', 'int', 3, 24, 8372881, 'i', 'w', 103, '1', '2021-09-21', 'int');

-- ronde 4
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'int', 4, 0, 7584566, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 8552038, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 8484443, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 7535385, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 8485059, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 7509920, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 7468417, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 7428960, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 7399469, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 7321534, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 8335415, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 8285574, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 7657342, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 8276752, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 7699010, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 7707084, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 7809285, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 7828183, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 7879520, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 8193548, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 8180810, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 8617367, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 101, 'w', '', 0, '1', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 8931098, 'a', '', 0, '0', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 8865549, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 113, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 115, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 116, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 8750093, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 7129991, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 6335670, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 6483455, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 7063881, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 0, 6930957, 'a', '', 0, '', '2021-09-28', 'int'),
('2122', 'int', 4, 1, 8096242, 'i', 'w', 7099950, '0', '2021-09-28', 'int'),
('2122', 'int', 4, 1, 7099950, 'i', 'z', 8096242, '1', '2021-09-28', 'int'),
('2122', 'int', 4, 2, 6225934, 'i', 'w', 6192098, '1', '2021-09-28', 'int'),
('2122', 'int', 4, 2, 6192098, 'i', 'z', 6225934, '0', '2021-09-28', 'int'),
('2122', 'int', 4, 3, 8112654, 'i', 'z', 7099620, '1', '2021-09-28', 'int'),
('2122', 'int', 4, 3, 7099620, 'i', 'w', 8112654, '0', '2021-09-28', 'int'),
('2122', 'int', 4, 4, 7292043, 'i', 'z', 7758014, '½', '2021-09-28', 'int'),
('2122', 'int', 4, 4, 7758014, 'i', 'w', 7292043, '½', '2021-09-28', 'int'),
('2122', 'int', 4, 5, 8611922, 'i', 'z', 7824674, '½', '2021-09-28', 'int'),
('2122', 'int', 4, 5, 7824674, 'i', 'w', 8611922, '½', '2021-09-28', 'int'),
('2122', 'int', 4, 6, 7529522, 'i', 'z', 7707832, '1', '2021-09-28', 'int'),
('2122', 'int', 4, 6, 7707832, 'i', 'w', 7529522, '0', '2021-09-28', 'int'),
('2122', 'int', 4, 7, 7904589, 'i', 'z', 7665834, '½', '2021-09-28', 'int'),
('2122', 'int', 4, 7, 7665834, 'i', 'w', 7904589, '½', '2021-09-28', 'int'),
('2122', 'int', 4, 8, 7502143, 'i', 'z', 7535396, '0', '2021-09-28', 'int'),
('2122', 'int', 4, 8, 7535396, 'i', 'w', 7502143, '1', '2021-09-28', 'int'),
('2122', 'int', 4, 9, 7731812, 'i', 'w', 7419621, '1', '2021-09-28', 'int'),
('2122', 'int', 4, 9, 7419621, 'i', 'z', 7731812, '0', '2021-09-28', 'int'),
('2122', 'int', 4, 10, 6214153, 'i', 'w', 8400183, '1', '2021-09-28', 'int'),
('2122', 'int', 4, 10, 8400183, 'i', 'z', 6214153, '0', '2021-09-28', 'int'),
('2122', 'int', 4, 11, 114, 'i', 'w', 6572511, '½', '2021-09-28', 'int'),
('2122', 'int', 4, 11, 6572511, 'i', 'z', 114, '½', '2021-09-28', 'int'),
('2122', 'int', 4, 12, 6951362, 'i', 'w', 7210137, '1', '2021-09-28', 'int'),
('2122', 'int', 4, 12, 7210137, 'i', 'z', 6951362, '0', '2021-09-28', 'int'),
('2122', 'int', 4, 13, 7640798, 'i', 'z', 7518203, '½', '2021-09-28', 'int'),
('2122', 'int', 4, 13, 7518203, 'i', 'w', 7640798, '½', '2021-09-28', 'int'),
('2122', 'int', 4, 14, 8073978, 'i', 'z', 8587337, '½', '2021-09-28', 'int'),
('2122', 'int', 4, 14, 8587337, 'i', 'w', 8073978, '½', '2021-09-28', 'int'),
('2122', 'int', 4, 15, 7582102, 'i', 'w', 7544438, '0', '2021-09-28', 'int'),
('2122', 'int', 4, 15, 7544438, 'i', 'z', 7582102, '1', '2021-09-28', 'int'),
('2122', 'int', 4, 16, 7691728, 'i', 'z', 6187885, '1', '2021-09-28', 'int'),
('2122', 'int', 4, 16, 6187885, 'i', 'w', 7691728, '0', '2021-09-28', 'int'),
('2122', 'int', 4, 17, 7282033, 'i', 'w', 7269834, '1', '2021-09-28', 'int'),
('2122', 'int', 4, 17, 7269834, 'i', 'z', 7282033, '0', '2021-09-28', 'int'),
('2122', 'int', 4, 18, 7649213, 'i', 'z', 111, '1', '2021-09-28', 'int'),
('2122', 'int', 4, 18, 111, 'i', 'w', 7649213, '0', '2021-09-28', 'int'),
('2122', 'int', 4, 19, 8224502, 'i', 'w', 8372881, '0', '2021-09-28', 'int'),
('2122', 'int', 4, 19, 8372881, 'i', 'z', 8224502, '1', '2021-09-28', 'int'),
('2122', 'int', 4, 20, 6212404, 'i', 'w', 8472530, '0', '2021-09-28', 'int'),
('2122', 'int', 4, 20, 8472530, 'i', 'z', 6212404, '1', '2021-09-28', 'int'),
('2122', 'int', 4, 22, 105, 'i', 'z', 103, '1', '2021-09-28', 'int'),
('2122', 'int', 4, 22, 103, 'i', 'w', 105, '0', '2021-09-28', 'int');

-- ronde 5
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'int', 5, 0, 8285574, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 8485059, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7561653, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7535385, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7518203, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7509920, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7504310, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7468417, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 8335415, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 8484443, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7292043, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7584566, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7640798, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7649213, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7657342, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7665834, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7707084, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7809285, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7828183, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7879520, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 8096242, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 8180810, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 8193548, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 8552038, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 111, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 113, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 115, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 8931098, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 116, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 6335670, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 6483455, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7063881, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7099620, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 103, 'o', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 0, 7079743, 'a', '', 0, '', '2021-10-05', 'int'),
('2122', 'int', 5, 1, 6225934, 'i', 'z', 7099950, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 1, 7099950, 'i', 'w', 6225934, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 2, 8112654, 'i', 'z', 6192098, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 2, 6192098, 'i', 'w', 8112654, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 3, 7529522, 'i', 'w', 7535396, '½', '2021-10-05', 'int'),
('2122', 'int', 5, 3, 7535396, 'i', 'z', 7529522, '½', '2021-10-05', 'int'),
('2122', 'int', 5, 4, 7758014, 'i', 'w', 8611922, '½', '2021-10-05', 'int'),
('2122', 'int', 5, 4, 8611922, 'i', 'z', 7758014, '½', '2021-10-05', 'int'),
('2122', 'int', 5, 5, 7824674, 'i', 'z', 7731812, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 5, 7731812, 'i', 'w', 7824674, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 6, 8750093, 'i', 'w', 6951362, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 6, 6951362, 'i', 'z', 8750093, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 7, 7904589, 'i', 'w', 6214153, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 7, 6214153, 'i', 'z', 7904589, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 8, 7428960, 'i', 'z', 114, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 8, 114, 'i', 'w', 7428960, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 9, 7544438, 'i', 'w', 7282033, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 9, 7282033, 'i', 'z', 7544438, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 10, 7691728, 'i', 'z', 6572511, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 10, 6572511, 'i', 'w', 7691728, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 11, 7707832, 'i', 'z', 7502143, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 11, 7502143, 'i', 'w', 7707832, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 12, 7129991, 'i', 'z', 8372881, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 12, 8372881, 'i', 'w', 7129991, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 13, 8073978, 'i', 'w', 8276752, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 13, 8276752, 'i', 'z', 8073978, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 14, 8587337, 'i', 'z', 7419621, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 14, 7419621, 'i', 'w', 8587337, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 15, 8400183, 'i', 'w', 6930957, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 15, 6930957, 'i', 'z', 8400183, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 16, 7699010, 'i', 'z', 7210137, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 16, 7210137, 'i', 'w', 7699010, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 17, 7582102, 'i', 'w', 8472530, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 17, 8472530, 'i', 'z', 7582102, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 18, 101, 'i', 'z', 8617367, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 18, 8617367, 'i', 'w', 101, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 19, 105, 'i', 'z', 7269834, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 19, 7269834, 'i', 'w', 105, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 20, 6187885, 'i', 'w', 7399469, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 20, 7399469, 'i', 'z', 6187885, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 21, 7321534, 'i', 'w', 8224502, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 21, 8224502, 'i', 'z', 7321534, '0', '2021-10-05', 'int'),
('2122', 'int', 5, 22, 6212404, 'i', 'z', 8865549, '1', '2021-10-05', 'int'),
('2122', 'int', 5, 22, 8865549, 'i', 'w', 6212404, '0', '2021-10-05', 'int');

-- KNSB competitie 9 oktober 2021 
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', '1', '2', '4', '7079743', 'e', 'w', '0', '1', '2021-10-09', 'int'),
('2122', '1', '2', '7', '7099950', 'e', 'z', '0', '1', '2021-10-09', 'int'),
('2122', '1', '2', '2', '7428960', 'e', 'w', '0', '½', '2021-10-09', 'int'),
('2122', '1', '2', '9', '7468417', 'e', 'z', '0', '½', '2021-10-09', 'int'),
('2122', '1', '2', '8', '7561653', 'e', 'w', '0', '0', '2021-10-09', 'int'),
('2122', '1', '2', '3', '7584566', 'e', 'z', '0', '1', '2021-10-09', 'int'),
('2122', '1', '2', '1', '7657342', 'e', 'z', '0', '1', '2021-10-09', 'int'),
('2122', '1', '2', '5', '7828183', 'e', 'z', '0', '0', '2021-10-09', 'int'),
('2122', '1', '2', '10', '8096242', 'e', 'w', '0', '0', '2021-10-09', 'int'),
('2122', '1', '2', '6', '8285574', 'e', 'w', '0', '0', '2021-10-09', 'int'),
('2122', '2', '2', '1', '6335670', 'e', 'z', '0', '½', '2021-10-09', 'int'),
('2122', '2', '2', '2', '7099620', 'e', 'w', '0', '1', '2021-10-09', 'int'),
('2122', '2', '2', '3', '7129991', 'e', 'z', '0', '0', '2021-10-09', 'int'),
('2122', '2', '2', '5', '7509920', 'e', 'z', '0', '0', '2021-10-09', 'int'),
('2122', '2', '2', '7', '7707832', 'e', 'z', '0', '1', '2021-10-09', 'int'),
('2122', '2', '2', '4', '7904589', 'e', 'w', '0', '½', '2021-10-09', 'int'),
('2122', '2', '2', '6', '8112654', 'e', 'w', '0', '0', '2021-10-09', 'int'),
('2122', '2', '2', '8', '8552038', 'e', 'w', '0', '0', '2021-10-09', 'int'),
('2122', '3', '2', '4', '6572511', 'e', 'w', '0', '1', '2021-10-09', 'int'),
('2122', '3', '2', '2', '7282033', 'e', 'w', '0', '½', '2021-10-09', 'int'),
('2122', '3', '2', '3', '7292043', 'e', 'z', '0', '0', '2021-10-09', 'int'),
('2122', '3', '2', '5', '7699010', 'e', 'z', '0', '0', '2021-10-09', 'int'),
('2122', '3', '2', '1', '7758014', 'e', 'z', '0', '1', '2021-10-09', 'int'),
('2122', '3', '2', '7', '8587337', 'e', 'z', '0', '1', '2021-10-09', 'int'),
('2122', '3', '2', '6', '8611922', 'e', 'w', '0', '1', '2021-10-09', 'int'),
('2122', '3', '2', '8', '8750093', 'e', 'w', '0', '0', '2021-10-09', 'int'),
('2122', '4', '1', '5', '6212404', 'e', 'z', '0', '1', '2021-10-09', 'int'),
('2122', '4', '1', '2', '7809285', 'e', 'w', '0', '½', '2021-10-09', 'int'),
('2122', '4', '1', '1', '7824674', 'e', 'z', '0', '1', '2021-10-09', 'int'),
('2122', '4', '1', '7', '8073978', 'e', 'z', '0', '0', '2021-10-09', 'int'),
('2122', '4', '1', '3', '8276752', 'e', 'z', '0', '1', '2021-10-09', 'int'),
('2122', '4', '1', '6', '8400183', 'e', 'w', '0', '1', '2021-10-09', 'int'),
('2122', '4', '1', '4', '8485059', 'e', 'w', '0', '1', '2021-10-09', 'int'),
('2122', '4', '1', '8', '8617367', 'e', 'w', '0', '1', '2021-10-09', 'int');

-- Waagtoren n2 12 oktober 2021 tijdens ronde 6
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'n2', '1', '1', '7529522', 'e', 'z', '0', '½', '2021-10-12', 'int'),
('2122', 'n2', '1', '2', '6930957', 'e', 'w', '0', '½', '2021-10-12', 'int'),
('2122', 'n2', '1', '3', '7824674', 'e', 'z', '0', '0', '2021-10-12', 'int'),
('2122', 'n2', '1', '4', '7758014', 'e', 'w', '0', '½', '2021-10-12', 'int'),
('2122', 'n2', '1', '5', '8112654', 'e', 'z', '0', '1', '2021-10-12', 'int'),
('2122', 'n2', '1', '6', '8611922', 'e', 'w', '0', '1', '2021-10-12', 'int'),
('2122', 'n2', '1', '7', '8484443', 'e', 'z', '0', '1', '2021-10-12', 'int'),
('2122', 'n2', '1', '8', '8400183', 'e', 'w', '0', '1', '2021-10-12', 'int');

-- ronde 6
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'int', 6, 0, 7535385, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 8285574, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 8276752, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7292043, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 8224502, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 8193548, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 8180810, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7428960, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7468362, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7468417, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7504310, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7509920, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7544438, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7561653, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7879520, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7584566, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7640798, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7649213, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7657342, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7665834, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7828183, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7699010, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7707084, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7809285, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 6335670, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 8552038, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7129991, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 105, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 8587337, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 8865549, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 116, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 115, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 6483455, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 6572511, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 113, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 6951362, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7063881, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7079743, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 8335415, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 111, 'a', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 8400183, 'e', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 8611922, 'e', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 8484443, 'e', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7529522, 'e', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7824674, 'e', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 8112654, 'e', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 6930957, 'e', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 7758014, 'e', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 0, 6212404, 'o', '', 0, '', '2021-10-12', 'int'),
('2122', 'int', 6, 1, 7099950, 'i', 'w', 8750093, '1', '2021-10-12', 'int'),
('2122', 'int', 6, 1, 8750093, 'i', 'z', 7099950, '0', '2021-10-12', 'int'),
('2122', 'int', 6, 2, 6225934, 'i', 'w', 8096242, '0', '2021-10-12', 'int'),
('2122', 'int', 6, 2, 8096242, 'i', 'z', 6225934, '1', '2021-10-12', 'int'),
('2122', 'int', 6, 3, 7904589, 'i', 'w', 7731812, '0', '2021-10-12', 'int'),
('2122', 'int', 6, 3, 7731812, 'i', 'z', 7904589, '1', '2021-10-12', 'int'),
('2122', 'int', 6, 4, 7282033, 'i', 'w', 7535396, '0', '2021-10-12', 'int'),
('2122', 'int', 6, 4, 7535396, 'i', 'z', 7282033, '1', '2021-10-12', 'int'),
('2122', 'int', 6, 5, 6192098, 'i', 'w', 7099620, '0', '2021-10-12', 'int'),
('2122', 'int', 6, 5, 7099620, 'i', 'z', 6192098, '1', '2021-10-12', 'int'),
('2122', 'int', 6, 6, 7707832, 'i', 'w', 8485059, '1', '2021-10-12', 'int'),
('2122', 'int', 6, 6, 8485059, 'i', 'z', 7707832, '0', '2021-10-12', 'int'),
('2122', 'int', 6, 7, 6214153, 'i', 'w', 7210137, '1', '2021-10-12', 'int'),
('2122', 'int', 6, 7, 7210137, 'i', 'z', 6214153, '0', '2021-10-12', 'int'),
('2122', 'int', 6, 8, 8617367, 'i', 'w', 114, '0', '2021-10-12', 'int'),
('2122', 'int', 6, 8, 114, 'i', 'z', 8617367, '1', '2021-10-12', 'int'),
('2122', 'int', 6, 9, 7518203, 'i', 'w', 7582102, '½', '2021-10-12', 'int'),
('2122', 'int', 6, 9, 7582102, 'i', 'z', 7518203, '½', '2021-10-12', 'int'),
('2122', 'int', 6, 10, 7269834, 'i', 'w', 7691728, '0', '2021-10-12', 'int'),
('2122', 'int', 6, 10, 7691728, 'i', 'z', 7269834, '1', '2021-10-12', 'int'),
('2122', 'int', 6, 11, 7502143, 'i', 'w', 8372881, '1', '2021-10-12', 'int'),
('2122', 'int', 6, 11, 8372881, 'i', 'z', 7502143, '0', '2021-10-12', 'int'),
('2122', 'int', 6, 12, 7399469, 'i', 'w', 8073978, '1', '2021-10-12', 'int'),
('2122', 'int', 6, 12, 8073978, 'i', 'z', 7399469, '0', '2021-10-12', 'int'),
('2122', 'int', 6, 13, 117, 'i', 'w', 7419621, '½', '2021-10-12', 'int'),
('2122', 'int', 6, 13, 7419621, 'i', 'z', 117, '½', '2021-10-12', 'int'),
('2122', 'int', 6, 14, 8472530, 'i', 'w', 7321534, '½', '2021-10-12', 'int'),
('2122', 'int', 6, 14, 7321534, 'i', 'z', 8472530, '½', '2021-10-12', 'int'),
('2122', 'int', 6, 15, 6187885, 'i', 'w', 101, '1', '2021-10-12', 'int'),
('2122', 'int', 6, 15, 101, 'i', 'z', 6187885, '0', '2021-10-12', 'int'),
('2122', 'int', 6, 16, 8931098, 'i', 'w', 103, '½', '2021-10-12', 'int'),
('2122', 'int', 6, 16, 103, 'i', 'z', 8931098, '½', '2021-10-12', 'int');

-- Waagtoren n1 15 oktober 2021
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'n1', '1', '7', '6225934', 'e', 'w', '0', '½', '2021-10-15', 'int'),
('2122', 'n1', '1', '6', '7099620', 'e', 'z', '0', '1', '2021-10-15', 'int'),
('2122', 'n1', '1', '4', '7099950', 'e', 'z', '0', '1', '2021-10-15', 'int'),
('2122', 'n1', '1', '5', '7129991', 'e', 'w', '0', '1', '2021-10-15', 'int'),
('2122', 'n1', '1', '2', '7428960', 'e', 'z', '0', '1', '2021-10-15', 'int'),
('2122', 'n1', '1', '8', '7535385', 'e', 'z', '0', '0', '2021-10-15', 'int'),
('2122', 'n1', '1', '1', '7970094', 'e', 'w', '0', '1', '2021-10-15', 'int'),
('2122', 'n1', '1', '3', '8096242', 'e', 'w', '0', '1', '2021-10-15', 'int');

--- ronde 1, 2 en 3 rapid
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'ira', 1, 1, 8611922, 'i', 'w', 7099950, '1', '2021-10-19', 'ira'), -- Tycho Bakker
('2122', 'ira', 1, 1, 7099950, 'i', 'z', 8611922, '0', '2021-10-19', 'ira'), -- Jos Vlaming
('2122', 'ira', 1, 2, 7707832, 'i', 'w', 6214153, '1', '2021-10-19', 'ira'), -- Ronald Groot
('2122', 'ira', 1, 2, 6214153, 'i', 'z', 7707832, '0', '2021-10-19', 'ira'), -- Jan Poland
('2122', 'ira', 1, 3, 7282033, 'i', 'w', 7665834, '0', '2021-10-19', 'ira'), -- Gerrit Lemmen
('2122', 'ira', 1, 3, 7665834, 'i', 'z', 7282033, '1', '2021-10-19', 'ira'), -- David Baanstra
('2122', 'ira', 1, 4, 6572511, 'i', 'w', 7502143, '1', '2021-10-19', 'ira'), -- Bert Buitink
('2122', 'ira', 1, 4, 7502143, 'i', 'z', 6572511, '0', '2021-10-19', 'ira'), -- Rob Heijnk
('2122', 'ira', 1, 5, 8587337, 'i', 'w', 7292043, '1', '2021-10-19', 'ira'), -- Max Hooijmans
('2122', 'ira', 1, 5, 7292043, 'i', 'z', 8587337, '0', '2021-10-19', 'ira'), -- Rob Freer
('2122', 'ira', 1, 6, 6192098, 'i', 'w', 7399469, '1', '2021-10-19', 'ira'), -- Nico Brugman
('2122', 'ira', 1, 6, 7399469, 'i', 'z', 6192098, '0', '2021-10-19', 'ira'), -- Nico Mak
('2122', 'ira', 1, 7, 8750093, 'i', 'w', 7691728, '1', '2021-10-19', 'ira'), -- Martin Rep
('2122', 'ira', 1, 7, 7691728, 'i', 'z', 8750093, '0', '2021-10-19', 'ira'), -- Karel Beentjes
('2122', 'ira', 1, 8, 6187885, 'i', 'w', 7269834, '1', '2021-10-19', 'ira'), -- Bob de Mon
('2122', 'ira', 1, 8, 7269834, 'i', 'z', 6187885, '0', '2021-10-19', 'ira'), -- Arie Boots
('2122', 'ira', 1, 9, 7518203, 'i', 'w', 101,     '1', '2021-10-19', 'ira'), -- Theo de Bruijn
('2122', 'ira', 1, 9, 101,     'i', 'z', 7518203, '0', '2021-10-19', 'ira'), -- Ramon Witte
('2122', 'ira', 1, 10, 103,    'i', 'w', 114,     '0', '2021-10-19', 'ira'), -- Charles Stoorvogel
('2122', 'ira', 1, 10, 114,    'i', 'z', 103,     '1', '2021-10-19', 'ira'), -- Bram Vink
('2122', 'ira', 2, 1, 8750093, 'i', 'w', 7707832, '0', '2021-10-19', 'ira'), -- Martin Rep
('2122', 'ira', 2, 1, 7707832, 'i', 'z', 8750093, '1', '2021-10-19', 'ira'), -- Ronald Groot
('2122', 'ira', 2, 2, 7665834, 'i', 'w', 7518203, '1', '2021-10-19', 'ira'), -- David Baanstra
('2122', 'ira', 2, 2, 7518203, 'i', 'z', 7665834, '0', '2021-10-19', 'ira'), -- Theo de Bruijn
('2122', 'ira', 2, 3, 114,     'i', 'w', 6572511, '0', '2021-10-19', 'ira'), -- Bram Vink
('2122', 'ira', 2, 3, 6572511, 'i', 'z', 114,     '1', '2021-10-19', 'ira'), -- Bert Buitink
('2122', 'ira', 2, 4, 6192098, 'i', 'w', 8611922, '0', '2021-10-19', 'ira'), -- Nico Brugman
('2122', 'ira', 2, 4, 8611922, 'i', 'z', 6192098, '1', '2021-10-19', 'ira'), -- Tycho Bakker
('2122', 'ira', 2, 5, 6187885, 'i', 'w', 8587337, '0', '2021-10-19', 'ira'), -- Bob de Mon
('2122', 'ira', 2, 5, 8587337, 'i', 'z', 6187885, '1', '2021-10-19', 'ira'), -- Max Hooijmans
('2122', 'ira', 2, 6, 7399469, 'i', 'w', 7099950, '½', '2021-10-19', 'ira'), -- Nico Mak
('2122', 'ira', 2, 6, 7099950, 'i', 'z', 7399469, '½', '2021-10-19', 'ira'), -- Jos Vlaming
('2122', 'ira', 2, 7, 7269834, 'i', 'w', 7292043, '0', '2021-10-19', 'ira'), -- Arie Boots
('2122', 'ira', 2, 7, 7292043, 'i', 'z', 7269834, '1', '2021-10-19', 'ira'), -- Rob Freer
('2122', 'ira', 2, 8, 7691728, 'i', 'w', 6214153, '0', '2021-10-19', 'ira'), -- Karel Beentjes
('2122', 'ira', 2, 8, 6214153, 'i', 'z', 7691728, '1', '2021-10-19', 'ira'), -- Jan Poland
('2122', 'ira', 2, 9, 101,     'i', 'w', 7282033, '0', '2021-10-19', 'ira'), -- Ramon Witte
('2122', 'ira', 2, 9, 7282033, 'i', 'z', 101,     '1', '2021-10-19', 'ira'), -- Gerrit Lemmen
('2122', 'ira', 2, 10, 7502143, 'i', 'w', 103,    '1', '2021-10-19', 'ira'), -- Rob Heijnk
('2122', 'ira', 2, 10, 103,    'i', 'z', 7502143, '0', '2021-10-19', 'ira'), -- Charles Stoorvogel
('2122', 'ira', 3, 1, 6572511, 'i', 'w', 7707832, '0', '2021-10-19', 'ira'), -- Bert Buitink
('2122', 'ira', 3, 1, 7707832, 'i', 'z', 6572511, '1', '2021-10-19', 'ira'), -- Ronald Groot
('2122', 'ira', 3, 2, 7665834, 'i', 'w', 8611922, '½', '2021-10-19', 'ira'), -- David Baanstra
('2122', 'ira', 3, 2, 8611922, 'i', 'z', 7665834, '½', '2021-10-19', 'ira'), -- Tycho Bakker
('2122', 'ira', 3, 3, 7099950, 'i', 'w', 8587337, '1', '2021-10-19', 'ira'), -- Jos Vlaming
('2122', 'ira', 3, 3, 8587337, 'i', 'z', 7099950, '0', '2021-10-19', 'ira'), -- Max Hooijmans
('2122', 'ira', 3, 4, 7292043, 'i', 'w', 8750093, '0', '2021-10-19', 'ira'), -- Rob Freer
('2122', 'ira', 3, 4, 8750093, 'i', 'z', 7292043, '1', '2021-10-19', 'ira'), -- Martin Rep
('2122', 'ira', 3, 5, 6214153, 'i', 'w', 7518203, '1', '2021-10-19', 'ira'), -- Jan Poland
('2122', 'ira', 3, 5, 7518203, 'i', 'z', 6214153, '0', '2021-10-19', 'ira'), -- Theo de Bruijn
('2122', 'ira', 3, 6, 114,     'i', 'w', 7282033, '0', '2021-10-19', 'ira'), -- Bram Vink
('2122', 'ira', 3, 6, 7282033, 'i', 'z', 114,     '1', '2021-10-19', 'ira'), -- Gerrit Lemmen
('2122', 'ira', 3, 7, 7502143, 'i', 'w', 6187885, '1', '2021-10-19', 'ira'), -- Rob Heijnk
('2122', 'ira', 3, 7, 6187885, 'i', 'z', 7502143, '0', '2021-10-19', 'ira'), -- Bob de Mon
('2122', 'ira', 3, 8, 7399469, 'i', 'w', 6212404, '½', '2021-10-19', 'ira'), -- Nico Mak
('2122', 'ira', 3, 8, 6212404, 'i', 'z', 7399469, '½', '2021-10-19', 'ira'), -- Peter van Diepen
('2122', 'ira', 3, 9, 7269834, 'i', 'w', 7691728, '1', '2021-10-19', 'ira'), -- Arie Boots
('2122', 'ira', 3, 9, 7691728, 'i', 'z', 7269834, '0', '2021-10-19', 'ira'), -- Karel Beentjes
('2122', 'ira', 3, 10, 101,    'i', 'w', 103,     '1', '2021-10-19', 'ira'), -- Ramon Witte
('2122', 'ira', 3, 10, 103,    'i', 'z', 101,     '0', '2021-10-19', 'ira'); -- Charles Stoorvogel

-- ronde 7
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'int', 7, 0, 7504310, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7099620, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7129991, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 8180810, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7970094, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7879520, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7828183, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7824674, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7468362, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7468417, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7809285, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7210137, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7509920, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7758014, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7535385, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7561653, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7707084, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7584566, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7640798, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7649213, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7657342, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7699010, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 6335670, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 116, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 115, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 117, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 8552038, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 118, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 8484443, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 8472530, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 8335415, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 113, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 6483455, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 8285574, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 8931098, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 111, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 8193548, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 8587337, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7063881, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 7079743, 'a', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 0, 8372881, 'o', '', 0, '', '2021-10-26', 'int'),
('2122', 'int', 7, 1, 8112654, 'i', 'w', 7099950, '0', '2021-10-26', 'int'),
('2122', 'int', 7, 1, 7099950, 'i', 'z', 8112654, '1', '2021-10-26', 'int'),
('2122', 'int', 7, 2, 8096242, 'i', 'w', 7731812, '1', '2021-10-26', 'int'),
('2122', 'int', 7, 2, 7731812, 'i', 'z', 8096242, '0', '2021-10-26', 'int'),
('2122', 'int', 7, 3, 7535396, 'i', 'w', 8611922, '½', '2021-10-26', 'int'),
('2122', 'int', 7, 3, 8611922, 'i', 'z', 7535396, '½', '2021-10-26', 'int'),
('2122', 'int', 7, 4, 7529522, 'i', 'w', 6225934, '1', '2021-10-26', 'int'),
('2122', 'int', 7, 4, 6225934, 'i', 'z', 7529522, '0', '2021-10-26', 'int'),
('2122', 'int', 7, 5, 8750093, 'i', 'w', 7707832, '0', '2021-10-26', 'int'),
('2122', 'int', 7, 5, 7707832, 'i', 'z', 8750093, '1', '2021-10-26', 'int'),
('2122', 'int', 7, 6, 7292043, 'i', 'w', 7428960, '0', '2021-10-26', 'int'),
('2122', 'int', 7, 6, 7428960, 'i', 'z', 7292043, '1', '2021-10-26', 'int'),
('2122', 'int', 7, 7, 114, 'i', 'w', 7904589, '1', '2021-10-26', 'int'),
('2122', 'int', 7, 7, 7904589, 'i', 'z', 114, '0', '2021-10-26', 'int'),
('2122', 'int', 7, 8, 7282033, 'i', 'w', 6214153, '1', '2021-10-26', 'int'),
('2122', 'int', 7, 8, 6214153, 'i', 'z', 7282033, '0', '2021-10-26', 'int'),
('2122', 'int', 7, 9, 6930957, 'i', 'w', 6572511, '0', '2021-10-26', 'int'),
('2122', 'int', 7, 9, 6572511, 'i', 'z', 6930957, '1', '2021-10-26', 'int'),
('2122', 'int', 7, 10, 6192098, 'i', 'w', 7665834, '0', '2021-10-26', 'int'),
('2122', 'int', 7, 10, 7665834, 'i', 'z', 6192098, '1', '2021-10-26', 'int'),
('2122', 'int', 7, 11, 8276752, 'i', 'w', 7691728, '1', '2021-10-26', 'int'),
('2122', 'int', 7, 11, 7691728, 'i', 'z', 8276752, '0', '2021-10-26', 'int'),
('2122', 'int', 7, 12, 7399469, 'i', 'w', 7502143, '½', '2021-10-26', 'int'),
('2122', 'int', 7, 12, 7502143, 'i', 'z', 7399469, '½', '2021-10-26', 'int'),
('2122', 'int', 7, 13, 8485059, 'i', 'w', 6951362, '0', '2021-10-26', 'int'),
('2122', 'int', 7, 13, 6951362, 'i', 'z', 8485059, '1', '2021-10-26', 'int'),
('2122', 'int', 7, 14, 7582102, 'i', 'w', 8400183, '0', '2021-10-26', 'int'),
('2122', 'int', 7, 14, 8400183, 'i', 'z', 7582102, '1', '2021-10-26', 'int'),
('2122', 'int', 7, 15, 7544438, 'i', 'w', 7518203, '0', '2021-10-26', 'int'),
('2122', 'int', 7, 15, 7518203, 'i', 'z', 7544438, '1', '2021-10-26', 'int'),
('2122', 'int', 7, 16, 6212404, 'i', 'w', 8617367, '0', '2021-10-26', 'int'),
('2122', 'int', 7, 16, 8617367, 'i', 'z', 6212404, '1', '2021-10-26', 'int'),
('2122', 'int', 7, 17, 7419621, 'i', 'w', 7269834, '½', '2021-10-26', 'int'),
('2122', 'int', 7, 17, 7269834, 'i', 'z', 7419621, '½', '2021-10-26', 'int'),
('2122', 'int', 7, 18, 8073978, 'i', 'w', 6187885, '1', '2021-10-26', 'int'),
('2122', 'int', 7, 18, 6187885, 'i', 'z', 8073978, '0', '2021-10-26', 'int'),
('2122', 'int', 7, 19, 105, 'i', 'w', 7321534, '0', '2021-10-26', 'int'),
('2122', 'int', 7, 19, 7321534, 'i', 'z', 105, '1', '2021-10-26', 'int'),
('2122', 'int', 7, 20, 101, 'i', 'w', 103, '½', '2021-10-26', 'int'),
('2122', 'int', 7, 20, 103, 'i', 'z', 101, '½', '2021-10-26', 'int'),
('2122', 'int', 7, 21, 8224502, 'i', 'w', 8865549, '1', '2021-10-26', 'int'),
('2122', 'int', 7, 21, 8865549, 'i', 'z', 8224502, '0', '2021-10-26', 'int');

-- ronde 8
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'int', 8, 0, 7468362, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7509920, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7468417, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7504310, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7535385, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7544438, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7561653, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7584566, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7640798, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7649213, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7657342, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7699010, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7707084, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7809285, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7828183, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7879520, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7970094, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 8096242, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 8112654, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 8180810, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 8193548, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 8552038, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 8276752, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 8285574, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 8335415, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 8472530, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 8484443, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 6187885, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 6335670, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 6483455, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 114, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 6930957, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7063881, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 8931098, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7079743, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7099620, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 115, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 113, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 111, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 116, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7129991, 'a', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 0, 7419621, 'o', '', 0, '', '2021-11-02', 'int'),
('2122', 'int', 8, 1, 7529522, 'i', 'w', 7099950, '0', '2021-11-02', 'int'),
('2122', 'int', 8, 1, 7099950, 'i', 'z', 7529522, '1', '2021-11-02', 'int'),
('2122', 'int', 8, 2, 7707832, 'i', 'w', 7428960, '½', '2021-11-02', 'int'),
('2122', 'int', 8, 2, 7428960, 'i', 'z', 7707832, '½', '2021-11-02', 'int'),
('2122', 'int', 8, 3, 7731812, 'i', 'w', 7535396, '0', '2021-11-02', 'int'),
('2122', 'int', 8, 3, 7535396, 'i', 'z', 7731812, '1', '2021-11-02', 'int'),
('2122', 'int', 8, 4, 6572511, 'i', 'w', 8611922, '½', '2021-11-02', 'int'),
('2122', 'int', 8, 4, 8611922, 'i', 'z', 6572511, '½', '2021-11-02', 'int'),
('2122', 'int', 8, 5, 7758014, 'i', 'w', 7282033, '1', '2021-11-02', 'int'),
('2122', 'int', 8, 5, 7282033, 'i', 'z', 7758014, '0', '2021-11-02', 'int'),
('2122', 'int', 8, 6, 7665834, 'i', 'w', 6225934, '0', '2021-11-02', 'int'),
('2122', 'int', 8, 6, 6225934, 'i', 'z', 7665834, '1', '2021-11-02', 'int'),
('2122', 'int', 8, 7, 7824674, 'i', 'w', 8750093, '½', '2021-11-02', 'int'),
('2122', 'int', 8, 7, 8750093, 'i', 'z', 7824674, '½', '2021-11-02', 'int'),
('2122', 'int', 8, 8, 6951362, 'i', 'w', 7292043, '0', '2021-11-02', 'int'),
('2122', 'int', 8, 8, 7292043, 'i', 'z', 6951362, '1', '2021-11-02', 'int'),
('2122', 'int', 8, 9, 7518203, 'i', 'w', 7904589, '0', '2021-11-02', 'int'),
('2122', 'int', 8, 9, 7904589, 'i', 'z', 7518203, '1', '2021-11-02', 'int'),
('2122', 'int', 8, 10, 8587337, 'i', 'w', 6214153, '1', '2021-11-02', 'int'),
('2122', 'int', 8, 10, 6214153, 'i', 'z', 8587337, '0', '2021-11-02', 'int'),
('2122', 'int', 8, 11, 8400183, 'i', 'w', 7502143, '½', '2021-11-02', 'int'),
('2122', 'int', 8, 11, 7502143, 'i', 'z', 8400183, '½', '2021-11-02', 'int'),
('2122', 'int', 8, 12, 8617367, 'i', 'w', 7399469, '0', '2021-11-02', 'int'),
('2122', 'int', 8, 12, 7399469, 'i', 'z', 8617367, '1', '2021-11-02', 'int'),
('2122', 'int', 8, 13, 7691728, 'i', 'w', 6192098, '1', '2021-11-02', 'int'),
('2122', 'int', 8, 13, 6192098, 'i', 'z', 7691728, '0', '2021-11-02', 'int'),
('2122', 'int', 8, 14, 8372881, 'i', 'w', 7210137, '½', '2021-11-02', 'int'),
('2122', 'int', 8, 14, 7210137, 'i', 'z', 8372881, '½', '2021-11-02', 'int'),
('2122', 'int', 8, 15, 8073978, 'i', 'w', 8485059, '1', '2021-11-02', 'int'),
('2122', 'int', 8, 15, 8485059, 'i', 'z', 8073978, '0', '2021-11-02', 'int'),
('2122', 'int', 8, 16, 7321534, 'i', 'w', 7582102, '1', '2021-11-02', 'int'),
('2122', 'int', 8, 16, 7582102, 'i', 'z', 7321534, '0', '2021-11-02', 'int'),
('2122', 'int', 8, 17, 7269834, 'i', 'w', 6212404, '0', '2021-11-02', 'int'),
('2122', 'int', 8, 17, 6212404, 'i', 'z', 7269834, '1', '2021-11-02', 'int'),
('2122', 'int', 8, 18, 8224502, 'i', 'w', 117, '½', '2021-11-02', 'int'),
('2122', 'int', 8, 18, 117, 'i', 'z', 8224502, '½', '2021-11-02', 'int'),
('2122', 'int', 8, 19, 105, 'i', 'w', 101, '0', '2021-11-02', 'int'),
('2122', 'int', 8, 19, 101, 'i', 'z', 105, '1', '2021-11-02', 'int'),
('2122', 'int', 8, 20, 103, 'i', 'w', 8865549, '1', '2021-11-02', 'int'),
('2122', 'int', 8, 20, 8865549, 'i', 'z', 103, '0', '2021-11-02', 'int');

-- KNSB competitie 6 november 2021 
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', '1', '3', '5', '7099950', 'e', 'z', '0', '1', '2021-11-06', 'int'),
('2122', '1', '3', '6', '8180810', 'e', 'w', '0', '0', '2021-11-06', 'int'),
('2122', '1', '3', '7', '7468417', 'e', 'z', '0', '½', '2021-11-06', 'int'),
('2122', '1', '3', '8', '8285574', 'e', 'w', '0', '0', '2021-11-06', 'int'),
('2122', '1', '3', '10', '6335670', 'e', 'w', '0', '½', '2021-11-06', 'int'),
('2122', '1', '3', '4', '6483455', 'e', 'w', '0', '0', '2021-11-06', 'int'),
('2122', '1', '3', '2', '7428960', 'e', 'w', '0', '0', '2021-11-06', 'int'),
('2122', '1', '3', '3', '7584566', 'e', 'z', '0', '½', '2021-11-06', 'int'),
('2122', '1', '3', '1', '7657342', 'e', 'z', '0', '0', '2021-11-06', 'int'),
('2122', '1', '3', '9', '8096242', 'e', 'z', '0', '1', '2021-11-06', 'int'),
('2122', '2', '3', '1', '7099620', 'e', 'z', '0', '½', '2021-11-06', 'int'),
('2122', '2', '3', '3', '7707832', 'e', 'z', '0', '0', '2021-11-06', 'int'),
('2122', '2', '3', '4', '7879520', 'e', 'w', '0', '1', '2021-11-06', 'int'),
('2122', '2', '3', '6', '8112654', 'e', 'w', '0', '1', '2021-11-06', 'int'),
('2122', '2', '3', '7', '7665834', 'e', 'z', '0', '½', '2021-11-06', 'int'),
('2122', '2', '3', '8', '8552038', 'e', 'w', '0', '1', '2021-11-06', 'int'),
('2122', '2', '3', '2', '7129991', 'e', 'w', '0', '0', '2021-11-06', 'int'),
('2122', '2', '3', '5', '7509920', 'e', 'z', '0', '½', '2021-11-06', 'int'),
('2122', '3', '3', '1', '7535396', 'e', 'z', '0', '0', '2021-11-06', 'int'),
('2122', '3', '3', '3', '7904589', 'e', 'z', '0', '1', '2021-11-06', 'int'),
('2122', '3', '3', '6', '7504310', 'e', 'w', '0', '½', '2021-11-06', 'int'),
('2122', '3', '3', '8', '7824674', 'e', 'w', '0', '½', '2021-11-06', 'int'),
('2122', '3', '3', '4', '6572511', 'e', 'w', '0', '0', '2021-11-06', 'int'),
('2122', '3', '3', '5', '7699010', 'e', 'z', '0', '1', '2021-11-06', 'int'),
('2122', '3', '3', '2', '7758014', 'e', 'w', '0', '½', '2021-11-06', 'int'),
('2122', '3', '3', '7', '8611922', 'e', 'z', '0', '½', '2021-11-06', 'int'),
('2122', '4', '2', '1', '7292043', 'e', 'z', '0', '½', '2021-11-06', 'int'),
('2122', '4', '2', '2', '7282033', 'e', 'w', '0', '1', '2021-11-06', 'int'),
('2122', '4', '2', '3', '8750093', 'e', 'z', '0', '½', '2021-11-06', 'int'),
('2122', '4', '2', '4', '8400183', 'e', 'w', '0', '1', '2021-11-06', 'int'),
('2122', '4', '2', '5', '7321534', 'e', 'z', '0', '½', '2021-11-06', 'int'),
('2122', '4', '2', '6', '8485059', 'e', 'w', '0', '1', '2021-11-06', 'int'),
('2122', '4', '2', '7', '8472530', 'e', 'z', '0', '1', '2021-11-06', 'int'),
('2122', '4', '2', '8', '6212404', 'e', 'w', '0', '1', '2021-11-06', 'int');

-- Waagtoren n1 op 9 november 2021 tijdens ronde 9
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'n1', '2', '1', '7970094', 'e', 'z', '0', '1', '2021-11-09', 'int'),
('2122', 'n1', '2', '2', '7428960', 'e', 'w', '0', '1', '2021-11-09', 'int'),
('2122', 'n1', '2', '3', '8096242', 'e', 'z', '0', '1', '2021-11-09', 'int'),
('2122', 'n1', '2', '4', '7099950', 'e', 'w', '0', '1', '2021-11-09', 'int'),
('2122', 'n1', '2', '5', '7129991', 'e', 'z', '0', '0', '2021-11-09', 'int'),
('2122', 'n1', '2', '6', '7099620', 'e', 'w', '0', '1', '2021-11-09', 'int'),
('2122', 'n1', '2', '7', '7707832', 'e', 'z', '0', '1', '2021-11-09', 'int'),
('2122', 'n1', '2', '8', '6225934', 'e', 'w', '0', '½', '2021-11-09', 'int');

-- ronde 9
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values                                                                                                                                                    ('2122', 'int', 9, 0, 7699010, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7665834, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7657342, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7649213, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7584566, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7561653, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7544438, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7535396, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7535385, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7509920, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7504310, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7502143, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7468417, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7468362, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 8552038, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7419621, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7707084, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7809285, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7828183, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7879520, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7904589, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 8112654, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 8180810, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 8193548, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 8587337, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 8276752, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 8285574, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 8335415, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 8400183, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 8472530, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 8484443, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 116, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7321534, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 6483455, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 8931098, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 8617367, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 105, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 111, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 6930957, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 118, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 115, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 6335670, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7079743, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 113, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7063881, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 114, 'a', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7707832, 'e', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7428960, 'e', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 6225934, 'e', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 8096242, 'e', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7970094, 'e', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7099620, 'e', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7099950, 'e', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 7129991, 'e', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 0, 6192098, 'o', '', 0, '', '2021-11-09', 'int'),
('2122', 'int', 9, 1, 7529522, 'i', 'w', 7758014, '1', '2021-11-09', 'int'),
('2122', 'int', 9, 1, 7758014, 'i', 'z', 7529522, '0', '2021-11-09', 'int'),
('2122', 'int', 9, 2, 8611922, 'i', 'w', 7292043, '½', '2021-11-09', 'int'),
('2122', 'int', 9, 2, 7292043, 'i', 'z', 8611922, '½', '2021-11-09', 'int'),
('2122', 'int', 9, 3, 6572511, 'i', 'w', 7731812, '1', '2021-11-09', 'int'),
('2122', 'int', 9, 3, 7731812, 'i', 'z', 6572511, '0', '2021-11-09', 'int'),
('2122', 'int', 9, 4, 7282033, 'i', 'w', 8750093, '0', '2021-11-09', 'int'),
('2122', 'int', 9, 4, 8750093, 'i', 'z', 7282033, '1', '2021-11-09', 'int'),
('2122', 'int', 9, 5, 7399469, 'i', 'w', 7824674, '½', '2021-11-09', 'int'),
('2122', 'int', 9, 5, 7824674, 'i', 'z', 7399469, '½', '2021-11-09', 'int'),
('2122', 'int', 9, 6, 7691728, 'i', 'w', 6951362, '0', '2021-11-09', 'int'),
('2122', 'int', 9, 6, 6951362, 'i', 'z', 7691728, '1', '2021-11-09', 'int'),
('2122', 'int', 9, 7, 7518203, 'i', 'w', 8073978, '1', '2021-11-09', 'int'),
('2122', 'int', 9, 7, 8073978, 'i', 'z', 7518203, '0', '2021-11-09', 'int'),
('2122', 'int', 9, 8, 6214153, 'i', 'w', 8372881, '½', '2021-11-09', 'int'),
('2122', 'int', 9, 8, 8372881, 'i', 'z', 6214153, '½', '2021-11-09', 'int'),
('2122', 'int', 9, 9, 7210137, 'i', 'w', 7640798, '½', '2021-11-09', 'int'),
('2122', 'int', 9, 9, 7640798, 'i', 'z', 7210137, '½', '2021-11-09', 'int'),
('2122', 'int', 9, 10, 8485059, 'i', 'w', 6212404, '0', '2021-11-09', 'int'),
('2122', 'int', 9, 10, 6212404, 'i', 'z', 8485059, '1', '2021-11-09', 'int'),
('2122', 'int', 9, 11, 7582102, 'i', 'w', 117, '0', '2021-11-09', 'int'),
('2122', 'int', 9, 11, 117, 'i', 'z', 7582102, '1', '2021-11-09', 'int'),
('2122', 'int', 9, 12, 101, 'i', 'w', 7269834, '1', '2021-11-09', 'int'),
('2122', 'int', 9, 12, 7269834, 'i', 'z', 101, '0', '2021-11-09', 'int'),
('2122', 'int', 9, 13, 103, 'i', 'w', 8224502, '0', '2021-11-09', 'int'),
('2122', 'int', 9, 13, 8224502, 'i', 'z', 103, '1', '2021-11-09', 'int'),
('2122', 'int', 9, 14, 8865549, 'i', 'w', 6187885, '1', '2021-11-09', 'int'),
('2122', 'int', 9, 14, 6187885, 'i', 'z', 8865549, '0', '2021-11-09', 'int');

-- Waagtoren n2 12 november 2021
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'n2', '2', '2', '6930957', 'e', 'z', '0', '½', '2021-11-12', 'int'),
('2122', 'n2', '2', '1', '7529522', 'e', 'w', '0', '0', '2021-11-12', 'int'),
('2122', 'n2', '2', '4', '7699010', 'e', 'z', '0', '0', '2021-11-12', 'int'),
('2122', 'n2', '2', '3', '7758014', 'e', 'w', '0', '0', '2021-11-12', 'int'),
('2122', 'n2', '2', '8', '8400183', 'e', 'z', '0', '½', '2021-11-12', 'int'),
('2122', 'n2', '2', '5', '8484443', 'e', 'w', '0', '1', '2021-11-12', 'int'),
('2122', 'n2', '2', '7', '8587337', 'e', 'w', '0', '0', '2021-11-12', 'int'),
('2122', 'n2', '2', '6', '8611922', 'e', 'z', '0', '1', '2021-11-12', 'int');

-- Waagtoren n4 op 26 november 2021
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'n4', '1', '2', '6212404', 'e', 'z', '0', '½', '2021-11-26', 'int'),
('2122', 'n4', '1', '1', '7399469', 'e', 'w', '0', '1', '2021-11-26', 'int'),
('2122', 'n4', '1', '3', '6192098', 'e', 'w', '0', '0', '2021-11-26', 'int'),
('2122', 'n4', '1', '4', '7691728', 'e', 'z', '0', '0', '2021-11-26', 'int'),
('2122', 'n4', '1', '5', '7321534', 'e', 'w', '0', '1', '2021-11-26', 'int'),
('2122', 'n4', '1', '6', '6187885', 'e', 'z', '0', '0', '2021-11-26', 'int');

-- KNSB competitie 27 november 2021
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', '3', '4', '2', '6572511', 'e', 'z', '0', '½', '2021-11-27', 'int'),
('2122', '3', '4', '6', '7699010', 'e', 'z', '0', '½', '2021-11-27', 'int'),
('2122', '3', '4', '3', '7758014', 'e', 'w', '0', '½', '2021-11-27', 'int'),
('2122', '3', '4', '5', '8611922', 'e', 'w', '0', '0', '2021-11-27', 'int'),
('2122', '3', '4', '1', '7665834', 'e', 'w', '0', '0', '2021-11-27', 'int'),
('2122', '3', '4', '4', '7535385', 'e', 'z', '0', '1', '2021-11-27', 'int'),
('2122', '3', '4', '7', '7504310', 'e', 'w', '0', '0', '2021-11-27', 'int'),
('2122', '3', '4', '8', '8587337', 'e', 'z', '0', '0', '2021-11-27', 'int'),
('2122', '4', '3', '1', '7904589', 'e', 'w', '0', '1', '2021-11-27', 'int'),
('2122', '4', '3', '2', '7292043', 'e', 'z', '0', '1', '2021-11-27', 'int'),
('2122', '4', '3', '3', '7282033', 'e', 'w', '0', '1', '2021-11-27', 'int'),
('2122', '4', '3', '4', '8750093', 'e', 'z', '0', '1', '2021-11-27', 'int'),
('2122', '4', '3', '5', '7649213', 'e', 'w', '0', '½', '2021-11-27', 'int'),
('2122', '4', '3', '6', '8485059', 'e', 'z', '0', '1', '2021-11-27', 'int'),
('2122', '4', '3', '7', '6212404', 'e', 'w', '0', '0', '2021-11-27', 'int'),
('2122', '4', '3', '8', '7321534', 'e', 'z', '0', '½', '2021-11-27', 'int');

-- ronde 10
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'int', 10, 0, 7468362, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7707084, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7691728, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7665834, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7657342, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7649213, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7640798, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7584566, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7582102, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7561653, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7535385, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7529522, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7509920, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7504310, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7468417, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7809285, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7828183, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7879520, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7970094, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 8096242, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 8180810, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 8193548, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 8276752, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 8285574, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 8335415, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 8484443, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 8552038, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 8617367, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 8865549, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 8931098, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7824674, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 113, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 6335670, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 6483455, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 6225934, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 6187885, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 118, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 6951362, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7063881, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7079743, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7099620, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 117, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7129991, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 111, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7210137, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 116, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 115, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 114, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7419621, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7321534, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 0, 7399469, 'a', '', 0, '', '2022-02-01', 'int'),
('2122', 'int', 10, 1, 7269834, 'i', 'w', 103, '1', '2022-02-01', 'int'),
('2122', 'int', 10, 1, 103, 'i', 'z', 7269834, '0', '2022-02-01', 'int'),
('2122', 'int', 10, 2, 8472530, 'i', 'w', 105, '½', '2022-02-01', 'int'),
('2122', 'int', 10, 2, 105, 'i', 'z', 8472530, '½', '2022-02-01', 'int'),
('2122', 'int', 10, 3, 7099950, 'i', 'w', 7707832, '1', '2022-02-01', 'int'),
('2122', 'int', 10, 3, 7707832, 'i', 'z', 7099950, '0', '2022-02-01', 'int'),
('2122', 'int', 10, 4, 7428960, 'i', 'w', 8112654, '1', '2022-02-01', 'int'),
('2122', 'int', 10, 4, 8112654, 'i', 'z', 7428960, '0', '2022-02-01', 'int'),
('2122', 'int', 10, 5, 7535396, 'i', 'w', 6572511, '1', '2022-02-01', 'int'),
('2122', 'int', 10, 5, 6572511, 'i', 'z', 7535396, '0', '2022-02-01', 'int'),
('2122', 'int', 10, 6, 8611922, 'i', 'w', 8750093, '1', '2022-02-01', 'int'),
('2122', 'int', 10, 6, 8750093, 'i', 'z', 8611922, '0', '2022-02-01', 'int'),
('2122', 'int', 10, 7, 7904589, 'i', 'w', 7758014, '0', '2022-02-01', 'int'),
('2122', 'int', 10, 7, 7758014, 'i', 'z', 7904589, '1', '2022-02-01', 'int'),
('2122', 'int', 10, 8, 7731812, 'i', 'w', 7292043, '0', '2022-02-01', 'int'),
('2122', 'int', 10, 8, 7292043, 'i', 'z', 7731812, '1', '2022-02-01', 'int'),
('2122', 'int', 10, 9, 8587337, 'i', 'w', 7282033, '0', '2022-02-01', 'int'),
('2122', 'int', 10, 9, 7282033, 'i', 'z', 8587337, '1', '2022-02-01', 'int'),
('2122', 'int', 10, 10, 6212404, 'i', 'w', 7518203, '1', '2022-02-01', 'int'),
('2122', 'int', 10, 10, 7518203, 'i', 'z', 6212404, '0', '2022-02-01', 'int'),
('2122', 'int', 10, 11, 6192098, 'i', 'w', 8400183, '1', '2022-02-01', 'int'),
('2122', 'int', 10, 11, 8400183, 'i', 'z', 6192098, '0', '2022-02-01', 'int'),
('2122', 'int', 10, 12, 7502143, 'i', 'w', 6930957, '0', '2022-02-01', 'int'),
('2122', 'int', 10, 12, 6930957, 'i', 'z', 7502143, '1', '2022-02-01', 'int'),
('2122', 'int', 10, 13, 7699010, 'i', 'w', 6214153, '1', '2022-02-01', 'int'),
('2122', 'int', 10, 13, 6214153, 'i', 'z', 7699010, '0', '2022-02-01', 'int'),
('2122', 'int', 10, 14, 8073978, 'i', 'w', 8372881, '0', '2022-02-01', 'int'),
('2122', 'int', 10, 14, 8372881, 'i', 'z', 8073978, '1', '2022-02-01', 'int'),
('2122', 'int', 10, 15, 8485059, 'i', 'w', 7544438, '0', '2022-02-01', 'int'),
('2122', 'int', 10, 15, 7544438, 'i', 'z', 8485059, '1', '2022-02-01', 'int'),
('2122', 'int', 10, 16, 8224502, 'i', 'w', 101, '1', '2022-02-01', 'int'),
('2122', 'int', 10, 16, 101, 'i', 'z', 8224502, '0', '2022-02-01', 'int');

-- Waagtoren n1 op 8 februari 2022 tijdens ronde 11
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'n1', '4', '6', '6225934', 'e', 'w', '0', '½', '2022-02-08', 'int'),
('2122', 'n1', '4', '1', '7099620', 'e', 'z', '0', '0', '2022-02-08', 'int'),
('2122', 'n1', '4', '2', '7099950', 'e', 'w', '0', '1', '2022-02-08', 'int'),
('2122', 'n1', '4', '3', '7129991', 'e', 'z', '0', '½', '2022-02-08', 'int'),
('2122', 'n1', '4', '4', '7428960', 'e', 'w', '0', '1', '2022-02-08', 'int'),
('2122', 'n1', '4', '8', '7535385', 'e', 'w', '0', '1', '2022-02-08', 'int'),
('2122', 'n1', '4', '5', '7707832', 'e', 'z', '0', '0', '2022-02-08', 'int'),
('2122', 'n1', '4', '7', '8112654', 'e', 'z', '0', '0', '2022-02-08', 'int');

-- ronde 11
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'int', 11, 0, 7824674, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7468362, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7809285, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7707084, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7665834, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7657342, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7649213, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7640798, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7584566, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7582102, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7561653, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7544438, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7509920, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7504310, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7468417, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 8931098, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7828183, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7879520, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7970094, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 8073978, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 8096242, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 8180810, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 8193548, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 8276752, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 8285574, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 8335415, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 8484443, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 8485059, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 8552038, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 8617367, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 8865549, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 118, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 6951362, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7063881, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7079743, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 6483455, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 6335670, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 6187885, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 116, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 115, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 114, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 113, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 111, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7321534, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7399469, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7419621, 'a', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7428960, 'e', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 8112654, 'e', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 6225934, 'e', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7707832, 'e', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7129991, 'e', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7535385, 'e', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7099950, 'e', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 7099620, 'e', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 0, 6214153, 'o', '', 0, '', '2022-02-08', 'int'),
('2122', 'int', 11, 1, 103, 'i', 'w', 8472530, '0', '2022-02-08', 'int'),
('2122', 'int', 11, 1, 8472530, 'i', 'z', 103, '1', '2022-02-08', 'int'),
('2122', 'int', 11, 2, 117, 'i', 'w', 105, '0', '2022-02-08', 'int'),
('2122', 'int', 11, 2, 105, 'i', 'z', 117, '1', '2022-02-08', 'int'),
('2122', 'int', 11, 3, 7758014, 'i', 'w', 7535396, '½', '2022-02-08', 'int'),
('2122', 'int', 11, 3, 7535396, 'i', 'z', 7758014, '½', '2022-02-08', 'int'),
('2122', 'int', 11, 4, 8611922, 'i', 'w', 7529522, '1', '2022-02-08', 'int'),
('2122', 'int', 11, 4, 7529522, 'i', 'z', 8611922, '0', '2022-02-08', 'int'),
('2122', 'int', 11, 5, 7292043, 'i', 'w', 6572511, '0', '2022-02-08', 'int'),
('2122', 'int', 11, 5, 6572511, 'i', 'z', 7292043, '1', '2022-02-08', 'int'),
('2122', 'int', 11, 6, 8750093, 'i', 'w', 6212404, '1', '2022-02-08', 'int'),
('2122', 'int', 11, 6, 6212404, 'i', 'z', 8750093, '0', '2022-02-08', 'int'),
('2122', 'int', 11, 7, 7904589, 'i', 'w', 7282033, '0', '2022-02-08', 'int'),
('2122', 'int', 11, 7, 7282033, 'i', 'z', 7904589, '1', '2022-02-08', 'int'),
('2122', 'int', 11, 8, 6930957, 'i', 'w', 8587337, '1', '2022-02-08', 'int'),
('2122', 'int', 11, 8, 8587337, 'i', 'z', 6930957, '0', '2022-02-08', 'int'),
('2122', 'int', 11, 9, 7731812, 'i', 'w', 6192098, '1', '2022-02-08', 'int'),
('2122', 'int', 11, 9, 6192098, 'i', 'z', 7731812, '0', '2022-02-08', 'int'),
('2122', 'int', 11, 10, 8372881, 'i', 'w', 7699010, '1', '2022-02-08', 'int'),
('2122', 'int', 11, 10, 7699010, 'i', 'z', 8372881, '0', '2022-02-08', 'int'),
('2122', 'int', 11, 11, 7691728, 'i', 'w', 7518203, '1', '2022-02-08', 'int'),
('2122', 'int', 11, 11, 7518203, 'i', 'z', 7691728, '0', '2022-02-08', 'int'),
('2122', 'int', 11, 12, 7502143, 'i', 'w', 7210137, '1', '2022-02-08', 'int'),
('2122', 'int', 11, 12, 7210137, 'i', 'z', 7502143, '0', '2022-02-08', 'int'),
('2122', 'int', 11, 13, 8400183, 'i', 'w', 8224502, '1', '2022-02-08', 'int'),
('2122', 'int', 11, 13, 8224502, 'i', 'z', 8400183, '0', '2022-02-08', 'int'),
('2122', 'int', 11, 14, 7269834, 'i', 'w', 101, '1', '2022-02-08', 'int'),
('2122', 'int', 11, 14, 101, 'i', 'z', 7269834, '0', '2022-02-08', 'int');

-- KNSB competitie 5 februari 2022
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', '1', '6', '9', '6335670', 'e', 'w', '0', '½', '2022-02-05', 'int'),
('2122', '1', '6', '4', '6483455', 'e', 'z', '0', '0', '2022-02-05', 'int'),
('2122', '1', '6', '2', '7428960', 'e', 'z', '0', '0', '2022-02-05', 'int'),
('2122', '1', '6', '8', '7468417', 'e', 'z', '0', '½', '2022-02-05', 'int'),
('2122', '1', '6', '1', '7584566', 'e', 'w', '0', '1', '2022-02-05', 'int'),
('2122', '1', '6', '3', '7657342', 'e', 'w', '0', '0', '2022-02-05', 'int'),
('2122', '1', '6', '7', '7828183', 'e', 'w', '0', '0', '2022-02-05', 'int'),
('2122', '1', '6', '10', '7879520', 'e', 'z', '0', '½', '2022-02-05', 'int'),
('2122', '1', '6', '6', '8285574', 'e', 'z', '0', '1', '2022-02-05', 'int'),
('2122', '1', '6', '5', '8956805', 'e', 'w', '0', '½', '2022-02-05', 'int'),
('2122', '2', '6', '5', '6225934', 'e', 'w', '0', '1', '2022-02-05', 'int'),
('2122', '2', '6', '1', '7099620', 'e', 'w', '0', '1', '2022-02-05', 'int'),
('2122', '2', '6', '2', '7099950', 'e', 'z', '0', '1', '2022-02-05', 'int'),
('2122', '2', '6', '3', '7129991', 'e', 'w', '0', '0', '2022-02-05', 'int'),
('2122', '2', '6', '4', '7509920', 'e', 'z', '0', '1', '2022-02-05', 'int'),
('2122', '2', '6', '6', '7707832', 'e', 'z', '0', '½', '2022-02-05', 'int'),
('2122', '2', '6', '7', '8112654', 'e', 'w', '0', '½', '2022-02-05', 'int'),
('2122', '2', '6', '8', '8552038', 'e', 'z', '0', '0', '2022-02-05', 'int'),
('2122', '3', '6', '7', '6214153', 'e', 'w', '0', '1', '2022-02-05', 'int'),
('2122', '3', '6', '3', '6572511', 'e', 'w', '0', '1', '2022-02-05', 'int'),
('2122', '3', '6', '6', '7292043', 'e', 'z', '0', '0', '2022-02-05', 'int'),
('2122', '3', '6', '2', '7535385', 'e', 'z', '0', '½', '2022-02-05', 'int'),
('2122', '3', '6', '4', '7699010', 'e', 'z', '0', '½', '2022-02-05', 'int'),
('2122', '3', '6', '1', '7758014', 'e', 'w', '0', '½', '2022-02-05', 'int'),
('2122', '3', '6', '8', '8587337', 'e', 'z', '0', '1', '2022-02-05', 'int'),
('2122', '3', '6', '5', '8611922', 'e', 'w', '0', '1', '2022-02-05', 'int'),
('2122', '4', '5', '1', '8750093', 'e', 'w', '0', '½', '2022-02-05', 'int'),
('2122', '4', '5', '2', '7282033', 'e', 'z', '0', '0', '2022-02-05', 'int'),
('2122', '4', '5', '3', '7904589', 'e', 'w', '0', '1', '2022-02-05', 'int'),
('2122', '4', '5', '4', '6951362', 'e', 'z', '0', '1', '2022-02-05', 'int'),
('2122', '4', '5', '5', '6212404', 'e', 'w', '0', '1', '2022-02-05', 'int'),
('2122', '4', '5', '6', '8485059', 'e', 'z', '0', '1', '2022-02-05', 'int'),
('2122', '4', '5', '7', '7691728', 'e', 'w', '0', '1', '2022-02-05', 'int'),
('2122', '4', '5', '8', '8587348', 'e', 'z', '0', '0', '2022-02-05', 'int');

-- ronde 12
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'int', 12, 0, 102, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 105, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 111, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 113, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 114, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 115, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 116, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 118, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 119, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 120, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 6187885, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 6225934, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 6335670, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 6483455, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 6951362, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7063881, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7079743, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7099620, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7129991, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7292043, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7321534, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7399469, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7419621, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7428960, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7468362, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7468417, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7504310, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7509920, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7535385, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7561653, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7582102, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7584566, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7613166, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7640798, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7649213, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7657342, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7665834, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7707084, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7707832, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7809285, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7824674, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7828183, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7879520, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 7904589, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 8073978, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 8096242, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 8180810, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 8193548, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 8276752, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 8285574, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 8305473, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 8335415, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 8372881, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 8484443, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 8485059, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 8552038, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 8617367, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 8865549, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 0, 8956805, 'a', '', 0, '', '2022-02-15', 'int'),
('2122', 'int', 12, 1, 101, 'i', 'w', 8931098, '0', '2022-02-15', 'int'),
('2122', 'int', 12, 1, 8931098, 'i', 'z', 101, '1', '2022-02-15', 'int'),
('2122', 'int', 12, 2, 8611922, 'i', 'w', 7099950, '½', '2022-02-15', 'int'),
('2122', 'int', 12, 2, 7099950, 'i', 'z', 8611922, '½', '2022-02-15', 'int'),
('2122', 'int', 12, 3, 7535396, 'i', 'w', 8750093, '1', '2022-02-15', 'int'),
('2122', 'int', 12, 3, 8750093, 'i', 'z', 7535396, '0', '2022-02-15', 'int'),
('2122', 'int', 12, 4, 8112654, 'i', 'w', 7758014, '0', '2022-02-15', 'int'),
('2122', 'int', 12, 4, 7758014, 'i', 'z', 8112654, '1', '2022-02-15', 'int'),
('2122', 'int', 12, 5, 6572511, 'i', 'w', 7529522, '0', '2022-02-15', 'int'),
('2122', 'int', 12, 5, 7529522, 'i', 'z', 6572511, '1', '2022-02-15', 'int'),
('2122', 'int', 12, 6, 7282033, 'i', 'w', 6930957, '1', '2022-02-15', 'int'),
('2122', 'int', 12, 6, 6930957, 'i', 'z', 7282033, '0', '2022-02-15', 'int'),
('2122', 'int', 12, 7, 7970094, 'i', 'w', 7731812, '1', '2022-02-15', 'int'),
('2122', 'int', 12, 7, 7731812, 'i', 'z', 7970094, '0', '2022-02-15', 'int'),
('2122', 'int', 12, 8, 6212404, 'i', 'w', 7691728, '1', '2022-02-15', 'int'),
('2122', 'int', 12, 8, 7691728, 'i', 'z', 6212404, '0', '2022-02-15', 'int'),
('2122', 'int', 12, 9, 8587337, 'i', 'w', 7502143, '1', '2022-02-15', 'int'),
('2122', 'int', 12, 9, 7502143, 'i', 'z', 8587337, '0', '2022-02-15', 'int'),
('2122', 'int', 12, 10, 6214153, 'i', 'w', 6192098, '1', '2022-02-15', 'int'),
('2122', 'int', 12, 10, 6192098, 'i', 'z', 6214153, '0', '2022-02-15', 'int'),
('2122', 'int', 12, 11, 7699010, 'i', 'w', 8400183, '1', '2022-02-15', 'int'),
('2122', 'int', 12, 11, 8400183, 'i', 'z', 7699010, '0', '2022-02-15', 'int'),
('2122', 'int', 12, 12, 7210137, 'i', 'w', 7544438, '0', '2022-02-15', 'int'),
('2122', 'int', 12, 12, 7544438, 'i', 'z', 7210137, '1', '2022-02-15', 'int'),
('2122', 'int', 12, 13, 7518203, 'i', 'w', 7269834, '1', '2022-02-15', 'int'),
('2122', 'int', 12, 13, 7269834, 'i', 'z', 7518203, '0', '2022-02-15', 'int'),
('2122', 'int', 12, 14, 8224502, 'i', 'w', 8472530, '1', '2022-02-15', 'int'),
('2122', 'int', 12, 14, 8472530, 'i', 'z', 8224502, '0', '2022-02-15', 'int'),
('2122', 'int', 12, 15, 117, 'i', 'w', 103, '0', '2022-02-15', 'int'),
('2122', 'int', 12, 15, 103, 'i', 'z', 117, '1', '2022-02-15', 'int');

-- ronde 4, 5 en 6 rapid op 22 februari TODO PvD
delete from uitslag where seizoen = '2122' and teamCode = 'ira' and rondeNummer = 4;

insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'ira', 4, 0, 105, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 113, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 117, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 118, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 119, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 120, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 121, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 122, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 6212404, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 6225934, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 6483455, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 6951362, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 7099620, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 7099950, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 7129991, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 7428960, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 7535385, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 7544438, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 7561653, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 7582102, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 7584566, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 7640798, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 7649213, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 7691728, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 7699010, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 7731812, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 7758014, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 7879520, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 7904589, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 8073978, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 8096242, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 8224502, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 8276752, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 8305473, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 8400183, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 8472530, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 8865549, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 8931098, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 0, 8956805, 'a', '', 0, '', '2022-02-22', 'ira'),
('2122', 'ira', 4, 1, 8611922, 'i', 'w', 7707832, '0', '2022-02-22', 'ira'),
('2122', 'ira', 4, 1, 7707832, 'i', 'z', 8611922, '1', '2022-02-22', 'ira'),
('2122', 'ira', 4, 2, 6214153, 'i', 'w', 6572511, '0', '2022-02-22', 'ira'),
('2122', 'ira', 4, 2, 6572511, 'i', 'z', 6214153, '1', '2022-02-22', 'ira'),
('2122', 'ira', 4, 3, 7282033, 'i', 'w', 7502143, '1', '2022-02-22', 'ira'),
('2122', 'ira', 4, 3, 7502143, 'i', 'z', 7282033, '0', '2022-02-22', 'ira'),
('2122', 'ira', 4, 4, 8587337, 'i', 'w', 8750093, '0', '2022-02-22', 'ira'),
('2122', 'ira', 4, 4, 8750093, 'i', 'z', 8587337, '1', '2022-02-22', 'ira'),
('2122', 'ira', 4, 5, 7613166, 'i', 'w', 6192098, '1', '2022-02-22', 'ira'),
('2122', 'ira', 4, 5, 6192098, 'i', 'z', 7613166, '0', '2022-02-22', 'ira'),
('2122', 'ira', 4, 6, 8112654, 'i', 'w', 7970094, '0', '2022-02-22', 'ira'),
('2122', 'ira', 4, 6, 7970094, 'i', 'z', 8112654, '1', '2022-02-22', 'ira'),
('2122', 'ira', 4, 7, 7518203, 'i', 'w', 7292043, '1', '2022-02-22', 'ira'),
('2122', 'ira', 4, 7, 7292043, 'i', 'z', 7518203, '0', '2022-02-22', 'ira'),
('2122', 'ira', 4, 8, 101, 'i', 'w', 7269834, '0', '2022-02-22', 'ira'),
('2122', 'ira', 4, 8, 7269834, 'i', 'z', 101, '1', '2022-02-22', 'ira'),
('2122', 'ira', 4, 9, 7529522, 'i', 'w', 7399469, '1', '2022-02-22', 'ira'),
('2122', 'ira', 4, 9, 7399469, 'i', 'z', 7529522, '0', '2022-02-22', 'ira'),
('2122', 'ira', 4, 10, 7824674, 'i', 'w', 7535396, '0', '2022-02-22', 'ira'),
('2122', 'ira', 4, 10, 7535396, 'i', 'z', 7824674, '1', '2022-02-22', 'ira'),
('2122', 'ira', 4, 11, 7210137, 'i', 'w', 8372881, '1', '2022-02-22', 'ira'),
('2122', 'ira', 4, 11, 8372881, 'i', 'z', 7210137, '0', '2022-02-22', 'ira'),
('2122', 'ira', 4, 12, 7321534, 'i', 'w', 8485059, '0', '2022-02-22', 'ira'),
('2122', 'ira', 4, 12, 8485059, 'i', 'z', 7321534, '1', '2022-02-22', 'ira'),
('2122', 'ira', 4, 13, 103, 'i', 'w', 102, '½', '2022-02-22', 'ira'),
('2122', 'ira', 4, 13, 102, 'i', 'z', 103, '½', '2022-02-22', 'ira');

-- Waagtoren n4 op 28 februari 2022
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'n4', '5', '3', '6212404', 'e', 'w', '0', '½', '2022-02-28', 'int'),
('2122', 'n4', '5', '1', '8750093', 'e', 'w', '0', '½', '2022-02-28', 'int'),
('2122', 'n4', '5', '2', '7399469', 'e', 'z', '0', '0', '2022-02-28', 'int'),
('2122', 'n4', '5', '4', '8485059', 'e', 'z', '0', '0', '2022-02-28', 'int'),
('2122', 'n4', '5', '5', '7518203', 'e', 'w', '0', '½', '2022-02-28', 'int'),
('2122', 'n4', '5', '6', '7321534', 'e', 'z', '0', '0', '2022-02-28', 'int');

-- Waagtoren n1 op 8 februari 2022 tijdens ronde 13
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'n1', '5', '2', '7879520', 'e', 'z', '0', '0', '2022-03-01', 'int'),
('2122', 'n1', '5', '7', '8112654', 'e', 'w', '0', '1', '2022-03-01', 'int'),
('2122', 'n1', '5', '1', '6483455', 'e', 'w', '0', '1', '2022-03-01', 'int'),
('2122', 'n1', '5', '3', '7970094', 'e', 'w', '0', '1', '2022-03-01', 'int'),
('2122', 'n1', '5', '4', '7428960', 'e', 'z', '0', '0', '2022-03-01', 'int'),
('2122', 'n1', '5', '5', '6225934', 'e', 'w', '0', '0', '2022-03-01', 'int'),
('2122', 'n1', '5', '6', '7129991', 'e', 'z', '0', '0', '2022-03-01', 'int'),
('2122', 'n1', '5', '8', '7707832', 'e', 'z', '0', '0', '2022-03-01', 'int');

-- ronde 13
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
  ('2122', 'int', 13, 0, 102, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 105, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 111, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 113, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 114, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 115, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 116, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 117, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 118, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 6187885, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 6335670, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 6930957, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 6951362, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7063881, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7079743, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7099620, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7099950, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7282033, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7399469, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7419621, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7468362, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7468417, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7504310, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7509920, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7518203, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7535385, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7544438, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7561653, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7582102, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7584566, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7640798, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7649213, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7657342, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7665834, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7699010, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7707084, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7809285, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7824674, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7828183, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 8096242, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 8180810, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 8193548, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 8276752, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 8285574, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 8305473, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 8335415, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 8484443, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 8485059, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 8552038, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 8587337, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 8617367, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 8931098, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 8956805, 'a', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 6225934, 'e', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 6483455, 'e', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7129991, 'e', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7428960, 'e', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7707832, 'e', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7879520, 'e', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 7970094, 'e', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 0, 8112654, 'e', '', 0, '', '2022-03-01', 'int'),
  ('2122', 'int', 13, 1, 120, 'i', 'w', 103, '0', '2022-03-01', 'int'),
  ('2122', 'int', 13, 1, 103, 'i', 'z', 120, '1', '2022-03-01', 'int'),
  ('2122', 'int', 13, 2, 6212404, 'i', 'w', 8611922, '0', '2022-03-01', 'int'),
  ('2122', 'int', 13, 2, 8611922, 'i', 'z', 6212404, '1', '2022-03-01', 'int'),
  ('2122', 'int', 13, 3, 7292043, 'i', 'w', 7535396, '0', '2022-03-01', 'int'),
  ('2122', 'int', 13, 3, 7535396, 'i', 'z', 7292043, '1', '2022-03-01', 'int'),
  ('2122', 'int', 13, 4, 6572511, 'i', 'w', 7758014, '½', '2022-03-01', 'int'),
  ('2122', 'int', 13, 4, 7758014, 'i', 'z', 6572511, '½', '2022-03-01', 'int'),
  ('2122', 'int', 13, 5, 8750093, 'i', 'w', 7529522, '½', '2022-03-01', 'int'),
  ('2122', 'int', 13, 5, 7529522, 'i', 'z', 8750093, '½', '2022-03-01', 'int'),
  ('2122', 'int', 13, 6, 7731812, 'i', 'w', 8372881, '1', '2022-03-01', 'int'),
  ('2122', 'int', 13, 6, 8372881, 'i', 'z', 7731812, '0', '2022-03-01', 'int'),
  ('2122', 'int', 13, 7, 6214153, 'i', 'w', 7691728, '1', '2022-03-01', 'int'),
  ('2122', 'int', 13, 7, 7691728, 'i', 'z', 6214153, '0', '2022-03-01', 'int'),
  ('2122', 'int', 13, 8, 8400183, 'i', 'w', 7904589, '1', '2022-03-01', 'int'),
  ('2122', 'int', 13, 8, 7904589, 'i', 'z', 8400183, '0', '2022-03-01', 'int'),
  ('2122', 'int', 13, 9, 7502143, 'i', 'w', 7613166, '0', '2022-03-01', 'int'),
  ('2122', 'int', 13, 9, 7613166, 'i', 'z', 7502143, '1', '2022-03-01', 'int'),
  ('2122', 'int', 13, 10, 6192098, 'i', 'w', 7321534, '0', '2022-03-01', 'int'),
  ('2122', 'int', 13, 10, 7321534, 'i', 'z', 6192098, '1', '2022-03-01', 'int'),
  ('2122', 'int', 13, 11, 7210137, 'i', 'w', 8224502, '½', '2022-03-01', 'int'),
  ('2122', 'int', 13, 11, 8224502, 'i', 'z', 7210137, '½', '2022-03-01', 'int'),
  ('2122', 'int', 13, 12, 7269834, 'i', 'w', 8073978, '1', '2022-03-01', 'int'),
  ('2122', 'int', 13, 12, 8073978, 'i', 'z', 7269834, '0', '2022-03-01', 'int'),
  ('2122', 'int', 13, 13, 101, 'i', 'w', 8472530, '0', '2022-03-01', 'int'),
  ('2122', 'int', 13, 13, 8472530, 'i', 'z', 101, '1', '2022-03-01', 'int'),
  ('2122', 'int', 13, 14, 119, 'i', 'w', 8865549, '0', '2022-03-01', 'int'),
  ('2122', 'int', 13, 14, 8865549, 'i', 'z', 119, '1', '2022-03-01', 'int');

-- ronde 14
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
 ('2122', 'int', 14, 0, 102, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 111, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 113, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 114, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 115, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 116, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 118, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 119, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 6187885, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 6225934, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 6335670, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 6483455, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 6930957, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7063881, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7079743, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7099620, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7129991, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7282033, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7419621, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7428960, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7468362, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7468417, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7504310, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7509920, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7535385, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7535396, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7561653, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7582102, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7584566, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7640798, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7649213, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7657342, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7665834, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7699010, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7707084, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7707832, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7809285, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7824674, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7828183, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7879520, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7904589, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7970094, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 8096242, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 8180810, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 8193548, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 8285574, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 8305473, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 8335415, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 8472530, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 8484443, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 8485059, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 8552038, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 8587337, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 8617367, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 8931098, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 8956805, 'a', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 0, 7731812, 'o', '', 0, '', '2022-03-08', 'int'),
 ('2122', 'int', 14, 1, 101, 'i', 'w', 120, '1', '2022-03-08', 'int'),
 ('2122', 'int', 14, 1, 120, 'i', 'z', 101, '0', '2022-03-08', 'int'),
 ('2122', 'int', 14, 2, 7758014, 'i', 'w', 7099950, '0', '2022-03-08', 'int'),
 ('2122', 'int', 14, 2, 7099950, 'i', 'z', 7758014, '1', '2022-03-08', 'int'),
 ('2122', 'int', 14, 3, 8112654, 'i', 'w', 8611922, '0', '2022-03-08', 'int'),
 ('2122', 'int', 14, 3, 8611922, 'i', 'z', 8112654, '1', '2022-03-08', 'int'),
 ('2122', 'int', 14, 4, 7529522, 'i', 'w', 7292043, '1', '2022-03-08', 'int'),
 ('2122', 'int', 14, 4, 7292043, 'i', 'z', 7529522, '0', '2022-03-08', 'int'),
 ('2122', 'int', 14, 5, 8750093, 'i', 'w', 6572511, '1', '2022-03-08', 'int'),
 ('2122', 'int', 14, 5, 6572511, 'i', 'z', 8750093, '0', '2022-03-08', 'int'),
 ('2122', 'int', 14, 6, 6214153, 'i', 'w', 6212404, '1', '2022-03-08', 'int'),
 ('2122', 'int', 14, 6, 6212404, 'i', 'z', 6214153, '0', '2022-03-08', 'int'),
 ('2122', 'int', 14, 7, 6951362, 'i', 'w', 7399469, '1', '2022-03-08', 'int'),
 ('2122', 'int', 14, 7, 7399469, 'i', 'z', 6951362, '0', '2022-03-08', 'int'),
 ('2122', 'int', 14, 8, 7321534, 'i', 'w', 8400183, '0', '2022-03-08', 'int'),
 ('2122', 'int', 14, 8, 8400183, 'i', 'z', 7321534, '1', '2022-03-08', 'int'),
 ('2122', 'int', 14, 9, 7613166, 'i', 'w', 8372881, '0', '2022-03-08', 'int'),
 ('2122', 'int', 14, 9, 8372881, 'i', 'z', 7613166, '1', '2022-03-08', 'int'),
 ('2122', 'int', 14, 10, 8276752, 'i', 'w', 7544438, '½', '2022-03-08', 'int'),
 ('2122', 'int', 14, 10, 7544438, 'i', 'z', 8276752, '½', '2022-03-08', 'int'),
 ('2122', 'int', 14, 11, 7502143, 'i', 'w', 7518203, '½', '2022-03-08', 'int'),
 ('2122', 'int', 14, 11, 7518203, 'i', 'z', 7502143, '½', '2022-03-08', 'int'),
 ('2122', 'int', 14, 12, 7691728, 'i', 'w', 8224502, '0', '2022-03-08', 'int'),
 ('2122', 'int', 14, 12, 8224502, 'i', 'z', 7691728, '1', '2022-03-08', 'int'),
 ('2122', 'int', 14, 13, 6192098, 'i', 'w', 7210137, '0', '2022-03-08', 'int'),
 ('2122', 'int', 14, 13, 7210137, 'i', 'z', 6192098, '1', '2022-03-08', 'int'),
 ('2122', 'int', 14, 14, 117, 'i', 'w', 7269834, '0', '2022-03-08', 'int'),
 ('2122', 'int', 14, 14, 7269834, 'i', 'z', 117, '1', '2022-03-08', 'int'),
 ('2122', 'int', 14, 15, 103, 'i', 'w', 8073978, '0', '2022-03-08', 'int'),
 ('2122', 'int', 14, 15, 8073978, 'i', 'z', 103, '1', '2022-03-08', 'int'),
 ('2122', 'int', 14, 16, 105, 'i', 'w', 8865549, '1', '2022-03-08', 'int'),
 ('2122', 'int', 14, 16, 8865549, 'i', 'z', 105, '0', '2022-03-08', 'int');

-- KNSB competitie 12 maart 2022
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', '1', '7', '5', '7428960', 'e', 'z', '0', '1', '2022-03-12', 'int'),
('2122', '1', '7', '1', '7584566', 'e', 'z', '0', '1', '2022-03-12', 'int'),
('2122', '1', '7', '2', '7657342', 'e', 'w', '0', '½', '2022-03-12', 'int'),
('2122', '1', '7', '3', '8956805', 'e', 'z', '0', '½', '2022-03-12', 'int'),
('2122', '1', '7', '4', '8180810', 'e', 'w', '0', '½', '2022-03-12', 'int'),
('2122', '1', '7', '6', '8285574', 'e', 'w', '0', '½', '2022-03-12', 'int'),
('2122', '1', '7', '7', '6335670', 'e', 'z', '0', '½', '2022-03-12', 'int'),
('2122', '1', '7', '8', '7468417', 'e', 'w', '0', '1', '2022-03-12', 'int'),
('2122', '1', '7', '9', 1, 'e', 'z', '0', '½', '2022-03-12', 'int'),
('2122', '1', '7', '10', 2, 'e', 'w', '0', '½', '2022-03-12', 'int'),
('2122', '2', '7', '1', '7099950', 'e', 'z', '0', '1', '2022-03-12', 'int'),
('2122', '2', '7', '5', '7129991', 'e', 'z', '0', '0', '2022-03-12', 'int'),
('2122', '2', '7', '4', '7509920', 'e', 'w', '0', '1', '2022-03-12', 'int'),
('2122', '2', '7', '2', '7099620', 'e', 'w', '0', '1', '2022-03-12', 'int'),
('2122', '2', '7', '3', '7879520', 'e', 'z', '0', '1', '2022-03-12', 'int'),
('2122', '2', '7', '6', '7707832', 'e', 'w', '0', '1', '2022-03-12', 'int'),
('2122', '2', '7', '7', '7904589', 'e', 'z', '0', '0', '2022-03-12', 'int'),
('2122', '2', '7', '8', '8112654', 'e', 'w', '0', '0', '2022-03-12', 'int'),
('2122', '3', '7', '2', '6572511', 'e', 'w', '0', '½', '2022-03-12', 'int'),
('2122', '3', '7', '3', '7758014', 'e', 'z', '0', '½', '2022-03-12', 'int'),
('2122', '3', '7', '1', '8611922', 'e', 'z', '0', '0', '2022-03-12', 'int'),
('2122', '3', '7', '4', '8587337', 'e', 'w', '0', '0', '2022-03-12', 'int'),
('2122', '3', '7', '5', '8484443', 'e', 'z', '0', '1', '2022-03-12', 'int'),
('2122', '3', '7', '6', '7504310', 'e', 'w', '0', '0', '2022-03-12', 'int'),
('2122', '3', '7', '7', '8750093', 'e', 'z', '0', '1', '2022-03-12', 'int'),
('2122', '3', '7', '8', '7649213', 'e', 'w', '0', '1', '2022-03-12', 'int'),
('2122', '4', '6', '5', '6212404', 'e', 'z', '0', '0', '2022-03-12', 'int'),
('2122', '4', '6', '1', '7292043', 'e', 'z', '0', '0', '2022-03-12', 'int'),
('2122', '4', '6', '3', '7809285', 'e', 'z', '0', '1', '2022-03-12', 'int'),
('2122', '4', '6', '2', '6951362', 'e', 'w', '0', '1', '2022-03-12', 'int'),
('2122', '4', '6', '4', '8276752', 'e', 'w', '0', '1', '2022-03-12', 'int'),
('2122', '4', '6', '6', '8485059', 'e', 'w', '0', '1', '2022-03-12', 'int'),
('2122', '4', '6', '7', '7321534', 'e', 'z', '0', '½', '2022-03-12', 'int'),
('2122', '4', '6', '8', '8073978', 'e', 'w', '0', '½', '2022-03-12', 'int');

-- Waagtoren n2 op 15 februari 2022 tijdens ronde 15
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'n2', '5', '3', '7529522', 'e', 'z', '0', '0', '2022-03-15', 'int'),
('2122', 'n2', '5', '4', '7758014', 'e', 'w', '0', '0', '2022-03-15', 'int'),
('2122', 'n2', '5', '2', '1', 'e', 'w', '0', '1', '2022-03-15', 'int'),
('2122', 'n2', '5', '5', '8112654', 'e', 'z', '0', '0', '2022-03-15', 'int'),
('2122', 'n2', '5', '8', '8400183', 'e', 'w', '0', '½', '2022-03-15', 'int'),
('2122', 'n2', '5', '6', '8484443', 'e', 'w', '0', '1', '2022-03-15', 'int'),
('2122', 'n2', '5', '7', '8587337', 'e', 'z', '0', '1', '2022-03-15', 'int'),
('2122', 'n2', '5', '1', '8611922', 'e', 'z', '0', '½', '2022-03-15', 'int');

-- ronde 15
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'int', 15, 0, 102, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 105, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 111, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 113, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 114, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 115, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 116, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 118, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 119, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 120, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 6187885, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 6212404, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 6225934, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 6335670, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 6483455, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 6930957, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7063881, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7079743, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7099620, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7129991, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7282033, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7321534, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7419621, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7428960, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7468362, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7468417, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7504310, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7509920, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7529522, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7535385, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7535396, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7561653, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7582102, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7584566, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7640798, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7657342, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7665834, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7699010, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7707084, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7707832, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7758014, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7809285, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7824674, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7828183, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7879520, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7904589, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 7970094, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8096242, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8112654, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8180810, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8193548, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8224502, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8276752, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8285574, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8305473, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8335415, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8400183, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8472530, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8484443, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8485059, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8552038, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8587337, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8611922, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8617367, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8865549, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8931098, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 0, 8956805, 'a', '', 0, '', '2022-03-15', 'int'),
('2122', 'int', 15, 1, 103, 'i', 'w', 6192098, '0', '2022-03-15', 'int'),
('2122', 'int', 15, 1, 6192098, 'i', 'z', 103, '1', '2022-03-15', 'int'),
('2122', 'int', 15, 2, 7099950, 'i', 'w', 6214153, '1', '2022-03-15', 'int'),
('2122', 'int', 15, 2, 6214153, 'i', 'z', 7099950, '0', '2022-03-15', 'int'),
('2122', 'int', 15, 3, 7292043, 'i', 'w', 8750093, '0', '2022-03-15', 'int'),
('2122', 'int', 15, 3, 8750093, 'i', 'z', 7292043, '1', '2022-03-15', 'int'),
('2122', 'int', 15, 4, 6572511, 'i', 'w', 6951362, '½', '2022-03-15', 'int'),
('2122', 'int', 15, 4, 6951362, 'i', 'z', 6572511, '½', '2022-03-15', 'int'),
('2122', 'int', 15, 5, 7544438, 'i', 'w', 8372881, '0', '2022-03-15', 'int'),
('2122', 'int', 15, 5, 8372881, 'i', 'z', 7544438, '1', '2022-03-15', 'int'),
('2122', 'int', 15, 6, 7210137, 'i', 'w', 7518203, '1', '2022-03-15', 'int'),
('2122', 'int', 15, 6, 7518203, 'i', 'z', 7210137, '0', '2022-03-15', 'int'),
('2122', 'int', 15, 7, 7649213, 'i', 'w', 7613166, '0', '2022-03-15', 'int'),
('2122', 'int', 15, 7, 7613166, 'i', 'z', 7649213, '1', '2022-03-15', 'int'),
('2122', 'int', 15, 8, 7269834, 'i', 'w', 7502143, '½', '2022-03-15', 'int'),
('2122', 'int', 15, 8, 7502143, 'i', 'z', 7269834, '½', '2022-03-15', 'int'),
('2122', 'int', 15, 9, 8073978, 'i', 'w', 7691728, '1', '2022-03-15', 'int'),
('2122', 'int', 15, 9, 7691728, 'i', 'z', 8073978, '0', '2022-03-15', 'int'),
('2122', 'int', 15, 10, 101, 'i', 'w', 117, '½', '2022-03-15', 'int'),
('2122', 'int', 15, 10, 117, 'i', 'z', 101, '½', '2022-03-15', 'int'),
('2122', 'int', 15, 11, 7399469, 'i', 'w', 7731812, '0', '2022-03-15', 'int'),
('2122', 'int', 15, 11, 7731812, 'i', 'z', 7399469, '1', '2022-03-15', 'int');

-- Waagtoren n1 op 21 maart 2022
select * from uitslag where seizoen = '2122' and teamCode = 'n1' and rondeNummer = 6; 
delete from uitslag where seizoen = '2122' and teamCode = 'n1' and rondeNummer = 6; 


insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'n1', '6', '2', '7099950', 'e', 'z', '0', '1', '2022-03-21', 'int'),
('2122', 'n1', '6', '1', '7099620', 'e', 'w', '0', '½', '2022-03-21', 'int'),
('2122', 'n1', '6', '3', '7428960', 'e', 'w', '0', '1', '2022-03-21', 'int'),
('2122', 'n1', '6', '4', '7509920', 'e', 'z', '0', '0', '2022-03-21', 'int'),
('2122', 'n1', '6', '5', '7129991', 'e', 'w', '0', '0', '2022-03-21', 'int'),
('2122', 'n1', '6', '6', '7707832', 'e', 'z', '0', '½', '2022-03-21', 'int'),
('2122', 'n1', '6', '7', '6225934', 'e', 'w', '0', '1', '2022-03-21', 'int'),
('2122', 'n1', '6', '8', '7535385', 'e', 'z', '0', '0', '2022-03-21', 'int');

-- ronde 16
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'int', 16, 0, 102, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 105, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 111, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 113, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 114, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 115, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 116, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 117, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 118, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 119, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 120, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 121, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 6187885, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 6225934, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 6335670, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 6483455, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 6930957, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7063881, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7079743, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7099620, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7129991, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7282033, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7292043, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7399469, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7419621, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7428960, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7468362, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7468417, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7504310, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7509920, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7535385, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7544438, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7561653, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7582102, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7584566, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7640798, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7649213, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7657342, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7665834, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7699010, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7707084, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7707832, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7758014, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7809285, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7824674, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7828183, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7879520, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7904589, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 7970094, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 8096242, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 8112654, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 8180810, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 8193548, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 8276752, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 8285574, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 8305473, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 8335415, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 8472530, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 8484443, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 8485059, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 8552038, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 8587337, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 8617367, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 8931098, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 8956805, 'a', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 0, 101, 'o', '', 0, '', '2022-03-22', 'int'),
('2122', 'int', 16, 1, 7502143, 'i', 'w', 103, '1', '2022-03-22', 'int'),
('2122', 'int', 16, 1, 103, 'i', 'z', 7502143, '0', '2022-03-22', 'int'),
('2122', 'int', 16, 2, 6192098, 'i', 'w', 7269834, '1', '2022-03-22', 'int'),
('2122', 'int', 16, 2, 7269834, 'i', 'z', 6192098, '0', '2022-03-22', 'int'),
('2122', 'int', 16, 3, 8865549, 'i', 'w', 8224502, '½', '2022-03-22', 'int'),
('2122', 'int', 16, 3, 8224502, 'i', 'z', 8865549, '½', '2022-03-22', 'int'),
('2122', 'int', 16, 4, 7535396, 'i', 'w', 7099950, '0', '2022-03-22', 'int'),
('2122', 'int', 16, 4, 7099950, 'i', 'z', 7535396, '1', '2022-03-22', 'int'),
('2122', 'int', 16, 5, 8611922, 'i', 'w', 7731812, '1', '2022-03-22', 'int'),
('2122', 'int', 16, 5, 7731812, 'i', 'z', 8611922, '0', '2022-03-22', 'int'),
('2122', 'int', 16, 6, 8372881, 'i', 'w', 7529522, '1', '2022-03-22', 'int'),
('2122', 'int', 16, 6, 7529522, 'i', 'z', 8372881, '0', '2022-03-22', 'int'),
('2122', 'int', 16, 7, 6214153, 'i', 'w', 6572511, '0', '2022-03-22', 'int'),
('2122', 'int', 16, 7, 6572511, 'i', 'z', 6214153, '1', '2022-03-22', 'int'),
('2122', 'int', 16, 8, 6951362, 'i', 'w', 8400183, '½', '2022-03-22', 'int'),
('2122', 'int', 16, 8, 8400183, 'i', 'z', 6951362, '½', '2022-03-22', 'int'),
('2122', 'int', 16, 9, 7613166, 'i', 'w', 7210137, '1', '2022-03-22', 'int'),
('2122', 'int', 16, 9, 7210137, 'i', 'z', 7613166, '0', '2022-03-22', 'int'),
('2122', 'int', 16, 10, 8073978, 'i', 'w', 6212404, '0', '2022-03-22', 'int'),
('2122', 'int', 16, 10, 6212404, 'i', 'z', 8073978, '1', '2022-03-22', 'int'),
('2122', 'int', 16, 11, 7321534, 'i', 'w', 8750093, '0', '2022-03-22', 'int'),
('2122', 'int', 16, 11, 8750093, 'i', 'z', 7321534, '1', '2022-03-22', 'int'),
('2122', 'int', 16, 12, 7518203, 'i', 'w', 7691728, '1', '2022-03-22', 'int'),
('2122', 'int', 16, 12, 7691728, 'i', 'z', 7518203, '0', '2022-03-22', 'int');

-- ronde 17
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', 'int', 17, 0, 101, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 103, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 121, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 6192098, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 6212404, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 6214153, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 6572511, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 6951362, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7099950, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7269834, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7282033, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7321534, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7502143, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7518203, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7529522, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7535396, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7691728, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7707832, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7731812, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7824674, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8073978, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8372881, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8400183, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8472530, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8611922, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8750093, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8865549, 'm', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 102, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 105, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 111, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 113, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 114, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 115, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 116, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 117, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 118, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 119, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 120, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 6187885, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 6225934, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 6335670, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 6483455, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 6930957, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7063881, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7079743, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7099620, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7129991, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7210137, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7292043, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7399469, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7419621, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7428960, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7468362, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7468417, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7504310, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7509920, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7535385, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7544438, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7561653, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7582102, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7584566, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7613166, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7640798, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7649213, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7657342, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7665834, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7699010, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7707084, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7758014, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7809285, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7828183, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7879520, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7904589, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 7970094, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8096242, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8112654, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8180810, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8193548, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8224502, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8276752, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8285574, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8305473, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8335415, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8484443, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8485059, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8552038, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8587337, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8617367, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8931098, 'n', '', 0, '', '2022-03-29', 'int'),
('2122', 'int', 17, 0, 8956805, 'n', '', 0, '', '2022-03-29', 'int');
 
-- KNSB competitie 2 april 2022
insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values
('2122', '1', '8', '3', '7428960', 'e', 'w', '0', '½', '2022-04-02', 'int'),
('2122', '1', '8', '1', '7584566', 'e', 'w', '0', '1', '2022-04-02', 'int'),
('2122', '1', '8', '2', '7657342', 'e', 'z', '0', '½', '2022-04-02', 'int'),
('2122', '1', '8', '4', '8180810', 'e', 'z', '0', '1', '2022-04-02', 'int'),
('2122', '1', '8', '5', '7468417', 'e', 'w', '0', '½', '2022-04-02', 'int'),
('2122', '1', '8', '6', '7099950', 'e', 'z', '0', '0', '2022-04-02', 'int'),
('2122', '1', '8', '7', '8285574', 'e', 'w', '0', '½', '2022-04-02', 'int'),
('2122', '1', '8', '8', '7535396', 'e', 'z', '0', '0', '2022-04-02', 'int'),
('2122', '1', '8', '9', '8112654', 'e', 'w', '0', '½', '2022-04-02', 'int'),
('2122', '1', '8', '10', '8611922', 'e', 'z', '0', '½', '2022-04-02', 'int'),
('2122', '2', '8', '5', '7129991', 'e', 'w', '0', '0', '2022-04-02', 'int'),
('2122', '2', '8', '3', '7509920', 'e', 'w', '0', '0', '2022-04-02', 'int'),
('2122', '2', '8', '1', '6335670', 'e', 'w', '0', '½', '2022-04-02', 'int'),
('2122', '2', '8', '2', '7099620', 'e', 'z', '0', '0', '2022-04-02', 'int'),
('2122', '2', '8', '4', '7707832', 'e', 'z', '0', '½', '2022-04-02', 'int'),
('2122', '2', '8', '6', '6225934', 'e', 'z', '0', '0', '2022-04-02', 'int'),
('2122', '2', '8', '7', '7879520', 'e', 'w', '0', '0', '2022-04-02', 'int'),
('2122', '2', '8', '8', '8552038', 'e', 'z', '0', '1', '2022-04-02', 'int'),
('2122', '4', '7', '7', '6212404', 'e', 'w', '0', '0', '2022-04-02', 'int'),
('2122', '4', '7', '4', '7292043', 'e', 'z', '0', '0', '2022-04-02', 'int'),
('2122', '4', '7', '2', '7809285', 'e', 'z', '0', '0', '2022-04-02', 'int'),
('2122', '4', '7', '1', '7824674', 'e', 'w', '0', '0', '2022-04-02', 'int'),
('2122', '4', '7', '3', '7904589', 'e', 'w', '0', '0', '2022-04-02', 'int'),
('2122', '4', '7', '5', '7399469', 'e', 'w', '0', '½', '2022-04-02', 'int'),
('2122', '4', '7', '6', '7282033', 'e', 'z', '0', '1', '2022-04-02', 'int'),
('2122', '4', '7', '8', '8400183', 'e', 'z', '0', '1', '2022-04-02', 'int');

-- ronde 18

use waagtoren; -- PvD
select * from uitslag where seizoen = '2122' and teamCode = 'int' and rondeNummer = 18 order by bordnummer, witZwart;
delete from uitslag where seizoen = '2122' and teamCode = 'int' and rondeNummer = 18;

-- insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values

-- KNSB competitie 2 april 2022

use waagtoren; -- PvD
select * from uitslag where seizoen = '2122' and datum = '2022-04-02';
delete from uitslag where seizoen = '2122' and datum = '2022-04-02';

-- insert into uitslag (seizoen, teamCode, rondeNummer, bordNummer, knsbNummer, partij, witZwart, tegenstanderNummer, resultaat, datum, anderTeam) values

-- alle seizoenen
insert into persoon (knsbNummer, naam) values 
(1, 'niemand'),
(2, 'niemand'),
(3, 'niemand'),
(4, 'niemand'),
(5, 'niemand'),
(6, 'niemand'),
(7, 'niemand'),
(8, 'niemand'),
(9, 'niemand'),
(10, 'niemand'), 
(99, 'Peter Glashouwer'),
(101, 'Ramon Witte'),
(102, 'Ellen van der Hoeven'),
(103, 'Charles Stoorvogel'),
(104, 'Sietske de Greeuw'),
(105, 'Richard Meijer'),
(106, 'Abdul Rashid Ayobi'),
(107, 'Joris Beerda'),
(108, 'Aad Schuit'),
(109, 'Ron van den Bogert'),
(110, 'Tansu Madencioglu'),
(111, 'Jorn Visser'),
(112, 'Thea Veldhuis'),
(113, 'Michiel Doodeman'),
(114, 'Bram Vink'),
(115, 'Harm Grouwstra'),
(116, 'Ruard Born'),
(117, 'Kees van Kuipers'),
(118, 'Welmoed Groot Kormelink'),
(119, 'Randy Roest'),
(120, 'Emiel Heinis'),
(121, 'Nol den Bekker'), 
(122, 'Olia Lutsiv'), -- PvD
('6187885', 'Bob de Mon'),
('6192098', 'Nico Brugman'),
('6212404', 'Peter van Diepen'),
('6214153', 'Jan Poland'),
('6225934', 'Ruud Adema'),
('6335670', 'Hebert Perez Garcia'),
('6483455', 'Jeroen Smorenberg'),
('6572511', 'Bert Buitink'),
('6661721', 'Herman Nijhuis'),
('6930957', 'Leo van Steenoven'),
('6951362', 'Johan Plooijer'),
('7063881', 'Wim van Dijk'),
('7079743', 'Juan de Roda Husman'),
('7099620', 'Peter Hoekstra'),
('7099950', 'Jos Vlaming'),
('7129991', 'Gerard de Geus'),
('7210137', 'Arjen Dibbets'),
('7227264', 'Kiek Schouten'),
('7269834', 'Arie Boots'),
('7269900', 'Jan Ens'),
('7282033', 'Gerrit Lemmen'),
('7292043', 'Rob Freer'),
('7321534', 'Ronald Kamps'),
('7399469', 'Nico Mak'),
('7419621', 'Frits Leenart'),
('7428960', 'Frank Agter'),
('7468362', 'Paul Toepoel'),
('7468417', 'Daan Geerke'),
('7502143', 'Rob Heijink'),
('7504310', 'Leonard Haakman'),
('7509920', 'Dirk van der Meiden'),
('7518203', 'Theo de Bruijn'),
('7529522', 'Willem Meyles'),
('7535385', 'Marten Coerts'),
('7535396', 'John Leek'),
('7544438', 'Fred Driesse'),
('7546242', 'Ronald Brink'),
('7561653', 'Mariska de Mie'),
('7566031', 'Corné van der Horst'),
('7579154', 'Robbert Waas'),
('7582102', 'Onno Vellinga'),
('7584566', 'Yong Hoon de Rover'),
('7640798', 'Johan Wester'),
('7649213', 'Dick Bouma'),
('7657342', 'Frank van Tellingen'),
('7665834', 'David Baanstra'),
('7691728', 'Karel Beentjes'),
('7699010', 'Ruud Niewenhuis'),
('7701122', 'Jan Drewes'),
('7707084', 'Ralph Versluis'),
('7707832', 'Ronald Groot'),
('7731812', 'Alexander Versluis'),
('7739314', 'Piet Pover'),
('7758014', 'Alex Albrecht'),
('7771665', 'Yvonne Schol'),
('7809285', 'Albert van der Meiden'),
('7824674', 'Guido Florijn'),
('7828183', 'Rob Konijn'),
('7879520', 'Vincent Pandelaar'),
('7904589', 'Wim Nieland'),
('7970094', 'Danny de Ruiter'),
('8073978', 'Gerrit Peereboom'),
('8096242', 'Michael van Liempt'),
('8112654', 'Ton Fasel'),
('8144191', 'Gerard Brouwers'),
('8180810', 'Midas Ratsma'),
('8182416', 'Andre Bremmers'),
('8193548', 'Daan de Vries'),
('8224502', 'Jan van Gijsen'),
('8243312', 'Harry Sluiter'),
('8271560', 'Bernard Mohl'),
('8276752', 'Theo Bakker'),
('8285574', 'Maaike Keetman'),
('8291877', 'Jawdat Adib'),
('8305473', 'Klaas Silver'),
('8314834', 'Henk Kleijn'),
('8323029', 'Runa de Vries'),
('8335415', 'Koos de Graaf'),
('8363982', 'Afshin Mehnavian'),
('8372881', 'Egbert van Oene'),
('8400183', 'Daan de Vetten'),
('8461354', 'Luuk van Steenoven'),
('8472409', 'Klaas Jan Koedijk'),
('8472530', 'Rosa Leek'),
('8484443', 'Chaim Bookelman'),
('8485059', 'Peter Duijs'),
('8505585', 'Max Bookelman'),
('8521480', 'Julian de Boer'),
('8536319', 'Jonathan Venema'),
('8544646', 'José van der Donk'),
('8547110', 'Milan de Boer'),
('8547946', 'Sander Meijer'),
('8552038', 'Kevin Brands'),
('8571453', 'Marit de Boer'),
('8580374', 'Jos Bakker'),
('8580385', 'Han Rauws'),
('8587337', 'Max Hooijmans'),
('8587348', 'Merijn Hooijmans'),
('8611922', 'Tycho Bakker'),
('8617367', 'Arend Noordam'),
('8716972', 'Gijs Schaveling'),
('8750093', 'Martin Rep'),
('8773633', 'Gerard Kortooms'),
('8827588', 'Roel Boesenkool'),
('8865549', 'Erno Brouwer'),
('8931098', 'Sander Jagersma'),
(8956805, 'Vjekoslav Nemec');