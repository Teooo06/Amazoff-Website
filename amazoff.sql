-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Creato il: Nov 07, 2024 alle 20:16
-- Versione del server: 10.4.28-MariaDB
-- Versione PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `amazoff`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `acquisti`
--

CREATE TABLE `acquisti` (
  `idAcquisto` int(11) NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `idProdotto` varchar(20) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `costo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dump dei dati per la tabella `acquisti`
--

INSERT INTO `acquisti` (`idAcquisto`, `username`, `idProdotto`, `data`, `costo`) VALUES
(1, 'marco', 'S09', '2024-03-28', 150),
(2, 'luca', 'I12', '2024-03-25', 200),
(3, 'marco', 'HPs15', '2024-02-12', 800),
(4, 'paolo', 'S09', '2024-10-25', 200),
(5, 'federico', 'S09', '2024-10-26', 200),
(6, 'marco', 'HPS15', '2024-10-27', 800),
(7, 'matteo', 'I15', '2024-10-31', 1500);

-- --------------------------------------------------------

--
-- Struttura della tabella `carrello`
--

CREATE TABLE `carrello` (
  `idAcquisto` int(11) NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `idProdotto` varchar(20) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `costo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dump dei dati per la tabella `carrello`
--

INSERT INTO `carrello` (`idAcquisto`, `username`, `idProdotto`, `data`, `costo`) VALUES
(1, 'marco', 'I12', '2024-10-25', 200),
(2, 'luca', 'HPs15', '2024-10-26', 790),
(3, 'marco', 'I12', '2024-10-27', 175),
(14, 'marco', 'I15', '2024-10-31', 1500),
(15, 'marco', 'I15', '2024-10-31', 1500);

-- --------------------------------------------------------

--
-- Struttura della tabella `prodotto`
--

CREATE TABLE `prodotto` (
  `id` varchar(20) NOT NULL,
  `descrizione` varchar(50) DEFAULT NULL,
  `prezzo` int(11) DEFAULT NULL,
  `categoria` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dump dei dati per la tabella `prodotto`
--

INSERT INTO `prodotto` (`id`, `descrizione`, `prezzo`, `categoria`) VALUES
('djiair3s', 'DJI Air 3S Combo Fly More (RC-N3)', 1410, 'Droni'),
('djimini4', 'DJI Mini 4 Pro Fly More Combo con DJI RC 2', 1116, 'Droni'),
('HPS15', 'HP Pavillon Ryzen 7', 820, 'Portatili'),
('I12', 'IPhone X', 400, 'Telefonia'),
('I15', 'iPhone 15 Pro Max', 1500, 'Telefonia'),
('MacA15M3', 'MacBook Air 15', 1700, 'Portatili'),
('S09', 'Samsung Galaxy S9', 200, 'Telefonia');

-- --------------------------------------------------------

--
-- Struttura della tabella `utenti`
--

CREATE TABLE `utenti` (
  `username` varchar(30) NOT NULL,
  `password` varchar(30) DEFAULT NULL,
  `cognome` varchar(30) DEFAULT NULL,
  `nome` varchar(30) DEFAULT NULL,
  `citta` varchar(30) DEFAULT NULL,
  `datanascita` date DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dump dei dati per la tabella `utenti`
--

INSERT INTO `utenti` (`username`, `password`, `cognome`, `nome`, `citta`, `datanascita`, `email`, `admin`) VALUES
('federico', 'pallina', 'Neri', 'Federico', 'Troia', '2009-04-17', 'pietropike@gmail.com', 0),
('luca', 'segreta', 'Rossi', 'Luca', 'Milano', '1995-12-05', 'test@tes.t', 0),
('marco', 'segreta', 'D\'Amato', 'marco', 'Lecco', '2010-04-03', 'test@tes.t', 0),
('matteo', 'segreta', 'Bertoldini', 'Matteo', 'Premana', '2006-06-07', 'matteobertoldini06@gmail.com', 1),
('paolo', 'segreta', 'Bianchi', 'Paolo', 'Lecco', '2019-04-03', 'test@tes.t', 0);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `acquisti`
--
ALTER TABLE `acquisti`
  ADD PRIMARY KEY (`idAcquisto`);

--
-- Indici per le tabelle `carrello`
--
ALTER TABLE `carrello`
  ADD PRIMARY KEY (`idAcquisto`);

--
-- Indici per le tabelle `prodotto`
--
ALTER TABLE `prodotto`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indici per le tabelle `utenti`
--
ALTER TABLE `utenti`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `acquisti`
--
ALTER TABLE `acquisti`
  MODIFY `idAcquisto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT per la tabella `carrello`
--
ALTER TABLE `carrello`
  MODIFY `idAcquisto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
