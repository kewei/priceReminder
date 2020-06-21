-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 30, 2017 at 09:23 AM
-- Server version: 5.5.49-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `pricereminder`
--

-- --------------------------------------------------------

--
-- Table structure for table `cdon`
--

CREATE TABLE IF NOT EXISTS `cdon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `price` varchar(16) NOT NULL,
  `image` varchar(512) NOT NULL,
  `url` varchar(512) NOT NULL,
  `status` varchar(128) DEFAULT NULL,
  `category` varchar(32) DEFAULT NULL,
  `company` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `cdon`
--

INSERT INTO `cdon` (`id`, `title`, `description`, `price`, `image`, `url`, `status`, `category`, `company`) VALUES
(1, 'Asus GL552VW-CN298T 15.6" Bärbar dator (svart)', 'Intel® Core™ i5-6300HQ 8 GB RAM  NVIDIA GeForce GTX 960M - 2 GB 1 TB HDD  Microsoft Windows 10 ', '7990SEK', 'http://dizw242ufxqut.cloudfront.net/images/product/laptops/laptopsdefault/image4/15inch_asus_gl552vw-cn298t_156_i5-6300hq8gb1000gbnvidia_gtx960-2gbw10_gaming-35111510-1.jpg', 'http://cdon.se/hemelektronik/asus-gl552vw-cn298t-15-6-barbar-dator-svart-p35111510', 'InStock', 'Hemelektronik', 'CDON');

-- --------------------------------------------------------

--
-- Table structure for table `dustinhome`
--

CREATE TABLE IF NOT EXISTS `dustinhome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `price` varchar(16) NOT NULL,
  `image` varchar(512) NOT NULL,
  `url` varchar(512) NOT NULL,
  `status` varchar(128) DEFAULT NULL,
  `category` varchar(32) DEFAULT NULL,
  `company` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `dustinhome`
--

INSERT INTO `dustinhome` (`id`, `title`, `description`, `price`, `image`, `url`, `status`, `category`, `company`) VALUES
(15, 'DGS-105 5-Port Gigabit Desktop Switch', 'DGS-105 5-Port Gigabit Desktop Switch', '99SEK', '//media.dustin.eu/image/37542/400/320/d-link-dgs-105-5-port-gigabit-desktop-switch.jpg', 'https://www.dustinhome.se/product/5010620335/dgs-105-5-port-gigabit-desktop-switch', 'Lagerstatus:  Skickas omgående   +10 kvar  ', 'Nätverk', 'Dustinhome');

-- --------------------------------------------------------

--
-- Table structure for table `elgiganten`
--

CREATE TABLE IF NOT EXISTS `elgiganten` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `price` varchar(16) NOT NULL,
  `image` varchar(512) NOT NULL,
  `url` varchar(512) NOT NULL,
  `status` varchar(128) DEFAULT NULL,
  `category` varchar(32) DEFAULT NULL,
  `company` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `elgiganten`
--

INSERT INTO `elgiganten` (`id`, `title`, `description`, `price`, `image`, `url`, `status`, `category`, `company`) VALUES
(1, 'LG 55'''' Smart LED-TV 55UF772V', 'Smart LED-TV med UHD-upplösning, inbyggt Wi-Fi och intuitiv Magic Remote.', '7690SEK', 'http://tubby.scene7.com/is/image/tubby/55UF772V?$prod$', 'http://www.elgiganten.se/product/ljud-bild/tv/55UF772V/lg-55-smart-led-tv-55uf772v', 'Webblager (100+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Ljud & Bild', 'Elgiganten'),
(2, 'Weber Compact 57 Kolgrill', 'Kompakt kolgrill från Weber som är lätt att använda och ger en autentisk grillupplevelse. 57 cm bred grillplatta.', '1195SEK', 'http://tubby.scene7.com/is/image/tubby/WEB1321004?$prod$', 'http://www.elgiganten.se/product/hem-och-hushall/grill-och-sommarprodukter/WEB1321004/weber-compact-57-kolgrill', 'Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Hem och Hushåll', 'Elgiganten'),
(3, 'Sandstrøm Aircondition SAC07C15E', 'Praktisk, flyttbar luftkonditionering till mindre rum upp till 14 m2. Kylkapacitet på 7000 Btu/h.', '2995SEK', 'http://tubby.scene7.com/is/image/tubby/SAC07C15E?$prod$', 'http://www.elgiganten.se/product/hem-och-hushall/grill-och-sommarprodukter/SAC07C15E/sandstrom-aircondition-sac07c15e', 'Webblager (25+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Hem och Hushåll', 'Elgiganten'),
(4, 'Robomow Robotgräsklippare MS1800', 'Robomow är ett kraftfullt verktyg till trädgården som klipper gräset åt dig. Den kommer med Bluetooth-kontroll och smarta säkerhetsfunktioner.', '16490SEK', 'http://tubby.scene7.com/is/image/tubby/MS1800BLACK?$prod$', 'http://www.elgiganten.se/product/hem-och-hushall/grill-och-sommarprodukter/MS1800BLACK/robomow-robotgrasklippare-ms1800', 'Webblager (100+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Hem och Hushåll', 'Elgiganten'),
(5, 'Nordic Season Smögen kolgrill KG2150242', 'Nordic Season Smögen är en stor kolgrill med många funktioner och nedvikbara sidobord och värmehylla.', '1995SEK', 'http://tubby.scene7.com/is/image/tubby/KG2150242?$prod$', 'http://www.elgiganten.se/product/hem-och-hushall/grill-och-sommarprodukter/KG2150242/nordic-season-smogen-kolgrill-kg2150242', 'Webblager (100+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Hem och Hushåll', 'Elgiganten'),
(6, 'Nordic Season Grillöverdrag (XXL)', 'Universalt gasolgrill- överdrag i storlek XXL. Grillöverdraget skyddar din gasolgrill mot regn och smuts.', '599SEK', 'http://tubby.scene7.com/is/image/tubby/GT130101E?$prod$', 'http://www.elgiganten.se/product/hem-och-hushall/grill-och-sommarprodukter/GT130101E/nordic-season-grilloverdrag-xxl', 'Webblager (100+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Hem och Hushåll', 'Elgiganten'),
(7, 'Samsung 55" 4K UHD Smart TV UE55KU6075', 'Samsung 55" LED Smart TV UE50KU6075XXE kommer med levande högkvalité-bilder med optimerad färg och skarphet, passar alla moderna hushåll med sin slimmade och snygga design.', '7990SEK', 'http://tubby.scene7.com/is/image/tubby/UE55KU6075XXE?$prod$', 'http://www.elgiganten.se/product/ljud-bild/tv/UE55KU6075XXE/samsung-55-4k-uhd-smart-tv-ue55ku6075', 'Webblager (100+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Ljud & Bild', 'Elgiganten'),
(8, 'Logitech Z623 Datorhögtalare', 'Datorhögtalare med THX-certifierat 2.1 system som ger stort kraftfullt ljud.', '1290SEK', 'http://tubby.scene7.com/is/image/tubby/LTZ623?$prod$', 'http://www.elgiganten.se/product/datorer-tillbehor/datorhogtalare/LTZ623/logitech-z623-datorhogtalare', 'Webblager (100+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Datorer & Tillbehör', 'Elgiganten'),
(9, 'Logitech Högtalarsystem Z906', 'Hör varje detalj, runt om hela dig. THX-certifierat 5.1 högtalarsystem som ger dig biokänsla när du kollar dina filmer.', '2790SEK', 'http://tubby.scene7.com/is/image/tubby/LTZ906?$prod$', 'http://www.elgiganten.se/product/datorer-tillbehor/datorhogtalare/LTZ906/logitech-hogtalarsystem-z906', 'Webblager (100+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Datorer & Tillbehör', 'Elgiganten'),
(10, 'Belkin USB kabel USB-C till Micro USB 2 m (svart)', 'Med denna USB-kabel kan du ansluta enheter med Micro USB till USB typ C. Kabeln har stöd för överföringshastighet upp till 480 MB per sekund.', '199SEK', 'http://tubby.scene7.com/is/image/tubby/F2CU033BT06?$prod$', 'http://www.elgiganten.se/product/datorer-tillbehor/ovriga-datorprodukter/F2CU033BT06/belkin-usb-kabel-usb-c-till-micro-usb-2-m-svart', 'Webblager (100+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Datorer & Tillbehör', 'Elgiganten'),
(11, 'Electrolux Inspiration Spis EKC6351BIW400', 'Mångsidig spis med glaskeramisk spishäll som hjälper dig att laga din favoriträtt eller när du vill prova något nytt. Energiklass A.', '4990SEK', 'http://tubby.scene7.com/is/image/tubby/EKC6351BIW400?$prod$', 'http://www.elgiganten.se/product/vitvaror/spis/EKC6351BIW400/electrolux-inspiration-spis-ekc6351biw400', 'Webblager (50+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Vitvaror', 'Elgiganten'),
(12, 'Samsung 2.1 Soundbar HW-J561 (silver)', 'Samsung 2.1 HW-J561 är en soundbar med Bluetooth för trådlös anslutning till din TV. Du kan även streama musik trådlöst från dina mobila enheter.', '2490SEK', 'http://tubby.scene7.com/is/image/tubby/HWJ561?$prod$', 'http://www.elgiganten.se/product/ljud-bild/hemmabio-och-soundbar/HWJ561/samsung-2-1-soundbar-hw-j561-silver', 'Webblager (50+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Ljud & Bild', 'Elgiganten'),
(13, 'HP 15-ay087no 15.6" Bärbar dator (grå)', 'Med effektiv Intel Core i3-processor, stor 15,6" Full HD-skärm och lyhörd SSD-enhet ser denna bärbara dator HP 15-ay087no till att jobbet blir gjort. Den rejäla batteritiden ger upp till 8 timmars användning.', '3690SEK', 'http://tubby.scene7.com/is/image/tubby/HP15AY087NO?$prod$', 'http://www.elgiganten.se/product/datorer-tillbehor/barbar-dator/HP15AY087NO/hp-15-ay087no-15-6-barbar-dator-gra', 'Webblager (100+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Datorer & Tillbehör', 'Elgiganten'),
(14, 'BenQ 3D Projektor BQW1350', 'Denna projektor från Benq passar bra för familjeunderhållning och har mängder av anpassningsmöjligheter för olika typer av miljöer. Medföljande 3D-glasögon.', '7290SEK', 'http://tubby.scene7.com/is/image/tubby/BQW1350?$prod$', 'http://www.elgiganten.se/product/ljud-bild/projektor-och-projektorduk/BQW1350/benq-3d-projektor-bqw1350', 'Webblager (100+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Ljud & Bild', 'Elgiganten'),
(15, 'Konig KNM-PM20 Takfäste projektor (svart)', 'Praktiskt projektorfäste som är enkelt att fästa på väggen eller i taket. Det kan justeras på längden, har full 360° rotation och stöttar max 10 kg.', '799SEK', 'http://tubby.scene7.com/is/image/tubby/KNMPM20?$prod$', 'http://www.elgiganten.se/product/ljud-bild/vaggfaste/KNMPM20/konig-knm-pm20-takfaste-projektor-svart', 'Webblager (5+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Ljud & Bild', 'Elgiganten'),
(16, 'Arkitect Fast Väggfäste till TV 10" -37"', 'Fast väggfäste till TV med storlek 10" - 37". VESA: 75 x 75 - 200 x 200 mm.', '199SEK', 'http://tubby.scene7.com/is/image/tubby/ATVBFS14?$prod$', 'http://www.elgiganten.se/product/ljud-bild/vaggfaste/ATVBFS14/arkitect-fast-vaggfaste-till-tv-10-37', 'Webblager (100+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Ljud & Bild', 'Elgiganten'),
(17, 'Samsung Väggfäste (400 x 400) WMN3000BX', 'Väggfäste till Samsung TV för en slimmad och tight installation av teven på väggen.', '799SEK', 'http://tubby.scene7.com/is/image/tubby/WMN3000BXXC?$prod$', 'http://www.elgiganten.se/product/ljud-bild/vaggfaste/WMN3000BXXC/samsung-vaggfaste-400-x-400-wmn3000bx', 'Webblager (25+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Ljud & Bild', 'Elgiganten'),
(18, 'Electrolux Tvättmaskin FW31K7146', 'Denna moderna tvättmaskin från Electrolux kommer med snabbtvätt och en SoftCare trumma för varsam hantering av dina kläder.', '3333SEK', 'http://tubby.scene7.com/is/image/tubby/FW31K7146?$prod$', 'http://www.elgiganten.se/product/vitvaror/tvattmaskin/FW31K7146/electrolux-tvattmaskin-fw31k7146', 'Webblager (100+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Vitvaror', 'Elgiganten'),
(19, 'Jabra Sport Pace Trådlösa hörlurar (gul)', 'Ta din träning till nästa nivå och slipp ha en irriterande kabel i vägen. Bekväma, ergonomiska, trådlösa och med en dedikerad app som gör att du kan få information om tempo, distans och brända kalorier uppläst direkt i hörlurarna.', '799SEK', 'http://tubby.scene7.com/is/image/tubby/JABRAPACEYEL?$prod$', 'http://www.elgiganten.se/product/ljud-bild/horlurar/JABRAPACEYEL/jabra-sport-pace-tradlosa-horlurar-gul', 'Webblager (100+) \n \n Boka nu, hämta i varuhus om 2 timmar \r\nFinns i lager i', 'Ljud & Bild', 'Elgiganten');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE IF NOT EXISTS `feedback` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `opinion` varchar(16) NOT NULL,
  `comments` varchar(512) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `time_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `inet`
--

CREATE TABLE IF NOT EXISTS `inet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `price` varchar(16) NOT NULL,
  `image` varchar(512) NOT NULL,
  `url` varchar(512) NOT NULL,
  `status` varchar(128) DEFAULT NULL,
  `category` varchar(32) DEFAULT NULL,
  `company` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `netonnet`
--

CREATE TABLE IF NOT EXISTS `netonnet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `price` varchar(16) NOT NULL,
  `image` varchar(512) NOT NULL,
  `url` varchar(512) NOT NULL,
  `status` varchar(128) DEFAULT NULL,
  `category` varchar(32) DEFAULT NULL,
  `company` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `prod_reg_index`
--

CREATE TABLE IF NOT EXISTS `prod_reg_index` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reg_email` varchar(128) NOT NULL,
  `time_registered` datetime NOT NULL,
  `prod_title` varchar(128) DEFAULT NULL,
  `prod_url` varchar(512) NOT NULL,
  `prod_category` varchar(32) DEFAULT NULL,
  `price_min` int(7) NOT NULL,
  `price_max` int(7) NOT NULL,
  `emailed` enum('True','False') NOT NULL DEFAULT 'False',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=176 ;

--
-- Dumping data for table `prod_reg_index`
--

INSERT INTO `prod_reg_index` (`id`, `reg_email`, `time_registered`, `prod_title`, `prod_url`, `prod_category`, `price_min`, `price_max`, `emailed`) VALUES
(121, 'zkwisjoe@hotmail.com', '2016-06-08 02:03:22', '', 'http://www.elgiganten.se/product/hem-och-hushall/grill-och-sommarprodukter/MS1800BLACK/robomow-robotgrasklippare-ms1800', NULL, 0, 17000, 'True'),
(122, 'zkwisjoe@hotmail.com', '2016-06-08 02:04:03', '', 'http://www.elgiganten.se/product/hem-och-hushall/grill-och-sommarprodukter/KG2150242/nordic-season-smogen-kolgrill-kg2150242', NULL, 100, 500, 'False'),
(126, 'zkw20080810@gmail.com', '2016-06-10 11:04:30', '', 'https://www.inet.se/produkt/v100635/trekstor-surftab-twin-10-1-windows-10/#merinfo', NULL, 0, 1500, 'False'),
(127, 'zkw20080810@gmail.com', '2016-06-10 11:14:42', '', 'https://www.inet.se/produkt/1517136/taurus-limited-gtx-970/#specs', NULL, 0, 8000, 'False'),
(128, 'zkw20080810@gmail.com', '2016-06-10 11:16:29', '', 'https://www.inet.se/produkt/1960148/asus-n552vx-i7-8gb-128gb-ssd-1tb-hdd-gtx-950m/#specs', NULL, 0, 9000, 'False'),
(129, 'zkw20080810@gmail.com', '2016-06-10 16:27:09', '', 'https://www.inet.se/produkt/1978173/acer-aspire-r5-471t-i7-8gb-512gb-ssd-360/#merinfo', NULL, 0, 3333, 'False'),
(130, 'zkw20080810@gmail.com', '2016-06-10 16:32:05', '', 'http://www.elgiganten.se/product/ljud-bild/tv/UE55KU6075XXE/samsung-55-4k-uhd-smart-tv-ue55ku6075', NULL, 0, 44444, 'True'),
(131, 'zkwisjoe@hotmail.com', '2016-06-10 16:32:45', '', 'http://www.elgiganten.se/product/ljud-bild/tv/UE55KU6075XXE/samsung-55-4k-uhd-smart-tv-ue55ku6075', NULL, 0, 44444, 'True'),
(132, 'zkw20080810@gmail.com', '2016-06-12 12:19:08', '', 'https://www.netonnet.se/art/startpage/electrolux-zuoorigwr/215499.4790/', NULL, 0, 1700, 'False'),
(133, 'zkw20080810@gmail.com', '2016-06-12 12:32:47', '', 'https://www.netonnet.se/art/hemhushall/dammsugare/tillbehor/swirl-doftkulor-fruktblandning/122788.9268/', NULL, 0, 15, 'False'),
(134, 'zkw20080810@gmail.com', '2016-06-12 12:40:40', '', 'https://www.netonnet.se/art/hemhushall/dammsugare/dammsugarpasar/andersson-a9312/188224.9267/', NULL, 0, 90, 'False'),
(135, 'zkw20080810@gmail.com', '2016-06-12 12:43:59', '', 'https://www.netonnet.se/art/foto/systemkamera/nikon-d5300-af-p-18-55-vr/227862.9026/', NULL, 0, 5555, 'False'),
(136, 'zkw20080810@gmail.com', '2016-06-12 12:49:01', '', 'https://www.netonnet.se/art/foto/vaska/andersson-cab-20-small/168454.9030/', NULL, 0, 255, 'False'),
(137, 'zkwisjoe@hotmail.com', '2016-06-15 23:37:51', '', 'http://www.mediamarkt.se/sv/product/_sony-playstation-4-inkl-2st-handkontroller-och-pes-16-500-gb-1287011.html', NULL, 0, 3400, 'False'),
(138, 'zkw20080810@gmail.com', '2016-06-17 01:01:10', '', 'http://www.elgiganten.se/product/datorer-tillbehor/datorhogtalare/LTZ623/logitech-z623-datorhogtalare', NULL, 0, 1000, 'False'),
(139, 'zkw20080810@gmail.com', '2016-06-17 01:08:38', '', 'http://www.elgiganten.se/product/datorer-tillbehor/datorhogtalare/LTZ906/logitech-hogtalarsystem-z906', NULL, 0, 1500, 'False'),
(140, 'zkw20080810@gmail.com', '2016-06-28 01:49:59', NULL, 'https://developers.google.com/ /web/api/rest/latest/people/get#examples', NULL, 0, 99, 'False'),
(141, 'zkw20080810@gmail.com', '2016-06-28 01:50:42', NULL, 'https://developers.google.com/ /web/api/rest/latest/people/get#examples', NULL, 0, 300, 'False'),
(146, 'ilovejia0407@gmail.com', '2016-06-28 14:45:31', NULL, 'http://www.elgiganten.se/product/datorer-tillbehor/ipad-surfplatta/IPADMGL12KNA/ipad-air-2-16-gb-wifi-gra', NULL, 0, 2500, 'False'),
(147, 'ilovejia0407@gmail.com', '2016-06-28 14:58:30', NULL, 'http://www.elgiganten.se/product/datorer-tillbehor/ovriga-datorprodukter/LFIBRIDGE16GB/leef-ibridge-16-gb-usb-minne-med-lightning-kontakt', NULL, 0, 400, 'False'),
(148, 'ilovejia0407@gmail.com', '2016-06-28 17:14:28', NULL, 'http://www.elgiganten.se/product/datorer-tillbehor/ovriga-datorprodukter/F2CU033BT06/belkin-usb-kabel-usb-c-till-micro-usb-2-m-svart', NULL, 0, 150, 'False'),
(151, 'ilovejia0407@gmail.com', '2016-06-28 19:49:22', NULL, 'https://github.com/GoogleChrome/chrome-app-samples/blob/master/samples/github-auth/index.js', NULL, 0, 77, 'False'),
(152, 'ilovejia0407@gmail.com', '2016-06-28 19:53:57', NULL, 'https://developers.google.com/identity/protocols/googlescopes#playmoviespartnerv1', NULL, 0, 77, 'False'),
(154, 'ilovejia0407@gmail.com', '2016-06-28 20:25:03', NULL, 'http://www.elgiganten.se/product/vitvaror/spis/EKC6351BIW400/electrolux-inspiration-spis-ekc6351biw400', NULL, 0, 4000, 'False'),
(155, 'ilovejia0407@gmail.com', '2016-06-28 20:59:28', NULL, 'http://www.webhallen.com/se-sv/spel/pc/231293-total_war_warhammer_limited_edition', NULL, 0, 450, 'False'),
(156, 'zkwisjoe@hotmail.com', '2016-08-02 14:18:46', '', 'http://www.elgiganten.se/product/ljud-bild/tv/UE60J6285XXE/samsung-60-full-hd-smart-tv-ue60j6285xxe', NULL, 0, 10000, 'False'),
(157, 'zkw20080810@gmail.com', '2016-08-02 14:29:00', '', 'http://www.elgiganten.se/product/mobil-tele-gps/mobiltelefoner/APPIP6P16BCPO/iphone-6-plus-16-gb-apple-certified-pre-owned-rymdgra', NULL, 0, 5000, 'False'),
(158, 'zkwisjoe@hotmail.com', '2016-08-02 14:44:16', '', 'http://www.elgiganten.se/product/mobil-tele-gps/mobiltelefoner/APPIP6P16BCPO/iphone-6-plus-16-gb-apple-certified-pre-owned-rymdgra', NULL, 0, 5000, 'False'),
(159, 'zkwisjoe@hotmail.com', '2016-08-02 15:13:10', '', 'http://www.elgiganten.se/product/mobil-tele-gps/mobiltelefoner/APPIP6S16BK/iphone-6s-16-gb-rymdgra', NULL, 0, 5500, 'False'),
(160, 'zkw20080810@gmail.com', '2016-08-02 15:23:09', '', 'http://www.elgiganten.se/product/mobil-tele-gps/mobiltelefoner/APPIP6S16BK/iphone-6s-16-gb-rymdgra', NULL, 0, 5500, 'False'),
(161, 'zkw20080810@gmail.com', '2016-08-02 15:30:31', '', 'http://www.elgiganten.se/product/mobil-tele-gps/mobiltelefoner/SAMG93532GBBK/samsung-galaxy-s7-edge-32gb-smartphone-svart', NULL, 0, 7000, 'False'),
(162, 'zkw20080810@gmail.com', '2016-08-02 15:40:29', '', 'http://www.elgiganten.se/product/mobil-tele-gps/mobiltelefoner/LGH850BK/lg-g5-smartphone-svart', NULL, 0, 4500, 'False'),
(163, 'zkwisjoe@hotmail.com', '2016-08-02 16:24:23', '', 'http://www.elgiganten.se/product/mobil-tele-gps/mobiltelefoner/LGH850BK/lg-g5-smartphone-svart', NULL, 0, 5000, 'False'),
(164, 'zkw20080810@gmail.com', '2016-08-02 16:26:11', '', 'http://www.elgiganten.se/product/mobil-tele-gps/mobiltelefoner/LGH735SI/lg-g4s-smartphone-silver', NULL, 0, 2000, 'False'),
(165, 'zkw20080810@gmail.com', '2016-08-02 16:28:08', '', 'http://www.elgiganten.se/product/ljud-bild/hemmabio-och-soundbar/HWJ561/samsung-2-1-soundbar-hw-j561-silver', NULL, 0, 2000, 'False'),
(166, 'zkw20080810@gmail.com', '2016-08-02 20:33:48', '', 'http://www.elgiganten.se/product/datorer-tillbehor/barbar-dator/HP15AY087NO/hp-15-ay087no-15-6-barbar-dator-gra', NULL, 0, 3500, 'False'),
(167, 'zkw20080810@gmail.com', '2016-08-02 21:05:57', NULL, 'http://www.elgiganten.se/product/ljud-bild/projektor-och-projektorduk/BQW1350/benq-3d-projektor-bqw1350', NULL, 0, 6000, 'False'),
(168, 'zkw20080810@gmail.com', '2016-08-02 21:10:11', NULL, 'http://www.elgiganten.se/product/ljud-bild/vaggfaste/KNMPM20/konig-knm-pm20-takfaste-projektor-svart', NULL, 0, 400, 'False'),
(169, 'zkw20080810@gmail.com', '2016-08-02 21:15:21', NULL, 'http://www.elgiganten.se/product/ljud-bild/vaggfaste/ATVBFS14/arkitect-fast-vaggfaste-till-tv-10-37', NULL, 0, 50, 'False'),
(170, 'zkw20080810@gmail.com', '2016-08-02 21:19:27', NULL, 'http://www.elgiganten.se/product/ljud-bild/vaggfaste/WMN3000BXXC/samsung-vaggfaste-400-x-400-wmn3000bx', NULL, 0, 500, 'False'),
(171, 'zkw20080810@gmail.com', '2016-08-02 22:40:42', NULL, 'http://www.elgiganten.se/product/ljud-bild/streaming-och-mediaspelare/APTV64GBND/apple-tv-mediaspelare-64-gb', NULL, 0, 1300, 'False'),
(172, 'zkw20080810@gmail.com', '2016-09-06 20:26:30', '', 'http://www.siba.se/spel-och-underhallning/pc-och-mac/spel-for-pc/pc-world-of-warcraft-legion-124978', NULL, 0, 250, 'False'),
(173, 'zkw20080810@gmail.com', '2016-09-06 21:05:13', '', 'http://www.elgiganten.se/product/vitvaror/tvattmaskin/FW31K7146/electrolux-tvattmaskin-fw31k7146', NULL, 0, 3000, 'False'),
(174, 'pricereminder.se@gmail.com', '2016-09-06 21:51:02', '', 'http://www.elgiganten.se/product/mobil-tele-gps/mobiltelefoner/APPIPSE64WH/iphone-se-64-gb-silver', NULL, 0, 4000, 'False'),
(175, 'pricereminder.se@gmail.com', '2016-09-06 21:51:54', '', 'http://www.elgiganten.se/product/ljud-bild/horlurar/JABRAPACEYEL/jabra-sport-pace-tradlosa-horlurar-gul', NULL, 0, 500, 'False');

-- --------------------------------------------------------

--
-- Table structure for table `siba`
--

CREATE TABLE IF NOT EXISTS `siba` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `price` varchar(16) NOT NULL,
  `image` varchar(512) NOT NULL,
  `url` varchar(512) NOT NULL,
  `status` varchar(128) DEFAULT NULL,
  `category` varchar(32) DEFAULT NULL,
  `company` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `password` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `time_registered` datetime DEFAULT NULL,
  `frequency` int(2) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `password`, `email`, `time_registered`, `frequency`, `last_login`) VALUES
(3, 'kewei', 'pbkdf2:sha1:1000$er7BifAh$5ea4045ce5a8519f6f068026e4a05d79ce2c254b', 'zkwisjoe@hotmail.com', NULL, 7, '2016-08-13 14:17:49'),
(5, 'kewei3', 'pbkdf2:sha1:1000$InZsAHHh$6877cf7ca704e6174aa46373add85dbf7a876386', 'zkw20080810@gmail.com', '2016-06-26 01:21:26', 7, '2016-09-06 21:54:31'),
(6, 'kw zhang', 'pbkdf2:sha1:1000$9zhmTOtQ$57f51b0832ee6a5d63bb7646b485b2f5fa927c7c', 'ilovejia0407@gmail.com', '2016-06-28 12:45:20', NULL, '2016-06-28 20:59:58'),
(7, 'Kewei Zhang', 'pbkdf2:sha1:1000$KbERLPtx$bd98ebb8687ac717b4a848aeb5db2967b90f2409', 'pricereminder.se@gmail.com', '2016-09-06 21:50:11', NULL, '2016-09-06 21:50:44');

-- --------------------------------------------------------

--
-- Table structure for table `webhallen`
--

CREATE TABLE IF NOT EXISTS `webhallen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `price` varchar(16) NOT NULL,
  `image` varchar(512) NOT NULL,
  `url` varchar(512) NOT NULL,
  `status` varchar(1200) DEFAULT NULL,
  `category` varchar(32) DEFAULT NULL,
  `company` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `webhallen`
--

INSERT INTO `webhallen` (`id`, `title`, `description`, `price`, `image`, `url`, `status`, `category`, `company`) VALUES
(18, 'Kingston Card Reader USB 3.0', 'Kingston Card Reader USB 3.0', '99SEK', 'http://images.webhallen.com/product/214244/large', 'http://www.webhallen.com/se-sv/datorer_och_tillbehor/214244-kingston_card_reader_usb_30?atcl=product:suggestions', 'Postorder   Fler än 50 st\\n InfraCity   Fler än 50 st\\n Hötorget   4 st\\n Fridhemsplan   3 st\\n Mall of Scandinavia   	Ej i lager\\n Liljeholmstorget   1 st\\n Kista Galleria   1 st\\n Farsta Centrum    	Ej i lager\\n Fruängen   2 st\\n Sickla Köpkvarter   	Ej i lager\\n Solna Business Park   1 st\\n Täby Centrum   1 st\\n Barkarby Handelsplats   1 st\\n Göteborg City   	Ej i lager\\n Göteborg Sisjön   	Ej i lager\\n Halmstad Flygstaden   1 st\\n Malmö City   	Ej i lager\\n Malmö Triangeln   1 st\\n Uppsala City   1 st\\n Linköping City   1 st\\n Västerås Erikslund   	Ej i lager\\n Hos leverantören  Fler än 50 st\\n', 'Datorer & Tillbehör', 'Webhallen'),
(19, 'Total War: Warhammer Limited Edition', 'Total War: Warhammer Limited Edition', '529SEK', 'http://images.webhallen.com/product/231293/large', 'http://www.webhallen.com/se-sv/spel/pc/231293-total_war_warhammer_limited_edition', 'Postorder   1 st\\n InfraCity   1 st\\n Hötorget   1 st\\n Fridhemsplan   5 st\\n Mall of Scandinavia   	Beställningsvara\\n Liljeholmstorget   1 st\\n Kista Galleria   1 st\\n Farsta Centrum    	Beställningsvara\\n Fruängen   3 st\\n Sickla Köpkvarter   	Beställningsvara\\n Solna Business Park   2 st\\n Täby Centrum   2 st\\n Barkarby Handelsplats   	Beställningsvara\\n Göteborg City   2 st\\n Göteborg Sisjön   1 st\\n Halmstad Flygstaden   	Beställningsvara\\n Malmö City   3 st\\n Malmö Triangeln   1 st\\n Uppsala City   4 st\\n Linköping City   5 st\\n Västerås Erikslund   	Beställningsvara\\n Hos leverantören  Ej i lager\\n', 'Spel', 'Webhallen');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
