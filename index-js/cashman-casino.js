const axios = require('axios');
const cheerio = require('cheerio');
const fs = require('fs');
const path = require('path');

const url = 'https://techyhigher.com/cashman-casino-free-coins/';

axios.get(url)
  .then(({ data }) => {
    const $ = cheerio.load(data);
    const links = [];

    $('a[href*="bit.ly"], a[href*="cashman.rocks"], a[href*="cm.onelink.me"]').each((index, element) => {
if (links.length >= 100) {
        return false; // Break out of the loop if we have 100 links
      }
      const link = $(element).attr('href');
      const text = $(element).text().trim();
      links.push({ href: link, text: text });
    });

    console.log('Fetched links:', links);

    const dir = 'links-json';
    if (!fs.existsSync(dir)){
      fs.mkdirSync(dir);
    }

    const filePath = path.join(dir, 'cashman-casino.json');
    fs.writeFileSync(filePath, JSON.stringify(links, null, 2), 'utf8');
    console.log(`Links saved to ${filePath}`);
  })
  .catch(err => {
    console.error('Error fetching links:', err);
    process.exit(1);
  });
