# Amazoff - E-commerce Demo

Questo progetto è un sito web e-commerce di esempio chiamato "Amazoff". Segui le istruzioni per configurare l'ambiente e avviare il sito sul tuo server locale.

## Prerequisiti
- **XAMPP o un server locale** per eseguire MySQL e PHP.
- **Editor di codice** a tua scelta (consigliato: IntelliJ IDEA, VS Code, o un editor simile).

## Istruzioni di installazione

### 1. Scarica i file del progetto
Scarica e salva tutti i file di questo repository nel tuo computer. Assicurati di mantenere la struttura delle cartelle così come è.

### 2. Configura il database
Il file `amazooff.sql` contiene il codice SQL necessario per creare il database e le tabelle. Segui questi passaggi per configurare il database se usi mac:

1. **Apri phpMyAdmin**:
   - Apri XAMPP e avvia il servizio MySQL.
   - Vai su [http://localhost/phpmyadmin](http://localhost/phpmyadmin) nel tuo browser.

2. **Importa il database**:
   - Crea un nuovo database chiamato `amazooff`.
   - Vai alla scheda "Importa", seleziona il file `amazooff.sql`, e caricalo. Questo creerà le tabelle e i dati necessari.

### 3. Configura il progetto nel tuo editor
Consigliamo di creare un nuovo progetto nell'editor di tua scelta e di copiare i file del sito uno alla volta. Questo ti aiuterà a mantenere l’ordine e a risolvere eventuali problemi.

### 4. Avvia il sito
Dopo aver configurato il database e copiato i file del progetto:
- Assicurati che XAMPP sia in esecuzione con MySQL e Apache attivi.
- Vai su [http://localhost/NOME_CARTELLA](http://localhost/NOME_CARTELLA) nel browser per visualizzare il sito.

## Note
- Verifica che le configurazioni di connessione al database corrispondano ai tuoi dettagli di login (ad esempio, utente e password di MySQL).
- Se riscontri problemi, controlla i log di Apache e MySQL in XAMPP per ottenere maggiori dettagli sugli errori.

Buon lavoro con Amazoff!
