-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 30, 2017 at 09:21 AM
-- Server version: 5.5.49-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `local-website`
--

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE IF NOT EXISTS `blogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` enum('web_design','python','php','gps','wireless') NOT NULL,
  `title` varchar(256) NOT NULL,
  `content` text NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `blogs`
--

INSERT INTO `blogs` (`id`, `category`, `title`, `content`, `time`) VALUES
(13, 'web_design', 'Embeded Editor', '<p>In this website, I use&nbsp;<a href="https://www.tinymce.com/">TinyMCE</a>, which is easy and nice tool for online editor. It supports many plugins, such as link, image, print, table, etc.&nbsp;</p>\r\n<p>The basic usage is:</p>\r\n<ul>\r\n<li>Add script source to your html header</li>\r\n<li>Use javascript to load the editor</li>\r\n</ul>\r\n<pre class="prettyprint prettyprinted"><code class="language-html" data-lang="html"><span class="nt"><span class="tag">&lt;pre</span></span> <span class="na"><span class="atn">class</span><span class="pun">=</span></span><span class="s"><span class="atv">"language-markup"</span></span><span class="nt"><span class="tag">&gt;&lt;code&gt;&lt;script type="text/javascript"&gt;<br /> tinymce.init({<br /> selector: ''textarea'',<br /> plugins: [<br /> ''advlist autolink lists link image charmap print preview anchor'',<br /> ''searchreplace visualblocks code fullscreen'',<br /> ''insertdatetime media table contextmenu paste code''<br /> ],<br /> toolbar: ''insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image'',<br /> content_css: [<br /> ''//fast.fonts.net/cssapi/e6dc9b99-64fe-4292-ad98-6974f93cd2a2.css'',<br /> ''//www.tinymce.com/css/codepen.min.css''<br /> ]<br /> });<br /> &lt;/script&gt;</span></span><span class="nt"><span class="tag">&lt;/code&gt;&lt;/pre&gt;</span></span></code></pre>', '2016-07-05 14:44:29');

-- --------------------------------------------------------

--
-- Table structure for table `blog_comments`
--

CREATE TABLE IF NOT EXISTS `blog_comments` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `blog_id` int(10) NOT NULL,
  `comment_user_id` varchar(256) NOT NULL,
  `comment_content` text NOT NULL,
  `comment_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `blog_comments`
--

INSERT INTO `blog_comments` (`id`, `blog_id`, `comment_user_id`, `comment_content`, `comment_time`) VALUES
(3, 5, '1233249816685365', 'Great comment', '2016-05-25 20:01:29'),
(4, 5, '1233249816685365', 'A comment', '2016-05-25 20:13:45'),
(5, 5, '1233249816685365', 'Another one', '2016-05-25 20:15:38'),
(12, 5, '1233249816685365', 'TATAATTTATAT', '2016-05-26 12:22:52');

-- --------------------------------------------------------

--
-- Table structure for table `ci_session`
--

CREATE TABLE IF NOT EXISTS `ci_session` (
  `id` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0',
  `data` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ci_session_timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ci_session`
--

INSERT INTO `ci_session` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('0096970ace38709bdf9df8a3c8fc79da42afb46d', '127.0.0.1', 1467727414, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732373138353b6c6f676765645f696e7c613a323a7b733a323a226964223b733a313a2231223b733a383a22757365726e616d65223b733a353a226b65776569223b7d),
('0150e4940785c6b2e7b0ab3335bd5c9d1a6cc008', '130.237.43.78', 1468240356, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436383234303333363b),
('04dc78801caf433522fbec92f01e0da80ba3cf72', '127.0.0.1', 1467727085, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732363831373b),
('06a7ee93f58e1cb4618b7009698fada4ec335261', '127.0.0.1', 1467728089, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732383036393b),
('110f3907215a7a3e48d2dc522c1482f05d758c1b', '130.237.43.78', 1467900510, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373930303237313b),
('169b5271d00fc47d3b307d217b8ee664ccb3fe9e', '130.237.43.78', 1467898962, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373839383832303b),
('18607b811b7256ec7a6a35320390c2f859beea9f', '130.237.43.78', 1467974576, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373937343531343b),
('199091dc1073365730bb435a692d44b075d08f2d', '130.237.43.78', 1467975349, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373937353035393b),
('2a21275b52c926e4b5e2eddbc984de153ced60e0', '127.0.0.1', 1467727672, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732373533373b6c6f676765645f696e7c613a323a7b733a323a226964223b733a313a2231223b733a383a22757365726e616d65223b733a353a226b65776569223b7d),
('2ab0cab2edeefab98f3d83d7baeb0b57093f42d5', '127.0.0.1', 1467725865, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732353539323b6c6f676765645f696e7c613a323a7b733a323a226964223b733a313a2231223b733a383a22757365726e616d65223b733a353a226b65776569223b7d),
('2b738185aa5a76200b640b1bced1311acae014ab', '127.0.0.1', 1467726801, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732363631363b6c6f676765645f696e7c613a323a7b733a323a226964223b733a313a2231223b733a383a22757365726e616d65223b733a353a226b65776569223b7d),
('2e866579709d80af096074d33c1731acaad5b634', '127.0.0.1', 1467728482, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732383438323b),
('30ef3684a48b74b8e762efd2ad4b51b032955253', '127.0.0.1', 1467728761, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732383538373b),
('31048d29702a75a3dfdf2098f385631dea203ab1', '127.0.0.1', 1467731455, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373733313435353b),
('34653e8604f5f6cfc98cd27ad713f2b888a41319', '130.237.43.78', 1468240359, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436383234303334303b),
('358734ea2abce9880a1400ac7ff9c35bf1606940', '127.0.0.1', 1467721790, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732313530373b6c6f676765645f696e7c613a323a7b733a323a226964223b733a313a2231223b733a383a22757365726e616d65223b733a353a226b65776569223b7d),
('436bbb451c3bd854374ea651011b72125272072e', '130.237.43.78', 1467900057, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373839393737313b),
('474aad87baa95673cbcfcdc13e940f5f18f3776e', '130.237.43.78', 1467973464, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373937333139393b),
('47dd0479a8c7df41346f26ff4382df4db2f459d7', '130.237.43.78', 1467900764, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373930303734353b),
('4a46c356d7c66cc9e58e64c2eb99be39c00803c0', '127.0.0.1', 1467729566, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732393436383b),
('52c3a59dea76336075c03c3551642d5639291573', '127.0.0.1', 1467725236, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732353231303b6c6f676765645f696e7c613a323a7b733a323a226964223b733a313a2231223b733a383a22757365726e616d65223b733a353a226b65776569223b7d),
('6d38d424370a4b0431039afd4fd18f0aa320fe23', '130.237.43.78', 1467973822, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373937333537373b),
('71a2d29b97cd718ef6a6b16150386007ad791ec7', '130.237.43.78', 1467975401, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373937353339343b),
('7655bc47ef6ee662baabb24e6d0fbce84f264c39', '127.0.0.1', 1467719590, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373731393333383b),
('822f00a42d29b95c08adb6f407809645fb5cc590', '127.0.0.1', 1467727159, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732373135393b),
('831b8a4f4a98c0d99a1ae768307aebe9dcb34f3b', '127.0.0.1', 1467729855, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732393739363b),
('852c761c4c43fd810a2cf8250f28f958bdbe470e', '130.237.43.78', 1467903890, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373930333838363b),
('88e01848ac7fc8b55ff1ecfe2ec74df2696872a9', '130.237.43.78', 1467899346, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373839393332363b),
('8a343172824df4f51c38008367a030822e7c4735', '127.0.0.1', 1467721912, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732313834363b6c6f676765645f696e7c613a323a7b733a323a226964223b733a313a2231223b733a383a22757365726e616d65223b733a353a226b65776569223b7d),
('92c521493fa1989f91c90599d19e97f94ab60791', '130.229.190.154', 1467975042, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373937353032323b),
('937e8a9f872c6142d04e38ce2f1b12b29cea4bea', '130.237.43.78', 1467974257, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373937343130353b),
('a3af856f331c50f4e7938e30b2b71a6d81b13325', '127.0.0.1', 1467720545, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732303235353b6c6f676765645f696e7c613a323a7b733a323a226964223b733a313a2231223b733a383a22757365726e616d65223b733a353a226b65776569223b7d),
('a8bd05b79fecfe26fec4c705549d5f431e52c0f8', '127.0.0.1', 1467721113, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732313033363b6c6f676765645f696e7c613a323a7b733a323a226964223b733a313a2231223b733a383a22757365726e616d65223b733a353a226b65776569223b7d),
('b144f9e784be58d826733961870aee699e658427', '127.0.0.1', 1467732984, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373733323930363b),
('bf7521693be1978e4028c5b7c2eaedd3ef58a22e', '127.0.0.1', 1467723598, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732333530373b6c6f676765645f696e7c613a323a7b733a323a226964223b733a313a2231223b733a383a22757365726e616d65223b733a353a226b65776569223b7d),
('c3563ac1ceb3ed611492199c6fbd9b91482c6c46', '130.237.43.78', 1467972276, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373937323236383b),
('c7dc8e3b6e09b3f2554193da4bca051af88f3227', '127.0.0.1', 1467719730, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373731393634303b),
('cccf3ba4c482c05404914270259c695dce9e95aa', '127.0.0.1', 1467728262, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732383236323b),
('d272b19ab093788748b71363642dcfd7212e967c', '127.0.0.1', 1467722941, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732323636393b6c6f676765645f696e7c613a323a7b733a323a226964223b733a313a2231223b733a383a22757365726e616d65223b733a353a226b65776569223b7d),
('d7c457cd8e1e83e5ddc28328e18ada8d31685905', '130.237.43.78', 1467981180, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373938313136323b),
('df60675b3c8093b8953dba6370198520d4718f04', '127.0.0.1', 1467724155, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732333938383b6c6f676765645f696e7c613a323a7b733a323a226964223b733a313a2231223b733a383a22757365726e616d65223b733a353a226b65776569223b7d),
('e7f63f0a676e3e29677df0ae62d208497253c76c', '127.0.0.1', 1467726192, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732353932363b6c6f676765645f696e7c613a323a7b733a323a226964223b733a313a2231223b733a383a22757365726e616d65223b733a353a226b65776569223b7d),
('f18cf58cffb528c5a3e6a98a879e7c211a0e1501', '127.0.0.1', 1467724524, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732343338323b6c6f676765645f696e7c613a323a7b733a323a226964223b733a313a2231223b733a383a22757365726e616d65223b733a353a226b65776569223b7d),
('f642f502806757bfa18cc96ddcb901a811eba83e', '127.0.0.1', 1467726554, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732363239373b6c6f676765645f696e7c613a323a7b733a323a226964223b733a313a2231223b733a383a22757365726e616d65223b733a353a226b65776569223b7d),
('fa577ca9bddf032de86e0ca6679a78845813f778', '127.0.0.1', 1467729090, 0x5f5f63695f6c6173745f726567656e65726174657c693a313436373732383933303b);

-- --------------------------------------------------------

--
-- Table structure for table `contact_records`
--

CREATE TABLE IF NOT EXISTS `contact_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `email` varchar(128) NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=30 ;

--
-- Dumping data for table `contact_records`
--

INSERT INTO `contact_records` (`id`, `name`, `phone`, `email`, `message`) VALUES
(1, 'afa', 'aa', 'ag@ag.com', 'ahfahgfa'),
(2, 'afa', 'aa', 'ag@ag.com', 'ahfahgfa'),
(3, 'afd', 'aaga', 'agag@aga', 'agagaagaga'),
(4, 'afd', 'aaga', 'agag@aga', 'agagaagaga'),
(5, 'agda', 'agagag', 'agdagag', 'agagaga'),
(6, 'agda', 'agagag', 'agdagag', 'agagaga'),
(7, 'agda', 'agagag', 'agdagag', 'agagaga'),
(8, 'agda', 'agagag', 'agdagag', 'agagaga'),
(9, 'agda', 'agagag', 'agdagag', 'agagaga'),
(10, 'agda', 'agagag', 'agdagag', 'agagaga'),
(11, 'agda', 'agagag', 'agdagag', 'agagaga'),
(12, 'agda', 'agagag', 'agdagag', 'agagaga'),
(13, 'agda', 'agagag', 'agdagag', 'agagaga'),
(14, 'agda', 'agagag', 'agdagag', 'agagaga'),
(15, 'agda', 'agagag', 'agdagag', 'agagaga'),
(16, 'agda', 'agagag', 'agdagag', 'agagaga'),
(17, 'agda', 'agagag', 'agdagag', 'agagaga'),
(18, 'agda', 'agagag', 'agdagag', 'agagaga'),
(19, 'agda', 'agagag', 'agdagag', 'agagaga'),
(20, 'ga', 'agfg', 'ag@ag.com', 'ahghagahg'),
(21, 'ga', 'agfg', 'ag@ag.com', 'ahghagahg'),
(22, 'ga', 'agfg', 'ag@ag.com', 'ahghagahg'),
(23, '', '', '', ''),
(24, '', '', '', ''),
(25, '', '', '', ''),
(26, 'aaf', 'agfag', 'ag@ag.com', 'agfagagag'),
(27, '', '', '', ''),
(28, '', '', '', ''),
(29, '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `fb_login_users`
--

CREATE TABLE IF NOT EXISTS `fb_login_users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `user_id` varchar(256) NOT NULL,
  `email` varchar(128) DEFAULT NULL,
  `login_time` datetime DEFAULT NULL,
  `profile_picture` varchar(512) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `fb_login_users`
--

INSERT INTO `fb_login_users` (`id`, `name`, `user_id`, `email`, `login_time`, `profile_picture`) VALUES
(6, 'Kewei Zhang', '1233249816685365', NULL, '2016-05-25 20:37:08', 'https://scontent.xx.fbcdn.net/v/t1.0-1/c210.43.539.539/s50x50/960090_624440884232931_566155949_n.jpg?oh=74b3d50e2d3178ce1b4dca4e553bbbdc&oe=57D24E18'),
(7, 'Kewei Zhang', '1233249816685365', NULL, '2016-05-26 12:22:52', 'https://scontent.xx.fbcdn.net/v/t1.0-1/c210.43.539.539/s50x50/960090_624440884232931_566155949_n.jpg?oh=74b3d50e2d3178ce1b4dca4e553bbbdc&oe=57D24E18');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` tinyint(6) NOT NULL AUTO_INCREMENT,
  `username` varchar(10) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'kewei', 'b50c20267ad5d102dabc2f214fe8eb4a');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
