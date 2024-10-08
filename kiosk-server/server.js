const express = require('express');
const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');
const app = express();
const port = 3000;
const cors = require('cors');
const settingsFilePath = path.join(__dirname, 'current-settings.json');

app.use(cors());

// Funkcja zapisywania ustawień do pliku JSON
function saveSettings(url, interval) {
  const settings = {
    currentUrl: url,
    refreshInterval: interval
  };
  fs.writeFileSync(settingsFilePath, JSON.stringify(settings, null, 2));
}

// Funkcja ładowania ustawień z pliku JSON, tworząca plik, jeśli nie istnieje
function loadSettings() {
  if (fs.existsSync(settingsFilePath)) {
    return JSON.parse(fs.readFileSync(settingsFilePath, 'utf8'));
  }
  // Jeśli plik nie istnieje, ustaw domyślne wartości i zapisz plik
  const defaultSettings = {
    currentUrl: 'https://www.wp.pl', // Domyślny URL
    refreshInterval: 5 // Domyślny interwał odświeżania w sekundach
  };
  saveSettings(defaultSettings.currentUrl, defaultSettings.refreshInterval);
  return defaultSettings;
}

// Ładowanie ustawień z pliku na starcie
let { currentUrl, refreshInterval } = loadSettings();

app.use('/public', express.static('public'));

// Serwowanie strony z ustawionym URL i interwałem odświeżania
app.get('/', (req, res) => {
  res.send(`
    <html>
    <head>
      <meta http-equiv="refresh" content="${refreshInterval}; URL=${currentUrl}">
    </head>
    <body>
      <h1>Loading ${currentUrl}</h1>
    </body>
    </html>
  `);
});

// Endpoint zmiany URL
app.post('/change-url', express.json(), (req, res) => {
  const newUrl = req.body.url;
  currentUrl = newUrl;
  saveSettings(currentUrl, refreshInterval); // Zapisanie nowych ustawień lokalnie
  res.json({ message: `URL changed to: ${newUrl}` });

  // Restart kiosk service to apply the new URL
  exec('sudo systemctl restart kiosk.service', (error, stdout, stderr) => {
    if (error) {
      console.error(`Error restarting kiosk service: ${error.message}`);
      return;
    }
    if (stderr) {
      console.error(`Stderr: ${stderr}`);
      return;
    }
    console.log(`Kiosk service restarted: ${stdout}`);
  });
});

// Endpoint zmiany interwału odświeżania
app.post('/change-refresh', express.json(), (req, res) => {
  const newInterval = req.body.refresh;
  refreshInterval = newInterval;
  saveSettings(currentUrl, refreshInterval); // Zapisanie nowych ustawień lokalnie
  res.json({ message: `Refresh interval changed to: ${refreshInterval} seconds` });

  // Restart kiosk service to apply the new refresh interval
  exec('sudo systemctl restart kiosk.service', (error, stdout, stderr) => {
    if (error) {
      console.error(`Error restarting kiosk service: ${error.message}`);
      return;
    }
    if (stderr) {
      console.error(`Stderr: ${stderr}`);
      return;
    }
    console.log(`Kiosk service restarted: ${stdout}`);
  });
});

// Endpoint screenshot
app.get('/screen', (req, res) => {
  exec('DISPLAY=:0 scrot -o /home/n1copl/kiosk-server/public/scren123.png', (error, stdout, stderr) => {
    if (error) {
      console.error(`Error taking screenshot: ${error.message}`);
      res.status(500).send(`Error taking screenshot: ${error.message}`);
      return;
    }
    if (stderr) {
      console.error(`Stderr: ${stderr}`);
    }
    console.log(`Screenshot taken: ${stdout}`);
    res.send('Screenshot taken successfully.');
  });
});

// Endpoint restartu maliny
app.get('/reboot', (req, res) => {
  exec('sudo reboot', (error, stdout, stderr) => {
    if (error) {
      console.error(`Error restarting device: ${error.message}`);
      res.status(500).send(`Error restarting device: ${error.message}`);
      return;
    }
    if (stderr) {
      console.error(`Stderr: ${stderr}`);
    }
    console.log(`Device rebooted: ${stdout}`);
    res.send('Device rebooted successfully.');
  });
});

// Endpoint pokazujący aktualny URL i interwał odświeżania
app.get('/showurl', (req, res) => {
  res.json({ currentUrl, refreshInterval });
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
